//
//  ViewController.swift
//  group26_HackChallenge
//
//  Created by Matthew Li on 4/28/23.
//

import UIKit
class ViewController: UIViewController {
    
    var diningHalls: [SetupDiningHall] = []
    var diningHallsTableView = UITableView()
    let diningHallsReuseID = "diningHallsReuseIdentifier"
    var currentIndex = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cornell Foodies"
        view.backgroundColor = .white
        let morrison = SetupDiningHall(picture: "morrisonPic", name: "Morrison Dining", location: "North Campus", diningHallId: 0)
        let appel = SetupDiningHall(picture: "appelPic", name: "North Star Dining Room", location: "North Campus", diningHallId: 1)
        let risley = SetupDiningHall(picture: "risleyPic", name: "Risley Dining", location: "North Campus", diningHallId: 2)
        let okenshields = SetupDiningHall(picture: "okenshieldsPic", name: "Okenshields", location: "Central Campus", diningHallId: 3)
        let becker = SetupDiningHall(picture: "beckerPic", name: "Becker House Dining Room", location: "West Campus", diningHallId: 4)
        let bethe = SetupDiningHall(picture: "bethePic", name: "Bethe House Dining Room", location: "West Campus", diningHallId: 5)
        let cook = SetupDiningHall(picture: "cookPic", name: "Cook House Dining Room", location: "West Campus", diningHallId: 6)
        let keeton = SetupDiningHall(picture: "keetonPic", name: "Keeton House Dining Room", location: "West Campus", diningHallId: 7)
        let rose = SetupDiningHall(picture: "rosePic", name: "Rose House Dining Room", location: "West Campus", diningHallId: 8)
        let west = SetupDiningHall(picture: "westPic", name: "104West!", location: "South Campus", diningHallId: 9)
        
        diningHalls = [morrison, appel, risley, okenshields, becker, bethe, cook, keeton, rose, west]
        
        diningHallsTableView.delegate = self
        diningHallsTableView.dataSource = self
        diningHallsTableView.register(DiningHallsTableViewCell.self, forCellReuseIdentifier: diningHallsReuseID)
        diningHallsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(diningHallsTableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            diningHallsTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            diningHallsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            diningHallsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            diningHallsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath
        let currentDiningHall = diningHalls[indexPath.row]
        let vc = ReviewsViewController(diningHall: currentDiningHall)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diningHalls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: diningHallsReuseID, for: indexPath) as? DiningHallsTableViewCell {
            
            let currentDiningHall = diningHalls[indexPath.row]
            cell.updateDiningHall(diningHall: currentDiningHall)
            
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}
