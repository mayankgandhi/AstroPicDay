//
//  PictureListItem.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PictureListItem {
    
    @Dependency(\.networkFetcher) var networkFetcher
    
    @ObservableState
    struct State: Equatable, Identifiable, Codable {
        var id: UUID = UUID()
        let date, explanation: String
        let hdurl: URL?
        let mediaType, serviceVersion, title: String
        let url: URL
        let copyright: String?
        var image: Data?
    }
    
    @CasePathable
    enum Action {
        case cellAppeared
        case cellDisappeared
        
        case presentImage(Data)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .presentImage(let imageData):
                state.image = imageData
                return .none
                
            case .cellAppeared:
                return .run(priority: .userInitiated) { [url = state.url] send in
                    let data = try await networkFetcher.fetchData(from: url)
                    await send(.presentImage(data))
                } catch: { error, send in
                    dump(error)
                    #warning("Handle this error scenario")
                }
                
            case .cellDisappeared:
                networkFetcher.cancelFetch(for: state.url)
                return .none
            }
        }
    }
    
   
}
