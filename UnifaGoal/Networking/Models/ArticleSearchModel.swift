//
//  ArticleSearchModel.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import Foundation

//    https://api.nytimes.com/svc/search/v2/articlesearch.json?q=ukraine&api-key=H6OUGR31aT98DbSztODTmGXyTA9qhR3u
struct NYTSearchResponse: Codable {
    let status: String
    let copyright: String
    let response: NYTSearchResponseData
}

struct NYTSearchResponseData: Codable {
    let docs: [NYTSearchArticle]
}

struct NYTSearchArticle: Codable {
    let abstract: String
    let webUrl: String
    let snippet: String
    let leadParagraph: String?
    let printSection: String?
    let printPage: String?
    let source: String
    let multimedia: [NYTSearchMultimedia]?
    let headline: NYTSearchHeadline
    let keywords: [NYTSearchKeyword]
    let pubDate: String
    let documentType: String
    let newsDesk: String
    let sectionName: String
    let subsectionName: String?
    let byline: NYTSearchByline?

    private enum CodingKeys: String, CodingKey {
        case abstract
        case webUrl = "web_url"
        case snippet
        case leadParagraph = "lead_paragraph"
        case printSection = "print_section"
        case printPage = "print_page"
        case source
        case multimedia
        case headline
        case keywords
        case pubDate = "pub_date"
        case documentType = "document_type"
        case newsDesk = "news_desk"
        case sectionName = "section_name"
        case subsectionName = "subsection_name"
        case byline
    }
}

struct NYTSearchMultimedia: Codable {
    let rank: Int
    let subtype: String
    let url: String
    let height: Int
    let width: Int
    let legacy: NYTSearchLegacy?

    private enum CodingKeys: String, CodingKey {
        case rank
        case subtype
        case url
        case height
        case width
        case legacy
    }
}

struct NYTSearchLegacy: Codable {
    let xlarge: String?
    let xlargeWidth: Int?
    let xlargeHeight: Int?

    private enum CodingKeys: String, CodingKey {
        case xlarge
        case xlargeWidth = "xlargewidth"
        case xlargeHeight = "xlargeheight"
    }
}

struct NYTSearchHeadline: Codable {
    let main: String
    let kicker: String?

    private enum CodingKeys: String, CodingKey {
        case main
        case kicker
    }
}

struct NYTSearchKeyword: Codable {
    let name: String
    let value: String
    let rank: Int
    let major: String

    private enum CodingKeys: String, CodingKey {
        case name
        case value
        case rank
        case major
    }
}

struct NYTSearchByline: Codable {
    let original: String?

    private enum CodingKeys: String, CodingKey {
        case original
    }
}

