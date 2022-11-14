//
//  CATAASApp.swift
//  CATAAS
//
//  Created by nate on 11/10/22.
//

import SwiftUI

@main
struct CATAASApp: App {
    @StateObject var consumer = CatConsumer()
    @State var cats: [Cat] = []
    @State var isLoading = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CatCollection(cats: cats)
                    .navigationTitle("Cat As A Service")
                    .overlay {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                    }
                    .onAppear {
                        isLoading = true
                        consumer.fetchCats { fetchedCats in
                            cats = fetchedCats
                            isLoading = false
                        }
                    }
            }
            .environmentObject(consumer)
        }
    }
}
