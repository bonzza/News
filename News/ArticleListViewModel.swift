//
//  ArticalListViewModel.swift
//  News
//
//  Created by Developer on 2/17/17.
//  Copyright © 2017 Fannec. All rights reserved.
//

import Foundation
import Bond
import ObjectMapper
import Alamofire
import ReactiveKit

class ArticleListViewModel {
    
    var source = Observable<NewsSource?>(NewsSource.IGN)
    var articles = Observable<[Article]?>([])
    var error = Observable<Error?>(nil)
    
    func load(source: NewsSource) {
        let parameters: Parameters = [
            "source" : source.rawValue
        ]
        NewsAPI.request(NewsURL.articles,mappableType: ArticlesResponse.self, parameters: parameters, completeBlock: { [unowned self] (result: Result) in
            switch result {
                case .Success(let obj):
                    guard let articlesResponse = obj as? ArticlesResponse else {
                        return
                    }
                    self.articles.value = articlesResponse.articles
                break
                
                case .Error(let err):
                    self.error.next(err)
                break
            }
            
        })
    }
}
