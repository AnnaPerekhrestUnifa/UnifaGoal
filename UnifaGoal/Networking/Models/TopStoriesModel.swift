//
//  TopStoriesModel.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import Foundation

//    https://api.nytimes.com/svc/topstories/v2/world.json?api-key=yourkey

struct TopStoriesResponse: Codable {
    let status: String
    let copyright: String
    let section: String
    let lastUpdated: String
    let numResults: Int
    let results: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case section
        case lastUpdated = "last_updated"
        case numResults = "num_results"
        case results
    }
}
