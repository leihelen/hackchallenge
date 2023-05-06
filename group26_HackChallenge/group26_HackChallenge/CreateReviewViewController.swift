//
//  CreateReviewViewController.swift
//  group26_HackChallenge
//
//  Created by Matthew Li on 4/28/23.
//

import UIKit
class CreateReviewViewController: UIViewController {
    
    var numStars = 0
    let starsButton1 = UIButton()
    let starsButton2 = UIButton()
    let starsButton3 = UIButton()
    let starsButton4 = UIButton()
    let starsButton5 = UIButton()
    let writeReviewTextView = UITextView()
    let reviewerTextField = UITextField()
    let ratingTextField = UITextField()
    let diningHallLabel = UILabel()
    
    let submitReviewButton = UIButton()
    
    let writeReviewLabel = UILabel()
    let reviewerLabel = UILabel()
    let ratingLabel = UILabel()
    weak var del: CreateReviewDelegate?
    let review: Review
    let diningHall: SetupDiningHall
    
    init(review: Review, diningHall: SetupDiningHall) {
        self.review = review
        self.diningHall = diningHall
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Leave A Review!"
        view.backgroundColor = .white
        
        diningHallLabel.font = UIFont.boldSystemFont(ofSize: 20)
        diningHallLabel.text = diningHall.name
        diningHallLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(diningHallLabel)
        
        starsButton1.addTarget(self, action: #selector(fillStars), for: .touchUpInside)
        starsButton1.tag = 1
        starsButton1.setImage(UIImage(named: "emptyStar"), for: .normal)
        starsButton1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starsButton1)
        
        starsButton2.addTarget(self, action: #selector(fillStars), for: .touchUpInside)
        starsButton2.tag = 2
        starsButton2.setImage(UIImage(named: "emptyStar"), for: .normal)
        starsButton2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starsButton2)
        
        starsButton3.addTarget(self, action: #selector(fillStars), for: .touchUpInside)
        starsButton3.tag = 3
        starsButton3.setImage(UIImage(named: "emptyStar"), for: .normal)
        starsButton3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starsButton3)
        
        starsButton4.addTarget(self, action: #selector(fillStars), for: .touchUpInside)
        starsButton4.tag = 4
        starsButton4.setImage(UIImage(named: "emptyStar"), for: .normal)
        starsButton4.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starsButton4)
        
        starsButton5.addTarget(self, action: #selector(fillStars), for: .touchUpInside)
        starsButton5.tag = 5
        starsButton5.setImage(UIImage(named: "emptyStar"), for: .normal)
        starsButton5.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starsButton5)
        
        writeReviewTextView.layer.borderWidth = 1
        writeReviewTextView.layer.cornerRadius = 5
        writeReviewTextView.font = UIFont.systemFont(ofSize: 15)
        writeReviewTextView.text = ""
        writeReviewTextView.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        writeReviewTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(writeReviewTextView)
        
        reviewerTextField.borderStyle = .roundedRect
        reviewerTextField.layer.borderWidth = 1
        reviewerTextField.layer.cornerRadius = 5
        reviewerTextField.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        reviewerTextField.placeholder = "Name (optional)"
        reviewerTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reviewerTextField)
        writeReviewLabel.text = "Your review: "
        writeReviewLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        writeReviewLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(writeReviewLabel)
        
