//
//  Cat.swift
//  CATAAS
//
//  Created by nate on 11/10/22.
//

import Foundation

struct CatQuery: Equatable {
    let query: String
    let cats: [Cat]
}

struct Cat: Equatable, Identifiable {
    var id: String
    var tags: [String]
    var owner: String
}

extension Cat {
    func imageUrl(width: CGFloat? = nil) -> URL {
        guard var components = URLComponents(string: "https://cataas.com/cat/\(id)") else {
            fatalError("malformed url")
        }
        
        // add query parameters
        var queryItems: [URLQueryItem] = []
        
        if let width {
            queryItems.append(URLQueryItem(name: "width", value: "\(Int(width))"))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            fatalError("malformed url")
        }
        return url
    }
}
