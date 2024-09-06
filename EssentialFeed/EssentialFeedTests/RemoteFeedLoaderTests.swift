//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Brajesh on 06/09/24.
//

import XCTest

class RemoteFeedLoader {
    
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}

class HTTPClient {
    static var shared = HTTPClient()
    
    private init() {}
    
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

   
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }

}
