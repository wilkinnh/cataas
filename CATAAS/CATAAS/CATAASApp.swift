//
//  CATAASApp.swift
//  CATAAS
//
//  Created by nate on 11/10/22.
//

import SwiftUI

@main
struct CATAASApp: App {
    @StateObject var consumer = CatConsumer(query: CatQuery.exampleQuery())
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CatConjurer()
            }
            .environmentObject(consumer)
        }
    }
}
