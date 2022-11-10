//
//  CatConsumer.swift
//  CATAAS
//
//  Created by nate on 11/10/22.
//

import Foundation

class CatConsumer: ObservableObject {
    @Published private(set) var query: CatQuery
    @Published private(set) var isSearching: Bool = false
    
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    init(query: CatQuery) {
        self.query = query
    }
    
    func queryCats(prompt: String) {
        isSearching = true
        
        // if data task is in progress, cancel it
        dataTask?.cancel()
        
        // build request
        let tags = prompt.split(separator: " ").joined(separator: ",")
        guard let url = URL(string: "https://cataas.com/api/cats?tags=\(tags)&skip=0&limit=10") else {
            fatalError("malformed CATAAS api request")
        }
        
        // create new data task
        dataTask = session.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard let data = data else {
                NSLog("CATAAS api request failed: \(error?.localizedDescription ?? "n/a")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cats = try decoder.decode([Cat].self, from: data)
                
                DispatchQueue.main.async {
                    self?.query = CatQuery(query: prompt, cats: cats)
                }
            } catch {
                NSLog("error parsing CATAAS api response: \(error.localizedDescription)")
            }
            
            self?.dataTask = nil
        }
        dataTask?.resume()
    }
}
