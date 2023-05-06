//
//  DiningHallsTableViewCell.swift
//  group26_HackChallenge
//
//  Created by Matthew Li on 4/28/23.
//

import UIKit
class DiningHallsTableViewCell: UITableViewCell {
    let diningHallImageView = UIImageView()
    let diningHallNameLabel = UILabel()
    let diningHallLocationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        diningHallImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(diningHallImageView)
        
        diningHallNameLabel.textColor = .black
        diningHallNameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        diningHallNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(diningHallNameLabel)
        
        diningHallLocationLabel.textColor = UIColor.init(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        diningHallLocationLabel.font = UIFont.systemFont(ofSize: 15)
        diningHallLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(diningHallLocationLabel)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            diningHallImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            diningHallImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            diningHallImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            diningHallImageView.widthAnchor.constraint(equalTo: diningHallImageView.heightAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            diningHallNameLabel.leadingAnchor.constraint(equalTo: diningHallImageView.trailingAnchor, constant: 10),
            diningHallNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            diningHallLocationLabel.leadingAnchor.constraint(equalTo: diningHallImageView.trailingAnchor, constant: 10),
            diningHallLocationLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
    }
    
    func updateDiningHall(diningHall: SetupDiningHall) {
        diningHallImageView.image = UIImage(named: diningHall.picture)
        diningHallNameLabel.text = diningHall.name
        diningHallLocationLabel.text = "Location: " + diningHall.location
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




