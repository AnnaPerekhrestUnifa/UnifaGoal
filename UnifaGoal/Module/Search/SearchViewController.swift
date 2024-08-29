//
//  SearchViewController.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import RxDataSources

class SearchViewController: ViewController, UISearchBarDelegate, UITableViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "SearchCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "Search")
        }
    }
    
    var selectedArticleRelay = PublishRelay<NYTSearchArticle>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindData()
    }
    
    private func setupUI() {
        searchBar.delegate = self
        tableView.delegate = self
        
        setupKeyboardHiding()
    }
    
    func bindData() {
        guard let viewModel = viewModel as? SearchViewModel else {
            print("CANT LOAD VM")
            return
        }
        
        let searchBarTextUpdate = searchBar.rx.text.orEmpty
            .asObservable()
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: SharingScheduler.make())
            .asDriverOnErrorJustComplete()
        
        let input = SearchViewModel.Input(searchEvent: searchBarTextUpdate)
        let output = viewModel.transform(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, NYTSearchArticle>>(
            configureCell: { (_, tableView, indexPath, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Search", for: indexPath) as! SearchCell
                
                cell.setUp(data: item)
                
                cell.moreInfoButton.rx.tap
                    .map { _ in
                        item
                    }
                    .bind(to: self.selectedArticleRelay)
                    .disposed(by: cell.dispoceBag)
                
                return cell
            }
        )
        
        output.newsItems
            .map { [SectionModel(model: "", items: $0)] }
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        selectedArticleRelay
            .subscribe(onNext: { [weak self] article in
                self?.navigateToDetailView(with: article)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupKeyboardHiding() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
    
    func navigateToDetailView(with article: NYTSearchArticle) {
        let storyboard = UIStoryboard(name: "DetailsViewController", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailViewController.viewModel = DetailsViewModel(with: article.webUrl)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
