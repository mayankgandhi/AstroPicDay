//
//  PictureList.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import ComposableArchitecture
import Utils

@Reducer
struct PictureList {
    
    @Dependency(\.requestController) var requestController
    @Dependency(\.customDateFormatter) var customDateFormatter

    @ObservableState
    struct State: Equatable {
        var viewState: ViewEnumeration
        var pictureListItems: IdentifiedArrayOf<PictureListItem.State>
        
        init() {
            self.viewState = .loading
            self.pictureListItems = IdentifiedArrayOf<PictureListItem.State>()
        }
    }
    
    enum Action: Equatable {
        case pictureListItems(IdentifiedActionOf<PictureListItem>)
        case fetchPicturesOfTheWeek
        case presentPicturesOfTheWeek([PictureListItem.State])
        case presentError(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .fetchPicturesOfTheWeek:
                state.viewState = .loading
                let calendar = Calendar.current
                let today = Date()
                guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -6, to: today) else {
                    return .send(.presentError("Error occurred - Please try again"))
                }
                return .run(priority: .userInitiated, operation: { send in
                    let todayDateString = try customDateFormatter.format(inputDate: sevenDaysAgo, to: "yyyy-MM-dd")
                    let sevenDaysAgoDateString = try customDateFormatter.format(inputDate: today, to: "yyyy-MM-dd")
                    let request = FetchPicturesRequest(startDate: todayDateString, endDate:  sevenDaysAgoDateString)
                    let response: [FetchPicturesResponse] = try await requestController.fetch(request: request)
                    let pictureListItems = try response.map { responseObj in
                        let date = try customDateFormatter.format(date: responseObj.date, from: "yyyy-MM-dd", to: "d MMM yyyy")
                        return PictureListItem.State(date: date, explanation: responseObj.explanation, hdurl: responseObj.hdurl, mediaType: responseObj.mediaType, serviceVersion: responseObj.serviceVersion, title: responseObj.title, url: responseObj.url, copyright: responseObj.copyright)
                    }
                    await send(.presentPicturesOfTheWeek(pictureListItems))
                }, catch: { error, send in
                    dump(error)
                    if let errorResponse = error as? ErrorResponse {
                        await send(.presentError(errorResponse.msg))
                    } else {
                        await send(.presentError("Error occurred - Please try again"))
                    }
                   
                })
                
            case .presentPicturesOfTheWeek(let pictureListItems):
                state.pictureListItems = IdentifiedArray(uniqueElements: pictureListItems)
                state.viewState = .results
                return .none
                
            case .presentError(let error):
                state.viewState = .error(error)
                return .none
            
            default:
                return .none
            }
        }
        .forEach(\.pictureListItems, action: \.pictureListItems) {
            PictureListItem()
        }
    }
    
}


