# hackchallenge
1. Cornell Grub
2. Discover food on campus
3. 
4.
5. Our app is a custom-made Cornell food review app that shows students’ thoughts on each dining hall on campus. When the app opens, the user can click on one of the ten dining halls to see its reviews. While looking at the reviews of a dining hall, the user can also leave a review using the “Leave a Review” button in the top right. This will take the user to a separate screen where they can give the restaurant a star rating and a written review of their dining experience. After clicking the “Submit Review” button, the user can refresh the list of reviews by dragging the screen upwards and their new review will be shown.
6. IOS: The app uses NSLayoutConstaints to setup the positioning and sizes for UITableViews, UIImageViews, UILabels, UIButtons, UITextViews, and UITextFields. It utilizes multiple UITableViews, one to show a list of dining halls and a UITableView that shows the reviews for each dining hall. When a dining hall is pressed, push navigation is used to show the reviews for the dining hall. Push navigation is also used to open a screen to create a review, utilizing delegates to update a list of reviews. Finally, we integrated with Backend’s API using GET and POST requests in order to store our reviews of the dining hall so they would not be deleted when the app closes.


