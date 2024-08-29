//
//  MostPopularModel.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import Foundation

// https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=H6OUGR31aT98DbSztODTmGXyTA9qhR3u

struct MostPopularResponse: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}
