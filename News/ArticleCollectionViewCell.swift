//
//  ArticleCollectionViewCell.swift
//  News
//
//  Created by Mac on 2/17/17.
//  Copyright © 2017 Fannec. All rights reserved.
//

import UIKit
import Kingfisher


class ArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func render(article: Article) {
        titleLabel.text = article.title
        descLabel.text = article.description
        if let imageString = article.image, let url = URL(string: imageString) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(named: "image-placeholder")
        }
    }
    
}
