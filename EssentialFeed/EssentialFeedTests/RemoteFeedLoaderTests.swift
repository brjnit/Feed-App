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
        XCTAssertEqual(client.requestURLs, [])
    }

    func test_load_requestDataFromURL() {
        let request = createRequest()
        let (sut, client) = makeSUT(request)
        sut.load()
        XCTAssertEqual(client.requestURLs, [request])
    }
    
    func test_loadTwice_requestDataFromURLTwice() {
        let request = createRequest()
        let (sut, client) = makeSUT(request)
        sut.load()
        sut.load()
        XCTAssertEqual(client.requestURLs, [request, request])
    }
    
    func test_load_deliversConnectivityErrorOnClientError() {
        let request = createRequest()
        let (sut, client) = makeSUT(request)
        client.error = NSError(domain: "Test", code: 0)
        var capturedError = [RemoteFeedLoader.Error]()
        sut.load { capturedError.append($0)}
        XCTAssertEqual(capturedError, [.connectivity])
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
        var requestURLs = [URLRequest]()
        var error: NSError?
        func call(request: URLRequest, completion: @escaping (Error)-> Void ) {
            if let error = error {
                completion(error)
            }
            requestURLs.append(request)
           
        }
    }

}
