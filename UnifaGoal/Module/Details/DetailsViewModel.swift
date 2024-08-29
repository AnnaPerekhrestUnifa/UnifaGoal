//
//  DetailsViewModel.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/23.
//

import Foundation
import RxSwift
import RxCocoa

class DetailsViewModel: ViewModel, ViewModelProtocol {
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()
    
    let urlRelay = BehaviorRelay<String>(value: "")
    
    init(with url: String) {
        self.urlRelay.accept(url)
    }
}

extension DetailsViewModel {
    struct Input {
        var loadEvent: Driver<Void>
    }
    
    struct Output {
        let url: Driver<URLRequest?>
    }
}

extension DetailsViewModel {
    func transform(_ input: Input) -> Output {
        let articleRequest = input.loadEvent
            .flatMapLatest { _ -> Driver<URLRequest?> in
                let urlString = self.urlRelay.value
                
                guard let url = URL(string: urlString) else {
                    return Driver.just(nil)
                }
                
                let request = URLRequest(url: url)
                return Driver.just(request)
            }
        
        return Output(url: articleRequest)
    }
}
