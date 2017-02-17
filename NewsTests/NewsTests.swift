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
    
    func testArticleSuccess() {
        
        let exp = expectation(description: "Load response")
        NewsAPI.request(path: "", mappableType: ArticlesResponse.self) { (obj, error) in
            guard let articalsResponse = obj as? ArticlesResponse else {
                XCTFail()
                return
            }
            XCTAssertEqual(articalsResponse.articles?.count, 5)
            XCTAssertEqual(articalsResponse.articles?[0].title, "Crunch Report")
            XCTAssertEqual(articalsResponse.articles?[0].description, "Your daily roundup of the biggest TechCrunch stories and startup news.")
            XCTAssertEqual(articalsResponse.articles?[0].url, "https://techcrunch.com/video/crunchreport/")
            XCTAssertEqual(articalsResponse.articles?[0].image, "https://tctechcrunch2011.files.wordpress.com/2015/03/tccrshowogo.jpg?w=500&h=200&crop=1")
//            XCTAssert(articalsResponse?.articles?[0].date == "https://tctechcrunch2011.files.wordpress.com/2015/03/tccrshowogo.jpg?w=500&h=200&crop=1")
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
