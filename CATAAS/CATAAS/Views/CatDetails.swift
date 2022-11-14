//
//  CatDetails.swift
//  CATAAS
//
//  Created by nate on 11/13/22.
//

import SwiftUI

struct CatDetails: View {
    var cat: Cat
    
    var body: some View {
        GeometryReader { geometry in
            List {
                if !cat.filteredTags.isEmpty {
                    Section("Tags") {
                        ForEach(cat.filteredTags, id: \.self) { tag in
                            NavigationLink {
                                CatConjurer(tag: tag)
                            } label: {
                                Text(tag)
                            }
                        }
                    }
                }
                
                if let owner = cat.owner, owner != "null" {
                    Section("Owner") {
                        Text(owner)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            // square image, pad top and overlay image
            .padding(.top, geometry.size.width)
            .overlay {
                VStack {
                    CatImage(url: cat.imageUrl(width: geometry.size.width * UIScreen.main.scale))
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: cat.imageUrl())
            }
        }
    }
}

struct CatDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CatDetails(cat: Cat.examples().randomElement()!)
                .environmentObject(CatConsumer())
        }
    }
}
