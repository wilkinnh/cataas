//
//  CatConsumer.swift
//  CATAAS
//
//  Created by nate on 11/10/22.
//

import Foundation

class CatConsumer: ObservableObject {
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    func fetchCats(tag: String? = nil, completion: @escaping ([Cat]) -> Void) {
        // if data task is in progress, cancel it
        dataTask?.cancel()
        
        // build request
        guard var urlComponents = URLComponents(string: "https://cataas.com/api/cats?skip=0&limit=10000") else {
            fatalError("malformed CATAAS api request")
        }
        
        if let tag = tag {
            urlComponents.queryItems?.append(URLQueryItem(name: "tags", value: tag))
        }
        
        guard let url = urlComponents.url else {
            fatalError("malformed CATAAS api request")
        }
        
        // create new data task
        dataTask = session.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard let data = data else {
                NSLog("CATAAS api request failed: \(error?.localizedDescription ?? "n/a")")
                return
            }
            
            let decoder = JSONDecoder()
            
            // parse json array
            if let jsonObjects = try? JSONSerialization.jsonObject(with: data) as? [Any] {
                // parse each individual json object so one object doesn't cause the entire list to fail
                let cats = jsonObjects.compactMap { jsonObject in
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonObject)
                        let cat = try decoder.decode(Cat.self, from: jsonData)
                        return cat
                    } catch {
                        NSLog("error parsing CATAAS api response: \(error)")
                        return nil
                    }
                }
                
                DispatchQueue.main.async {
                    completion(cats)
                }
            }
            
            self?.dataTask = nil
        }
        dataTask?.resume()
    }
}
