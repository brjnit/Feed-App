//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Brajesh on 06/09/24.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    let request: URLRequest
    
    init(request: URLRequest, client: HTTPClient) {
        self.request = request
        self.client = client
    }
    
    func load() {
        client.call(request: request)
    }
}

protocol HTTPClient {
    func call(request: URLRequest)
}

final class RemoteFeedLoaderTests: XCTestCase {

   
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertNil(client.request)
    }

    func test_load_requestDataFromURL() {
        let (sut, client) = makeSUT()
        sut.load()
        XCTAssertNotNil(client.request)
    }

    //MARK: - Helpers
    func makeSUT() -> (sut: RemoteFeedLoader, client: HTTPClientSpy){
        let client =  HTTPClientSpy()
        let sut = RemoteFeedLoader(request: createRequest(), client: client)
        return (sut, client)
    }
    func createRequest() -> URLRequest {
        return URLRequest(url:  URL(string: "https://a-url.com")!)
    }
    
    class HTTPClientSpy: HTTPClient {
        
        var request: URLRequest?
        
        func call(request: URLRequest) {
            self.request = request
        }
    }

}
