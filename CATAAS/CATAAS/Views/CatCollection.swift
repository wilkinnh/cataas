//
//  CatCollection.swift
//  CATAAS
//
//  Created by nate on 11/10/22.
//

import SwiftUI

struct CatCollection: View {
    var cats: [Cat]
    
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
                    ForEach(cats) { cat in
                        NavigationLink {
                            CatDetails(cat: cat)
                        } label: {
                            // request image with appropriate size to reduce bandwidth
                            let imageUrl = cat.imageUrl(width: imageWidth)
                            CatCollectionItem(cat: cat, imageUrl: imageUrl)
                        }
                    }
                }
            }
        }
    }
}

struct CatCollectionItem: View {
    var cat: Cat
    var imageUrl: URL
    
    var body: some View {
        CatImage(url: imageUrl)
            .overlay(overlay)
    }
    
    var overlay: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                if !cat.tags.isEmpty {
                    HStack(spacing: 4) {
                        Text("\(cat.tags.count)")
                        Image(systemName: "tag")
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background {
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: geometry.size.height / 2)
                                .fill(Color.black.opacity(0.5))
                        }
                    }
                }
            }
        }
        .padding(5)
        .foregroundColor(.white)
    }
}

struct LoadMoreKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct CatCollection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CatCollection(cats: Cat.examples())
        }
    }
}
