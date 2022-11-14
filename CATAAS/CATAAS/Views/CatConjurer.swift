//
//  CatConjurer.swift
//  CATAAS
//
//  Created by nate on 11/10/22.
//

import SwiftUI

struct CatConjurer: View {
    var tag: String
    @State var cats: [Cat] = []
    @State var isLoading = false
    
    @EnvironmentObject var consumer: CatConsumer
    
    var body: some View {
        CatCollection(cats: cats)
            .navigationTitle(tag)
            .overlay {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .onAppear {
                isLoading = true
                consumer.fetchCats(tag: tag) { fetchedCats in
                    cats.append(contentsOf: fetchedCats)
                    isLoading = false
                }
            }
    }
    
    func fetchPage(_ page: Int) {
        NSLog("load page \(page)")
        
    }
}

struct CatConjurer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CatConjurer(tag: "black cat")
                .environmentObject(CatConsumer())
        }
    }
}