        reviewerLabel.text = "Your name: "
        reviewerLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        reviewerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reviewerLabel)
        
        submitReviewButton.setTitle("Submit Review", for: .normal)
        submitReviewButton.setTitleColor(.blue, for: .normal)
        submitReviewButton.addTarget(self, action: #selector(submitReview), for: .touchUpInside)
        submitReviewButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitReviewButton)
        
        setupConstraints()
    }
        
    func setupConstraints() {
        
        let starWidth: CGFloat = 40
        let starHeight: CGFloat = 33
        let starDistance: CGFloat = 50
        
        NSLayoutConstraint.activate([
            diningHallLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            diningHallLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            starsButton1.topAnchor.constraint(equalTo: diningHallLabel.bottomAnchor, constant: 10),
            starsButton1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            starsButton1.widthAnchor.constraint(equalToConstant: starWidth),
            starsButton1.heightAnchor.constraint(equalToConstant: starHeight)
        ])
        
        NSLayoutConstraint.activate([
            starsButton2.topAnchor.constraint(equalTo: starsButton1.topAnchor),
            starsButton2.leadingAnchor.constraint(equalTo: starsButton1.leadingAnchor, constant: starDistance),
            starsButton2.widthAnchor.constraint(equalToConstant: starWidth),
            starsButton2.heightAnchor.constraint(equalToConstant: starHeight)
        ])
        
        NSLayoutConstraint.activate([
            starsButton3.topAnchor.constraint(equalTo: starsButton1.topAnchor),
            starsButton3.leadingAnchor.constraint(equalTo: starsButton2.leadingAnchor, constant: starDistance),
            starsButton3.widthAnchor.constraint(equalToConstant: starWidth),
            starsButton3.heightAnchor.constraint(equalToConstant: starHeight)
        ])
        
        NSLayoutConstraint.activate([
            starsButton4.topAnchor.constraint(equalTo: starsButton1.topAnchor),
            starsButton4.leadingAnchor.constraint(equalTo: starsButton3.leadingAnchor, constant: starDistance),
            starsButton4.widthAnchor.constraint(equalToConstant: starWidth),
            starsButton4.heightAnchor.constraint(equalToConstant: starHeight)
        ])
        
        NSLayoutConstraint.activate([
            starsButton5.topAnchor.constraint(equalTo: starsButton1.topAnchor),
            starsButton5.leadingAnchor.constraint(equalTo: starsButton4.leadingAnchor, constant: starDistance),
            starsButton5.widthAnchor.constraint(equalToConstant: starWidth),
            starsButton5.heightAnchor.constraint(equalToConstant: starHeight)
        ])
        
        NSLayoutConstraint.activate([
            writeReviewLabel.topAnchor.constraint(equalTo: starsButton1.bottomAnchor, constant: 20),
            writeReviewLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            writeReviewTextView.widthAnchor.constraint(equalToConstant: 320),
            writeReviewTextView.heightAnchor.constraint(equalToConstant: 400),
            writeReviewTextView.topAnchor.constraint(equalTo: writeReviewLabel.bottomAnchor),
            writeReviewTextView.leadingAnchor.constraint(equalTo: writeReviewLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            reviewerLabel.topAnchor.constraint(equalTo: writeReviewTextView.bottomAnchor, constant: 20),
            reviewerLabel.leadingAnchor.constraint(equalTo: writeReviewLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            reviewerTextField.widthAnchor.constraint(equalToConstant: 240),
            reviewerTextField.heightAnchor.constraint(equalToConstant: 20),
            reviewerTextField.topAnchor.constraint(equalTo: reviewerLabel.topAnchor),
            reviewerTextField.leadingAnchor.constraint(equalTo: reviewerLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            submitReviewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            submitReviewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func fillStars(sender: UIButton) {
        if (sender.tag == 1) {
            starsButton1.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton2.setImage(UIImage(named: "emptyStar"), for: .normal)
            starsButton3.setImage(UIImage(named: "emptyStar"), for: .normal)
            starsButton4.setImage(UIImage(named: "emptyStar"), for: .normal)
            starsButton5.setImage(UIImage(named: "emptyStar"), for: .normal)
            numStars = 1
        }
        
        if (sender.tag == 2) {
            starsButton1.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton2.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton3.setImage(UIImage(named: "emptyStar"), for: .normal)
            starsButton4.setImage(UIImage(named: "emptyStar"), for: .normal)
            starsButton5.setImage(UIImage(named: "emptyStar"), for: .normal)
            numStars = 2
        }
        
        if (sender.tag == 3) {
            starsButton1.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton2.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton3.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton4.setImage(UIImage(named: "emptyStar"), for: .normal)
            starsButton5.setImage(UIImage(named: "emptyStar"), for: .normal)
            numStars = 3
        }
        
        if (sender.tag == 4) {
            starsButton1.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton2.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton3.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton4.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton5.setImage(UIImage(named: "emptyStar"), for: .normal)
            numStars = 4
        }
        
        if (sender.tag == 5) {
            starsButton1.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton2.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton3.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton4.setImage(UIImage(named: "filledStar"), for: .normal)
            starsButton5.setImage(UIImage(named: "filledStar"), for: .normal)
            numStars = 5
        }
        }
    
    @objc func submitReview() {
        if (reviewerTextField.text == "") {
            reviewerTextField.text = "Anonymous"
        }
    
        if let unwrappedReview = writeReviewTextView.text, let unwrappedReviewer = reviewerTextField.text {
            del?.createReview(review_text: unwrappedReview, rating: numStars, date: "1/2/2023", reviewer: unwrappedReviewer)
            
            navigationController?.popViewController(animated: true)
        }
    }
}
protocol CreateReviewDelegate: UIViewController {
    func createReview(review_text: String, rating: Int, date: String, reviewer: String)
}
