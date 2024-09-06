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
    
   public init(request: URLRequest, client: HTTPClient) {
        self.request = request
        self.client = client
    }
    
    public func load() {
        client.call(request: request)
    }
}
