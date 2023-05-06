from flask_sqlalchemy import SQLAlchemy
import datetime
from datetime import datetime

import bcrypt

import hashlib
import os


db = SQLAlchemy()

class User(db.Model):
    """
    User model
    """

    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String, nullable=False, unique=True)
    password_digest = db.Column(db.String, nullable=False)
    reviews = db.relationship("Reviews", cascade="delete")

    session_token = db.Column(db.String, nullable=False, unique=True)
    session_expiration = db.Column(db.DateTime, nullable=False)
    update_token = db.Column(db.String, nullable=False, unique=True)


    def __init__(self, **kwargs): 
        """
        Initializes a User object
        """

        self.username = kwargs.get("username")
        self.password_digest = bcrypt.hashpw(kwargs.get("password").encode("utf8"), bcrypt.gensalt(rounds=13))
        self.renew_session()

    def _urlsafe_base_64(self):
        """
        Randomly generates hashed tokens (used for session/update tokens)
        """
        return hashlib.sha1(os.urandom(64)).hexdigest()

    def renew_session(self):
        """
        Renews the sessions, i.e.
        1. Creates a new session token
        2. Sets the expiration time of the session to be a day from now
        3. Creates a new update token
        """
        self.session_token = self._urlsafe_base_64()
        self.session_expiration = datetime.datetime.now() + datetime.timedelta(days=1)
        self.update_token = self._urlsafe_base_64()

    def verify_password(self, password):
        """
        Verifies the password of a user
        """
        return bcrypt.checkpw(password.encode("utf8"), self.password_digest)

    def verify_session_token(self, session_token):
        """
        Verifies the session token of a user
        """
        return session_token == self.session_token and datetime.datetime.now() < self.session_expiration

    def verify_update_token(self, update_token):
        """
        Verifies the update token of a user
        """
        return update_token == self.update_token
        
    def serialize(self):
        """
        Serializes a User object
        """

        return {
            "id": self.id,
            "username": self.username,
            "reviews": [s.serialize() for s in self.reviews]
        }

    def simple_serialize(self):
        """
        Serialize a User object without the reviews
        """

        return {
            "id": self.id,
            "username": self.username,
        }

class Reviews(db.Model):
    """
    Reviews model
    """

    __tablename__ = "review"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    review_text = db.Column(db.String, nullable=False)
    rating = db.Column(db.Integer, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)
    dining_hall_id = db.Column(db.Integer, db.ForeignKey("dining_hall.id"), nullable=True)
    date = db.Column(db.DateTime, nullable=True)
    reviewer = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        """
        Initializes a review object
        """
        self.review_text = kwargs.get("review_text", "")
        self.rating = kwargs.get("rating", False)
        self.user_id = kwargs.get("user_id")
        self.dining_hall_id = kwargs.get("dining_hall_id")
        self.date = datetime.now()
        self.reviewer = kwargs.get("reviewer")

    def serialize(self):
        """
        Serialize a review object
        """

        return {
            "id": self.id,
            "review_text": self.review_text,
            "rating": self.rating,
            "date": self.date.strftime("%m/%d/%y"),
            "reviewer": self.reviewer
        }

class Dining_hall(db.Model):
    """
    Dining hall model
    """

    __tablename__ = "dining_hall"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    reviews = db.relationship("Reviews", cascade="delete")


    def __init__(self, **kwargs):
        """
        Initializes a Dining hall object
        """

        self.name = kwargs.get("name", "")

    def serialize(self):
        """
        Serializes a Dining hall object
        """
        
        return {
            "id": self.id,
            "name": self.name,
            "reviews": [c.serialize() for c in self.reviews]
        }

    def simple_serialize(self):
        """
        Serialize a Dining hall object without the review field
        """

        return {
            "id": self.id,
            "name": self.name
        }