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
    
    @ObservableState
    struct State: Equatable, Identifiable, Codable {
        var id: UUID = UUID()
        let date, explanation: String
        let hdurl: URL?
        let mediaType, serviceVersion, title: String
        let url: URL
        let copyright: String?
    }
    
    enum Action {
        case cellAppeared
        case cellDisappeared
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cellAppeared:
                return .none
                
            case .cellDisappeared:
                return .none
            }
        }
    }
    
   
}
