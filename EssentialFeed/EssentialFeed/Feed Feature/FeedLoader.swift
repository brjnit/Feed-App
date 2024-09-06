//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Brajesh on 06/09/24.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
