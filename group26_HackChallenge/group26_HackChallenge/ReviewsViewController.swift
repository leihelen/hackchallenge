//
//  ReviewsViewController.swift
//  group26_HackChallenge
//
//  Created by Matthew Li on 4/28/23.
//

import UIKit
class ReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreateReviewDelegate {
    
    let reviewTableView = UITableView()
    let reviewReuseID = "reviewReuseID"
    
    var reviews: [Review] = []
    var starRating = 0
    
    var randomReview = Review(review_text: "", rating: 0, date: "", reviewer: "Anonymous")
    
    let addReviewButton = UIBarButtonItem()
    let refreshControl = UIRefreshControl()
    
    let diningHall: SetupDiningHall
    
    init(diningHall: SetupDiningHall) {
        self.diningHall = diningHall
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        var url = URL(string: "http://35.186.180.255/")!
        let formatParameter = URLQueryItem(name: "format", value: "json")
        url.append(queryItems: [formatParameter])
        super.viewDidLoad()
        
        let testReview = Review(review_text: "10/10 would reccomend", rating: 5, date: "", reviewer: "Anonymous")
        
        reviews.append(testReview)
        title = diningHall.name
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: reviewReuseID)
        reviewTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reviewTableView)

        addReviewButton.title = "Leave Review"
        addReviewButton.target = self
        addReviewButton.action = #selector(pushCreateReview)
        navigationItem.rightBarButtonItem = addReviewButton
        
        refreshControl.addTarget(self, action: #selector(refreshReviews), for: .valueChanged)
        if #available(iOS 10.0, *) {
            reviewTableView.refreshControl = refreshControl
        } else {
            reviewTableView.addSubview(refreshControl)
        }
        
        setupConstraints()
        
        NetworkManager.shared.getAllReviews { allDiningHalls in
            DispatchQueue.main.async {
                self.reviews = allDiningHalls[self.diningHall.diningHallId].reviews
//                print(self.reviews)
                self.reviewTableView.reloadData()
            }
        }
    }
        
    func setupConstraints() {
        NSLayoutConstraint.activate([
            reviewTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            reviewTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            reviewTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            reviewTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

    }
    @objc func refreshReviews() {
        NetworkManager.shared.getAllReviews { allDiningHalls in
            DispatchQueue.main.async {
                self.reviews = allDiningHalls[self.diningHall.diningHallId].reviews
                self.reviewTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func pushCreateReview() {
        let vc = CreateReviewViewController(review: randomReview, diningHall: diningHall)
        vc.del = self
        navigationController?.pushViewController(vc, animated: true)
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reviewReuseID, for: indexPath) as? ReviewTableViewCell {
            
            let currentReview = reviews[indexPath.row]
            cell.updateReviews(review: currentReview)
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func addReview(newReview: Review) {
        reviews.append(newReview)
        reviewTableView.reloadData()
    }
    
    func createReview(review_text: String, rating: Int, date: String, reviewer: String) {
        NetworkManager.shared.createReview(review_text: review_text, rating: rating, date: date, reviewer: reviewer, currentDiningHall: self.diningHall.diningHallId) { review in
//            print(review)
            self.reviews += [review]
//            print(self.reviews)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






