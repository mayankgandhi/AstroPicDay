//
//  PictureListItemView.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PictureListItemView: View {
    
    @Perception.Bindable var store: StoreOf<PictureListItem>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading, spacing: 12) {
                
                AsyncImage(url: store.url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 200) // Placeholder height
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                        
                    case .failure:
                        Image(systemName: "exclamationmark.triangle")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.red)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(store.title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                Text(store.date)
                    .font(.subheadline)
            }
        }
        
    }
    
}
