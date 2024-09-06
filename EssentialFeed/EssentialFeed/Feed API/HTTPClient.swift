//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Brajesh on 06/09/24.
//

import Foundation


public protocol HTTPClient {
    func call(request: URLRequest, completion: @escaping (Error?, HTTPURLResponse?)-> Void )
}
