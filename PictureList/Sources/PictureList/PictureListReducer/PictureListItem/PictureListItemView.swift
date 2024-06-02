//
//  PictureListItemView.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Utils

struct PictureListItemView: View {
    
    @Perception.Bindable var store: StoreOf<PictureListItem>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading, spacing: 12) {
                
                Group {
                    if let data = store.image {
                        if let uiImage = UIImage(data: data) {
                            Image(uiImage:  uiImage)
                                .resizable()
                                .scaledToFit()
                        } else {
                            VStack(alignment: .center) {
                                Image(uiImage: UIImage(systemName: "exclamationmark.triangle.fill") ?? .add)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 200)
                
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
