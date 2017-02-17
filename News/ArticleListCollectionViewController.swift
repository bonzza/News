//
//  ArticleListCollectionViewController.swift
//  News
//
//  Created by Developer on 2/17/17.
//  Copyright © 2017 Fannec. All rights reserved.
//

import UIKit
import Bond
import Kingfisher
import DZNEmptyDataSet
import MBProgressHUD


class ArticleListCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "ArticleCell"

    var viewModel = ArticleListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.emptyDataSetSource = self
        binding()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, reกturn the number of items
        return viewModel.articles.value?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ArticleCollectionViewCell,
            let article = self.viewModel.articles.value?[indexPath.item]
            else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = article.title
        cell.descLabel.text = article.description
        if let imageString = article.image, let url = URL(string: imageString) {
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }
}

extension ArticleListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let col = (collectionView.bounds.size.width / 300).rounded()
        let side = (collectionView.bounds.size.width / col) - 20
        
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
}

extension ArticleListCollectionViewController {
    
    func binding() {
        viewModel.load(source: .IGN)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        _ = viewModel.articles
            .filter(include: { $0?.count != 0 })
            .observeNext { [unowned self] (articles) in
            self.collectionView?.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

extension ArticleListCollectionViewController: DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "No Data"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
}
