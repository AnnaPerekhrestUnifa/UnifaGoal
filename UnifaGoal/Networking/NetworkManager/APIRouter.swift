//
//  APIRouter.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import Alamofire
import Foundation

// MARK: - APIRouter
enum APIRouter: URLRequestConvertible {
    // MARK: - API Endpoints
    case articleSearch(query: String)
    case topStories
    case mostPopular
    case allNewsContent
    
    private var apiKey: String {
        return "H6OUGR31aT98DbSztODTmGXyTA9qhR3u"
    }

    
    // MARK: - Base URL
    private var baseURL: URL {
        return URL(string: "https://api.nytimes.com/svc/")!
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .articleSearch:
            return "search/v2/articlesearch.json"
        case .topStories:
            return "topstories/v2/world.json"
        case .mostPopular:
            return "mostpopular/v2/viewed/1.json"
        case .allNewsContent:
            return "news/v3/content/all/all.json"
        }
    }
    
    private var completeURL: URL {
        return baseURL.appendingPathComponent(path)
    }
    
    // MARK: - HTTP method
    var method: HTTPMethod {
        switch self {
        case .articleSearch, .topStories, .mostPopular, .allNewsContent:
            return .get
        }
    }
    
    // MARK: - Encoding
    private var parameterEncoding: ParameterEncoding {
        switch self {
        case .articleSearch:
            return URLEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: completeURL)
        request.method = method
        if let parameters = parameters {
            request = try parameterEncoding.encode(request, with: parameters)
        }
        
        return request
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .articleSearch(let query):
            return [
                "q": query,
                "api-key": apiKey
            ]
        default:
            return ["api-key": apiKey]
        }
    }
}
