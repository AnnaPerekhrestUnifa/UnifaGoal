//
//  TableViewCell.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class SearchCell: UITableViewCell {
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var authour: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var dispoceBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(data: NYTSearchArticle) {
        if let specificMultimedia = data.multimedia?.first,
           let imageUrl = URL(string: "https://static01.nyt.com/\(specificMultimedia.url)") {
            photo.kf.setImage(with: imageUrl, placeholder: nil, options: nil, progressBlock: nil)
        }
        
        authour.text = data.byline?.original
        title.text = data.headline.main
        if let indexOfT = data.pubDate.firstIndex(of: "T") {
            let datePortion = data.pubDate[..<indexOfT]
            let trimmedDate = String(datePortion)
            date.text = trimmedDate
        } else {
            date.text = ""
        }
    }
    
    override func prepareForReuse() {
        dispoceBag = DisposeBag()
    }
}
