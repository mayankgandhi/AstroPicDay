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
                
                if let data = store.image {
                    Image(uiImage: UIImage(data: data) ?? UIImage.add)
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                        .frame(height: 200) // Placeholder height
                }
                
                Group {
                    Text(store.title)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    
                    Text(store.date)
                        .font(.subheadline)
                }
                .padding(.horizontal, 12)
            }
        }
        
    }
    
}
