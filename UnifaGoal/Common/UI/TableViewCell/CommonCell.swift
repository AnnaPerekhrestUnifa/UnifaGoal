//
//  TableViewCell.swift
//  UnifaGoal
//
//  Created by anna.perekhrest on 2024/07/19.
//

import UIKit
import Kingfisher

class CommonCell: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var authour: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(data: Article) {
        if let imageUrl = findImageUrl(from: data.multimedia) {
            photo.kf.setImage(with: imageUrl)
        } else if let media = data.media, let imageUrl = findImageUrl(from: media) {
            photo.kf.setImage(with: imageUrl)
        }
        
        authour.text = data.byline
        title.text = data.title
        if let indexOfT = data.publishedDate.firstIndex(of: "T") {
            let datePortion = data.publishedDate[..<indexOfT]
            let trimmedDate = String(datePortion)
            date.text = trimmedDate
        } else {
            date.text = ""
        }
    }
    
    private func findImageUrl(from multimedia: [Multimedia]?) -> URL? {
        guard let items = multimedia else { return nil }
        guard let maxWidth = items.max(by: { $0.width < $1.width })?.width else { return nil }
        
        if let specificItem = items.first(where: { $0.width == maxWidth }),
           let imageUrl = URL(string: specificItem.url) {
            return imageUrl
        }
        return nil
    }
    
    private func findImageUrl(from media: [Media]) -> URL? {
        let allMetadata = media.flatMap { $0.mediaMetadata }
        guard let maxWidth = allMetadata.max(by: { $0.width < $1.width })?.width else { return nil }
        
        if let specificMetadata = allMetadata.first(where: { $0.width == maxWidth }),
           let imageUrl = URL(string: specificMetadata.url) {
            return imageUrl
        }
        return nil
    }
}
