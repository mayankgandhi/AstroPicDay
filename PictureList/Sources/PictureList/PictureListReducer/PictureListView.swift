//
//  PictureListView.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Utils

public struct PictureListView: View {
    
    @Perception.Bindable var store: StoreOf<PictureList>
    
    public init() {
        self.store = Store(initialState: PictureList.State(),
                           reducer: { PictureList() })
    }
    
    public var body: some View {
        NavigationView {
            WithPerceptionTracking {
                ScrollView(.vertical, showsIndicators: true) {
                    switch store.viewState {
                    case .error:
                        Text("Error")
                        
                    case .loading:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .task {
                                store.send(.fetchPicturesOfTheWeek)
                            }
                        
                    case .results:
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(store.pictureListItems) { pictureListItem in
                                NavigationLink {
                                    PictureListDetailView(pictureListItem: pictureListItem)
                                } label: {
                                    PictureListItemView(pictureListItem: pictureListItem)
                                }
                            }
                        }
                    }
                }
                .refreshable {
                    store.send(.fetchPicturesOfTheWeek)
                }
            }
            .navigationTitle("Picture of the day")
        }
    }
}
