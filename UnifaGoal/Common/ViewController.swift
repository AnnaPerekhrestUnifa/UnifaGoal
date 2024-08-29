//
//  SceneDelegate.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/18.
//


import RxSwift
import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    var viewModel: ViewModel?
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Instantiate and display

extension ViewController {
    func pushViewController(viewController: ViewController, with viewModel: ViewModel) {
        guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
                print("Unable to find UINavigationController from the root view controller.")
                return
            }
        
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}


