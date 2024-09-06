//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Brajesh on 06/09/24.
//

import XCTest
import EssentialFeed

final class RemoteFeedLoaderTests: XCTestCase {

   
    func test_init_doesNotRequestDataFromURL() {
        let request = createRequest()
        let (_, client) = makeSUT(request)
        XCTAssertNil(client.request)
        XCTAssertEqual(client.requestURLs, [])
    }

    func test_load_requestDataFromURL() {
        let request = createRequest()
        let (sut, client) = makeSUT(request)
        sut.load()
        XCTAssertEqual(client.request, request)
        XCTAssertEqual(client.requestURLs, [request])
    }
    
    func test_loadTwice_requestDataFromURLTwice() {
        let request = createRequest()
        let (sut, client) = makeSUT(request)
        sut.load()
        sut.load()
        XCTAssertEqual(client.request, request)
        XCTAssertEqual(client.requestURLs, [request, request])
    }

    //MARK: - Helpers
    func makeSUT(_ request: URLRequest) -> (sut: RemoteFeedLoader, client: HTTPClientSpy){
        let client =  HTTPClientSpy()
        let sut = RemoteFeedLoader(request: request, client: client)
        return (sut, client)
    }
    func createRequest() -> URLRequest {
        return URLRequest(url:  URL(string: "https://a-url.com")!)
    }
    
    class HTTPClientSpy: HTTPClient {
        
        var request: URLRequest?
        var requestURLs = [URLRequest]()
        func call(request: URLRequest) {
            requestURLs.append(request)
            self.request = request
        }
    }

}
