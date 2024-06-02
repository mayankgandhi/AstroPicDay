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
                    case .error(let error):
                        VStack(alignment: .center ,spacing: 12) {
                            Image(systemName: "exclamationmark.triangle")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundColor(.red)
                            Text(error)
                        }
                        
                    case .loading:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .task {
                                store.send(.fetchPicturesOfTheWeek)
                            }
                        
                    case .results:
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEachStore(store.scope(state: \.pictureListItems, action: \.pictureListItems)) { store in
                                NavigationLink {
                                    PictureListDetailView(pictureListItem: store.state)
                                } label: {
                                    PictureListItemView(store: store)
                                }
                                .buttonStyle(PlainButtonStyle())
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
