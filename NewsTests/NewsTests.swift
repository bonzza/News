//
//  NewsTests.swift
//  NewsTests
//
//  Created by Developer on 2/16/17.
//  Copyright © 2017 Fannec. All rights reserved.
//

import XCTest
@testable import News

class NewsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testArticleViewModelIGN() {
        
        let exp = expectation(description: "Load response")
        let viewModel = ArticleListViewModel()
        viewModel.load(source: .Engadget)
        _ = viewModel.articles
            .ignoreNil()
            .filter(include: { $0.count > 0 })
            .observeNext { (articles) in
                
                XCTAssertNotNil(articles.first)
                XCTAssertNotNil(articles.first?.title)
                XCTAssertNotNil(articles.first?.description)
                XCTAssertNotNil(articles.first?.image)
                XCTAssertNotNil(articles.first?.url)
                
                /* Oprional */
                // XCTAssertNotNil(articles.first?.author)
                // XCTAssertNotNil(articles.first?.date)
                
                exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testArticleViewModelNationalGeographic() {
        
        let exp = expectation(description: "Load response")
        let viewModel = ArticleListViewModel()
        viewModel.load(source: .NationalGeographic)
        _ = viewModel.articles
            .ignoreNil()
            .filter(include: { $0.count > 0 })
            .observeNext { (articles) in
                
                XCTAssertNotNil(articles.first)
                XCTAssertNotNil(articles.first?.title)
                XCTAssertNotNil(articles.first?.description)
                XCTAssertNotNil(articles.first?.image)
                XCTAssertNotNil(articles.first?.url)
                
                /* Oprional */
                // XCTAssertNotNil(articles.first?.author)
                // XCTAssertNotNil(articles.first?.date)
                
                exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testArticleViewModelErrorResponse() {
        
        let exp = expectation(description: "Load response")
        let viewModel = ArticleListViewModel()
        viewModel.load(source: .ErrorTest)
        _ = viewModel.error
            .observeNext { (articles) in
                
                exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
