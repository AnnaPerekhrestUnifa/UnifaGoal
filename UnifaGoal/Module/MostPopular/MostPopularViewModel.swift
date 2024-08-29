//
//  MostPopularViewModel.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - AllNewsViewModel

class MostPopularViewModel: ViewModel, ViewModelProtocol {
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()
    var selectedArticleRelay = BehaviorRelay<Article?>(value: nil)

}

extension MostPopularViewModel {
    struct Input {
        var fetchMostPopularEvent: Driver<Void>
        var selectedArticleEvent: Driver<Article>
    }
    
    struct Output {
        let newsItems: Driver<[Article]>
        let navigateToDetailView: Driver<ViewModel>
    }
}

extension MostPopularViewModel {
    func transform(_ input: Input) -> Output {
        let news = input.fetchMostPopularEvent
            .asObservable()
            .flatMap { _ -> Observable<[Article]> in
                self.networkManager.fetchMostPopular()
                    .map { $0.results }
            }
        
        let detailViewModel = input.selectedArticleEvent
            .map { article -> ViewModel in
                return DetailsViewModel(with: article.url)
            }
        
        return Output(newsItems: news.asDriver(onErrorJustReturn: []), navigateToDetailView: detailViewModel)
    }
}
