//
//  MostPopularController.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import RxDataSources


class MostPopularViewController: ViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "CommonCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    func bindData() {
        guard let viewModel = viewModel as? MostPopularViewModel else {
            print("CANT LOAD VM")
            return
        }
        
        let selectedArticle = tableView.rx.modelSelected(Article.self)
                   .asDriver()
        
        let input = MostPopularViewModel.Input(fetchMostPopularEvent:  Driver.just(()), selectedArticleEvent: selectedArticle)
        let output = viewModel.transform(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Article>>(
            configureCell: { (_, tableView, indexPath, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommonCell

                cell.setUp(data: item)
                
                return cell
            }
        )
        
        output.newsItems
            .map { [SectionModel(model: "", items: $0)] }
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.navigateToDetailView
            .drive(rx.showDetailScreen)
            .disposed(by: disposeBag)
    }
}

private extension Reactive where Base: MostPopularViewController {
    var showDetailScreen: Binder<ViewModel> {
        Binder(base) { base, viewModel in
            let storyboard = UIStoryboard(name: "DetailsViewController", bundle: nil)
            let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            
            detailViewController.viewModel = viewModel
            self.base.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
