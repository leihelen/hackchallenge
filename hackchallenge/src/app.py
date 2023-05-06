import json
from db import db
from flask import Flask, request
from db import User, Reviews, Dining_hall
import users_dao

from datetime import datetime
import datetime

app = Flask(__name__)
db_filename = "food.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code

def extract_token(request):
    """
    Helper function that extracts the token from the header of a request
    """
    auth_header = request.headers.get("Authorization")
    if auth_header is None:
        return False, json.dumps({"error": "missing auth header"})
    bearer_token = auth_header.replace("Bearer", "").strip()
    if not bearer_token:
        return False, json.dumps({"error": "invalid auth header"})
    return True, bearer_token


@app.route("/register/", methods=["POST"])
def register_account():
    """
    Endpoint for registering a new user
    """
    body = json.loads(request.data)
    username = body.get("username")
    password = body.get("password")

    if username is None or password is None:
        return json.dumps({"error": "Invalid username or password"})

    created, user = users_dao.create_user(username, password)

    if not created:
        return json.dumps({"error": "User already exists."})

    return json.dumps(
        {
            "session_token": user.session_token,
            "session_expiration": str(user.session_expiration),
            "update_token": user.update_token,
        }
    )


@app.route("/login/", methods=["POST"])
def login():
    """
    Endpoint for logging in a user
    """
    body = json.loads(request.data)
    username = body.get("username")
    password = body.get("password")

    if username is None or password is None:
        return json.dumps({"error": "Invalid username or password"}), 400

    success, user = users_dao.verify_credentials(username, password)

    if not success:
        return json.dumps({"error": "incorrect username or password"}), 400

    return json.dumps(
        {
            "session_token": user.session_token,
            "session_expiration": str(user.session_expiration),
            "update_token": user.update_token,
        }
    )


@app.route("/session/", methods=["POST"])
def update_session():
    """
    Endpoint for updating a user's session
    """
    success, update_token = extract_token(request)

    if not success:
        return update_token

    user = users_dao.renew_session(update_token)

    if user is None:
        return json.dumps({"error": "invalid update token"})

    return json.dumps(
        {
            "session_token": user.session_token,
            "session_expiration": str(user.session_expiration),
            "update_token": user.update_token,
        }
    )


@app.route("/secret/", methods=["POST"])
def secret_message():
    """
    Endpoint for verifying a session token and returning a secret message

    In your project, you will use the same logic for any endpoint that needs 
    authentication
    """
    success, session_token = extract_token(request)

    if not success:
        return session_token
    user = users_dao.get_user_by_session_token(session_token)
    if user is None or not user.verify_session_token(session_token):
        return json.dumps({"error": "invalid session token"})
    return json.dumps({"message": "Wow we implemented session tokens!"})

@app.route("/logout/", methods=["POST"])
def logout():
    """
    Endpoint for logging out a user
    """
    success, session_token = extract_token(request)
    if not success:
        return session_token
    user = users_dao.get_user_by_session_token(session_token)
    if not user or not user.verify_session_token(session_token):
        return json.dumps({"error": "invalid session token"}), 400
    user.session_expiration = datetime.datetime.now()
    db.session.commit()

    return json.dumps({"message": "user has successfully logged out"})

@app.route("/")
@app.route("/dining_hall/")
def get_all_dh():
    dh = [d.serialize() for d in Dining_hall.query.all()] 
    return success_response({"Dining_Hall": dh})


@app.route("/reviews/")
def get_all_reviews():
    reviews = [review.serialize() for review in Reviews.query.all()] 
    return success_response({"AllReviews": reviews})  
    

@app.route("/dining_hall/<int:dh_id>/reviews/")
def get_reviews_by_dh(dh_id):
    """
    Endpoint for getting reviews by dining hall
    """
    return success_response([review.serialize() for review in Reviews.query.filter_by(dining_hall_id=dh_id)])                                                                                                         

'''
@app.route("/user/", methods=["POST"])
def create_user():
    """
    Endpoint for creating a new user
    """
    body = json.loads(request.data)
    username = body.get("username")
    password = body.get("password")
    if not username:
        return failure_response("Sender not found",400)
    if not password:
        return failure_response("Sender not found",400)
    new_user= User(
        username = username,
        password = password
    )
    db.session.add(new_user) 
    db.session.commit() 
    return success_response(new_user.serialize(), 201)
'''

@app.route("/user/<int:user_id>/")
def get_user(user_id):
    """
    Endpoint for getting a user by id
    """
    user = User.query.filter_by(id=user_id).first() 
    if user is None:
        return failure_response("User not found!") 
    return success_response(user.serialize())


@app.route("/user/<int:user_id>/", methods=["DELETE"])
def delete_user(user_id):
    """
    Endpoint for deleting a task by id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())


@app.route("/reviews/user/<int:user_id>/dining_hall/<int:dh_id>/", methods=["POST"])
def create_review(user_id, dh_id):
    """
    Endpoint for creating a review
    by user id based off dining hall id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    body = json.loads(request.data)
    review_txt = body.get("review_text")
    rating = body.get("rating")
    reviewer = body.get("reviewer")
    if not review_txt:
        return failure_response("Missing review",400)
    if not rating:
        return failure_response("Missing rating",400)
    new_review = Reviews(
        review_text = review_txt,
        rating = rating,
        user_id = user_id,
        dining_hall_id = dh_id,
        reviewer = reviewer
    )
    db.session.add(new_review)
    db.session.commit()
    return success_response(new_review.serialize(),201)


@app.route("/reviews/<int:review_id>/", methods=["POST"])
def update_review(review_id):
    """
    Endpoint for updating a review by id
    """
    review = Reviews.query.filter_by(id=review_id).first()
    if review is None:
        return failure_response("Review not found!")
    body = json.loads(request.data)
    review.review_text = body.get("review_text", review.review_text)
    review.rating = body.get("rating", review.rating)
    db.session.commit()
    return success_response(review.serialize())

@app.route("/reviews/<int:review_id>/", methods=["DELETE"])
def delete_review(review_id):
    """
    Endpoint for deleting a review by id
    """
    review = Reviews.query.filter_by(id=review_id).first()
    if review is None:
        return failure_response("Review not found!")
    db.session.delete(review)
    db.session.commit()
    return success_response(review.serialize())

@app.route("/dining_hall/", methods=["POST"])
def create_dh():
    """
    Endpoint for creating a dining hall
    """
    body = json.loads(request.data)
    n = body.get("name")
    if not body.get("name"):
        return failure_response("Dining hall not found",400)
    new_dh = Dining_hall(
        name = n
    )
    db.session.add(new_dh)
    db.session.commit()
    return success_response(new_dh.serialize(),201)

@app.route("/dining_hall/<int:dh_id>/", methods=["DELETE"])
def delete_dh(dh_id):
    """
    Endpoint for deleting a dining hall by id
    """
    dh = Dining_hall.query.filter_by(id=dh_id).first()
    if dh is None:
        return failure_response("Dining hall not found!")
    db.session.delete(dh)
    db.session.commit()
    return success_response(dh.serialize())


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
