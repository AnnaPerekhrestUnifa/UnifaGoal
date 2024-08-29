//
//  DetailsViewController.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/23.
//

import UIKit
import WebKit
import RxCocoa

class DetailsViewController: ViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    func bindData() {
        guard let viewModel = viewModel as? DetailsViewModel else {
            print("CANT LOAD VM")
            return
        }
        
        let input = DetailsViewModel.Input(loadEvent: Driver.just(()))
        let output = viewModel.transform(input)
        
        output.url
            .drive(onNext: { [weak self] request in
                guard let request = request else { return }
                self?.webView.load(request)
            })
            .disposed(by: disposeBag)
    }
}
