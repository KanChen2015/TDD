//
//  APIClientTests.swift
//  TDD
//
//  Created by Kan Chen on 7/7/16.
//  Copyright © 2016 drchrono. All rights reserved.
//

import XCTest
@testable import TDD

class APIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin_MakesRequestWithUsernameAndPassword() {
        let sut = APIClient()
        let mockURLSession = MockURLSession()
//        sut.session = mockURLSession
    }
}

extension APIClientTests {
    class MockURLSession {
        typealias Handler = (Data?, URLResponse?, NSError?) -> Void
        var completionHandler: Handler?
        var url: URL?
        func dataTaskWithURL(_ url: URL, completion: @escaping (Data?, URLResponse?, NSError?) -> Void) -> URLSessionTask {
            self.url = url
            self.completionHandler = completion
            return URLSession.shared.dataTask(with: url)
        }
    }
}
