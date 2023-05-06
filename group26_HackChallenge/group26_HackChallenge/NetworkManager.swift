//
//  NetworkManager.swift
//  group26_HackChallenge
//
//  Created by Matthew Li on 4/28/23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var url = URL(string: "http://35.186.180.255/")!
    var postUrl = URL(string: "http://35.186.180.255/")!
    
    func getAllReviews(completion: @escaping ([DiningHall]) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        

        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(DiningHallResponse.self, from: data)
                    completion(response.diningHalls)
                }
                catch (let error) {
//                    print(String(data: data, encoding: .utf8))
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }

    func createReview(review_text: String, rating: Int, date: String, reviewer: String, currentDiningHall: Int, completion: @escaping (Review) -> Void) {
        
        if (currentDiningHall == 0) {
            postUrl = URL(string: "http://35.186.180.255/reviews/user/1/dining_hall/1/")!
        }
        else if (currentDiningHall == 1) {
            postUrl = URL(string: "http://35.186.180.255/reviews/user/1/dining_hall/2/")!
        }
        else if (currentDiningHall == 2) {
            postUrl = URL(string: "http://35.186.180.255/reviews/user/1/dining_hall/3/")!
        }
        else if (currentDiningHall == 3) {
            postUrl = URL(string: "http://35.186.180.255/reviews/user/1/dining_hall/4/")!
        }
        else if (currentDiningHall == 4) {
            postUrl = URL(string: "http://35.186.180.255/reviews/user/1/dining_hall/5/")!
        }
        else if (currentDiningHall == 5) {
            postUrl = URL(string: "http://35.186.180.255/reviews/user/1/dining_hall/6/")!
        }
        else if (currentDiningHall == 6) {
            postUrl = URL(string: "http://35.186.180.255/reviews/user/1/dining_hall/7/")!
        }
        else if (currentDiningHall == 7) {
            postUrl = URL(string: "http://35.186.180.255/reviews/user/1/dining_hall/8/")!
        }
        else if (currentDiningHall == 8) {
            postUrl = URL(string: "http://35.186.180.255/reviews/user/1/dining_hall/9/")!
        }
        else if (currentDiningHall == 9) {
            postUrl = URL(string: "http://35.186.180.255/reviews/user/1/dining_hall/10/")!
        }
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "review_text": review_text,
            "rating": rating,
            "reviewer": reviewer
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Review.self, from:data)
                    completion(response)
                }
                catch (let error){
//                    print(String(data: data, encoding: .utf8))
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

