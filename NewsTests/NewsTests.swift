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
