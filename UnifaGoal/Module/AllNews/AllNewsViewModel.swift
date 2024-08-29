//
//  AllNewsViewModel.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import Foundation
import RxCocoa
import RxSwift

class AllNewsViewModel: ViewModel, ViewModelProtocol {
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()
    
    var selectedArticleRelay = BehaviorRelay<Article?>(value: nil)

}

extension AllNewsViewModel {
    struct Input {
        var fetchAllNewsEvent: Driver<Void>
        var selectedArticleEvent: Driver<Article>
    }
    
    struct Output {
        let newsItems: Driver<[Article]>
        let navigateToDetailView: Driver<ViewModel>
    }
}

extension AllNewsViewModel {
    func transform(_ input: Input) -> Output {
        let news = input.fetchAllNewsEvent
            .asObservable()
            .flatMap { _ -> Observable<[Article]> in
                self.networkManager.fetchAllNewsContent()
                    .map { $0.results }
            }
        
        let detailViewModel = input.selectedArticleEvent
            .map { article -> ViewModel in
                return DetailsViewModel(with: article.url)
            }
    
        return Output(newsItems: news.asDriver(onErrorJustReturn: []), navigateToDetailView: detailViewModel)
    }
}
