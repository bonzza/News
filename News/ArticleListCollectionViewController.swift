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




class ArticleListCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "ArticleCell"

    var viewModel = ArticleListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        bindind()

        // Do any additional setup after loading the view.
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AricleCollectionViewCell,
            let article = self.viewModel.articles.value?[indexPath.item]
            else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = article.title
        cell.descLabel.text = article.description
        if let imageString = article.image, let url = URL(string: imageString) {
            cell.imageView.kf.setImage(with: url)
        }

        return cell
    }
}

extension ArticleListCollectionViewController {
    
    func bindind() {
        
        viewModel.load(source: .IGN)
        
        _ = viewModel.articles.observeNext { [unowned self] (articles) in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
}
