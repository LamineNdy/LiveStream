//
//  LiveStreamTests.swift
//  LiveStreamTests
//
//  Created by Lamine Ndiaye on 10/06/2017.
//
//

import XCTest
@testable import LiveStream

class LiveStreamTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Double
    
    private class URLSessionSpy: URLSession {
        
        var swizzledMethodCalled = false
        
        override func customDataTask(with request: URLRequest) -> URLSessionDataTask {
            swizzledMethodCalled = true
            return URLSessionDataTask()
        }
    }
    
    func test_should_call_swizzledMethod_when_request_is_sent() {
        //Given
        let urlSessionSpy = URLSessionSpy()
        let urlRequest = URLRequest(url: URL(string: "www.google.com")!)
        
        //When
        _ = urlSessionSpy.dataTask(with: urlRequest)
        
        //Then
        XCTAssertTrue(urlSessionSpy.swizzledMethodCalled, "customDataTask(with:) method should be called instead of dataTask(with:)")
    }
}
