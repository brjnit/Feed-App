//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Brajesh on 06/09/24.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.call(request:URLRequest(url:  URL(string: "https://a-url.com")!))
    }
}

class HTTPClient {
    func call(request: URLRequest) {}
}

class HTTPClientSpy: HTTPClient {
    
    var request: URLRequest?
    
   override func call(request: URLRequest) {
        self.request = request
    }
}


final class RemoteFeedLoaderTests: XCTestCase {

   
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(client: client)
        XCTAssertNil(client.request)
    }

    func test_load_requestDataFromURL() {
        let client =  HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client)
        
        sut.load()
        
        XCTAssertNotNil(client.request)
    }

}
