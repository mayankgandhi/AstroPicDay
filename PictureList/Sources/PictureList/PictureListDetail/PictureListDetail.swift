//
//  PictureListDetail.swift
//
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PictureListDetail {
    
    @Dependency(\.networkFetcher) var networkFetcher
    
    @ObservableState
    struct State {
        var image: Data?
        let title: String
        let imageURL: URL
        let formattedDate: String
        let explanation: String
        
        init(image: Data? = nil, title: String, imageURL: URL, formattedDate: String, explanation: String) {
            self.image = image
            self.title = title
            self.imageURL = imageURL
            self.formattedDate = formattedDate
            self.explanation = explanation
        }
    }
    
    enum Action: Equatable {
        case fetchImage
        case presentImage(Data)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchImage:
                return .run(priority: .userInitiated) { [url = state.imageURL] send in
                    let data = try await networkFetcher.fetchData(from: url)
                    await send(.presentImage(data))
                } catch: { error, send in
                    dump(error)
                }
                
            case .presentImage(let imageData):
                state.image = imageData
                return .none
            }
        }
    }
    
}
