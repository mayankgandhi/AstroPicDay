//
//  PictureListItemView.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import SwiftUI

struct PictureListItemView: View {
    
    let pictureListItem: PictureListItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            AsyncImage(url: pictureListItem.url) { phase in
                switch phase {
                case .empty:
                    ShimmerView()
                        .frame(height: 200) // Placeholder height
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    EmptyView()
                }
            }
            
            
            Text(pictureListItem.title)
                .font(.title)
                .multilineTextAlignment(.leading)
            
            Text(pictureListItem.date)
                .font(.subheadline)
        }
        .padding()
        .cornerRadius(12)
    }
    
}
