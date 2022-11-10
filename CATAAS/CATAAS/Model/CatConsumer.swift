//
//  CatConsumer.swift
//  CATAAS
//
//  Created by nate on 11/10/22.
//

import Foundation

class CatConsumer: ObservableObject {
    @Published private(set) var query: CatQuery
    
    init(query: CatQuery) {
        self.query = query
    }
}
