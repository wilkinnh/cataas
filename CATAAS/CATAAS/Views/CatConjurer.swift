//
//  CatConjurer.swift
//  CATAAS
//
//  Created by nate on 11/10/22.
//

import SwiftUI

struct CatConjurer: View {
    @EnvironmentObject var consumer: CatConsumer
    
    @State private var searchText: String = ""
    
    var body: some View {
        CatCollection()
            .navigationTitle("Cat As A Service")
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search for cats")
            .onSubmit(of: .search) {
                consumer.queryCats(prompt: searchText)
            }
    }
}

struct CatConjurer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CatConjurer()
                .environmentObject(CatConsumer(query: CatQuery.exampleQuery()))
        }
    }
}
