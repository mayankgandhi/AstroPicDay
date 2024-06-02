//
//  PictureListDetailView.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PictureListDetailView: View {
    
    @Perception.Bindable var store: StoreOf<PictureListDetail>
    
    init(detail: PictureListDetail.State) {
        self.store = Store(initialState: detail, reducer: {
            PictureListDetail()
        })
    }
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(store.title)
                        .font(.headline)
                    
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

                    VStack(alignment: .leading, spacing: 8) {
                        Text(store.explanation)
                        Text(store.formattedDate)
                            .font(.footnote)
                    }
                }
                .padding(.all, 12)
                .navigationTitle(Text(verbatim: store.formattedDate))
                .navigationBarTitleDisplayMode(.automatic)
                .task {
                    store.send(.fetchImage)
                }
            }

        }
    }
}
