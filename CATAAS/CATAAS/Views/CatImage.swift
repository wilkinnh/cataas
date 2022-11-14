//
//  CatImage.swift
//  CATAAS
//
//  Created by nate on 11/13/22.
//

import SwiftUI

struct CatImage: View {
    var url: URL
    
    var body: some View {
        Color(UIColor.secondarySystemBackground)
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        
                    case let .success(image):
                        image
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                        
                    case .failure:
                        Image(systemName: "rectangle.slash")
                            .tint(Color.gray)
                        
                    default:
                        fatalError()
                    }
                }
            }
    }
}

struct CatImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CatImage(url: Cat.examples().first!.imageUrl())
            
            Spacer()
        }
    }
}
