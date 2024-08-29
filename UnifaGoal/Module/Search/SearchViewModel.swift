//
//  SearchViewModel.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - AllNewsViewModel

class SearchViewModel: ViewModel, ViewModelProtocol {
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()
}

// MARK: - Input/Output

extension SearchViewModel {
    struct Input {
        let searchEvent: Driver<String>
    }
    
    struct Output {
        let newsItems: Driver<[NYTSearchArticle]>
    }
}

// MARK: - Transform
extension SearchViewModel {
    func transform(_ input: Input) -> Output {
        let news = input.searchEvent
            .asObservable()
            .flatMap { query -> Observable<[NYTSearchArticle]> in
                self.networkManager.fetchArticleSearch(query: query)
                    .map { $0.response.docs }
            }
        
        return Output(newsItems: news.asDriver(onErrorJustReturn: []))
    }
}
