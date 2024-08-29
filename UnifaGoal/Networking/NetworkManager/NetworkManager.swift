//
//  NetworkManager.swift
//  FamilyApp
//
//  Created by vorona.vyacheslav on 2020/12/24.
//  Copyright © 2020 UniFa. All rights reserved.
//

import Alamofire
import Foundation
import RxRelay
import RxSwift

// MARK: - NetworkManager

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchArticleSearch(query: String) -> Observable<NYTSearchResponse> {
            request(endpoint: .articleSearch(query: query))
        }

        func fetchTopStories() -> Observable<TopStoriesResponse> {
            request(endpoint: .topStories)
        }

        func fetchMostPopular() -> Observable<MostPopularResponse> {
            request(endpoint: .mostPopular)
        }

        func fetchAllNewsContent() -> Observable<AllNewsContentResponse> {
            request(endpoint: .allNewsContent)
        }
    
    private func request<Result: Decodable>(endpoint: APIRouter) -> Observable<Result> {
        return Observable.create { observer in
            print("## request SEARCH")
            let request = AF.request(endpoint)
                   
                   // Print request URL and parameters
                   if let url = request.convertible.urlRequest?.url?.absoluteString {
                       print("Request URL: \(url)")
                   }
                   
                   if let httpBody = request.convertible.urlRequest?.httpBody,
                      let params = String(data: httpBody, encoding: .utf8) {
                       print("Request Parameters: \(params)")
                   }
                   
                   request
                       .validate()
                .validate()
                .responseDecodable(of: Result.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        print(value)
                        observer.onCompleted()
                    case .failure(let error):
                        print(error)
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
