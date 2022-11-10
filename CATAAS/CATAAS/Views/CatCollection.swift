//
//  CatCollection.swift
//  CATAAS
//
//  Created by nate on 11/10/22.
//

import SwiftUI

struct CatCollection: View {
    @EnvironmentObject var consumer: CatConsumer
    
    private static let spacing: CGFloat = 1
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: Self.spacing),
        GridItem(.flexible(), spacing: Self.spacing),
    ]
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemWidth = (geometry.size.width - Self.spacing) / CGFloat(columns.count)
            let imageWidth = gridItemWidth * UIScreen.main.scale
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: Self.spacing) {
                    ForEach(consumer.query.cats) { cat in
                        // request image with appropriate size to reduce bandwidth
                        let imageUrl = cat.imageUrl(width: imageWidth)
                        
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color(UIColor.secondarySystemBackground)
                                .overlay {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.secondaryLabel)))
                                }
                        }
                        .frame(width: gridItemWidth, height: gridItemWidth)
                        .aspectRatio(1, contentMode: .fill)
                        .clipped()
                    }
                }
            }
        }
    }
}

struct CatCollection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CatCollection()
                .environmentObject(CatConsumer(query: CatQuery.exampleQuery()))
        }
    }
}
