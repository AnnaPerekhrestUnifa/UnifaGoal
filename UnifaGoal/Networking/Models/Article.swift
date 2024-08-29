//
//  Article.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/22.
//

import Foundation


struct Article: Codable {
    let section: String
    let subsection: String?
    let title: String
    let url: String
    let byline: String
    let publishedDate: String
    let multimedia: [Multimedia]?
    let media: [Media]?
    
    private enum CodingKeys: String, CodingKey {
        case section
        case subsection
        case title, url
        case byline
        case publishedDate = "published_date"
        case multimedia
        case media
    }
}

struct Multimedia: Codable {
   let url: String
   let format: String
   let height: Int
   let width: Int
   let type: String
   let subtype: String
   let caption: String
   let copyright: String
}

struct Media: Codable {
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadata]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    let url: String
    let format: String
    let height: Int
    let width: Int
}
