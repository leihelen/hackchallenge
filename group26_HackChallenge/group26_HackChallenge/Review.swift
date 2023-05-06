//
//  Review.swift
//  group26_HackChallenge
//
//  Created by Matthew Li on 4/28/23.
//

import Foundation

struct Review: Decodable {
    let review_text: String
    let rating: Int
    let date: String
    let reviewer: String
}

struct DiningHall: Decodable {
    let id: Int
    let name: String
    let reviews: [Review]
}

struct DiningHallResponse: Decodable {
    let diningHalls: [DiningHall]

    private enum CodingKeys: String, CodingKey {
        case diningHalls = "Dining_Hall"
    }
}

