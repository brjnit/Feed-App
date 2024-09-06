//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Brajesh on 06/09/24.
//

import Foundation

public final class RemoteFeedLoader {
    let client: HTTPClient
    let request: URLRequest
    
    public enum Error: Swift.Error {
        case connectivity
    }
    
   public init(request: URLRequest, client: HTTPClient) {
        self.request = request
        self.client = client
    }
    
    public func load(completion: @escaping (Error)-> Void) {
        client.call(request: request){ error in
            completion(.connectivity)
            
        }
    }
}
