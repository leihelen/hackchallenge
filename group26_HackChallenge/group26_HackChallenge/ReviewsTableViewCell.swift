//
//  ReviewsTableViewCell.swift
//  group26_HackChallenge
//
//  Created by Matthew Li on 4/28/23.
//

import UIKit
class ReviewTableViewCell: UITableViewCell {
    
    let reviewTextView = UITextView()
    let reviewerLabel = UILabel()
    let dateLabel = UILabel()
    let ratingLabel = UILabel()
    
    let starsImage1 = UIImageView()
    let starsImage2 = UIImageView()
    let starsImage3 = UIImageView()
    let starsImage4 = UIImageView()
    let starsImage5 = UIImageView()
    
    let review: [Review] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        reviewTextView.layer.borderWidth = 1
        reviewTextView.layer.cornerRadius = 5
        reviewTextView.textColor = .black
        reviewTextView.font = UIFont.systemFont(ofSize: 15)
        reviewTextView.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        reviewTextView.isEditable = false
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(reviewTextView)
        
        reviewerLabel.textColor = .black
        reviewerLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        reviewerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(reviewerLabel)
        
        dateLabel.textColor = .black
        dateLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(dateLabel)
        
        starsImage1.image = UIImage(named: "emptyStar")
        starsImage1.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(starsImage1)
        
        starsImage2.image = UIImage(named: "emptyStar")
        starsImage2.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(starsImage2)
        
        starsImage3.image = UIImage(named: "emptyStar")
        starsImage3.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(starsImage3)
        
        starsImage4.image = UIImage(named: "emptyStar")
        starsImage4.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(starsImage4)
        
        starsImage5.image = UIImage(named: "emptyStar")
        starsImage5.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(starsImage5)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let starWidth: CGFloat = 40
        let starHeight: CGFloat = 33
        let starDistance: CGFloat = 50
        
        NSLayoutConstraint.activate([
            reviewerLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            reviewerLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: reviewerLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: reviewerLabel.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            reviewTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10),
            reviewTextView.leadingAnchor.constraint(equalTo: reviewerLabel.leadingAnchor),
            reviewTextView.widthAnchor.constraint(equalToConstant: 300),
            reviewTextView.heightAnchor.constraint(equalToConstant: 120)
        ])

        NSLayoutConstraint.activate([
            starsImage1.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            starsImage1.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            starsImage1.widthAnchor.constraint(equalToConstant: starWidth),
            starsImage1.heightAnchor.constraint(equalToConstant: starHeight)
        ])
        
        NSLayoutConstraint.activate([
            starsImage2.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            starsImage2.leadingAnchor.constraint(equalTo: starsImage1.leadingAnchor, constant: starDistance),
            starsImage2.widthAnchor.constraint(equalToConstant: starWidth),
            starsImage2.heightAnchor.constraint(equalToConstant: starHeight)
        ])
        
        NSLayoutConstraint.activate([
            starsImage3.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            starsImage3.leadingAnchor.constraint(equalTo: starsImage2.leadingAnchor, constant: starDistance),
            starsImage3.widthAnchor.constraint(equalToConstant: starWidth),
            starsImage3.heightAnchor.constraint(equalToConstant: starHeight)
        ])
        
        NSLayoutConstraint.activate([
            starsImage4.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            starsImage4.leadingAnchor.constraint(equalTo: starsImage3.leadingAnchor, constant: starDistance),
            starsImage4.widthAnchor.constraint(equalToConstant: starWidth),
            starsImage4.heightAnchor.constraint(equalToConstant: starHeight)
        ])
        
        NSLayoutConstraint.activate([
            starsImage5.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            starsImage5.leadingAnchor.constraint(equalTo: starsImage4.leadingAnchor, constant: starDistance),
            starsImage5.widthAnchor.constraint(equalToConstant: starWidth),
            starsImage5.heightAnchor.constraint(equalToConstant: starHeight)
        ])
    }
    
    func updateReviews(review: Review) {
        reviewTextView.text = review.review_text
        dateLabel.text = review.date
        reviewerLabel.text = review.reviewer
        
        if (review.rating == 1) {
            starsImage1.image = UIImage(named: "filledStar")
            starsImage2.image = UIImage(named: "emptyStar")
            starsImage3.image = UIImage(named: "emptyStar")
            starsImage4.image = UIImage(named: "emptyStar")
            starsImage5.image = UIImage(named: "emptyStar")
        }
        if (review.rating == 2) {
            starsImage1.image = UIImage(named: "filledStar")
            starsImage2.image = UIImage(named: "filledStar")
            starsImage3.image = UIImage(named: "emptyStar")
            starsImage4.image = UIImage(named: "emptyStar")
            starsImage5.image = UIImage(named: "emptyStar")
        }
        if (review.rating == 3) {
            starsImage1.image = UIImage(named: "filledStar")
            starsImage2.image = UIImage(named: "filledStar")
            starsImage3.image = UIImage(named: "filledStar")
            starsImage4.image = UIImage(named: "emptyStar")
            starsImage5.image = UIImage(named: "emptyStar")
        }
        if (review.rating == 4) {
            starsImage1.image = UIImage(named: "filledStar")
            starsImage2.image = UIImage(named: "filledStar")
            starsImage3.image = UIImage(named: "filledStar")
            starsImage4.image = UIImage(named: "filledStar")
            starsImage5.image = UIImage(named: "emptyStar")
        }
        if (review.rating == 5) {
            starsImage1.image = UIImage(named: "filledStar")
            starsImage2.image = UIImage(named: "filledStar")
            starsImage3.image = UIImage(named: "filledStar")
            starsImage4.image = UIImage(named: "filledStar")
            starsImage5.image = UIImage(named: "filledStar")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




