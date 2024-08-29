//
//  SceneDelegate.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/18.
//


import RxSwift
import RxCocoa
import ObjectiveC

// MARK: - ViewModelProtocol

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) throws -> Output
}

// MARK: - ViewModel

class ViewModel: NSObject {
    let infoMessagesSinkRelay = PublishRelay<String>()  // when you want to display info type messages (ex. Draft Saved, Changed email address)
    let errorSinkRelay = PublishRelay<String>()         // when you want to display error messages usually from API responses
}
