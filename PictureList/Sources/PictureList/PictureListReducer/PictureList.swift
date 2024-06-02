//
//  PictureList.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation
import ComposableArchitecture
import Utils

///▿ Optional("{\n  \"error\": {\n    \"code\": \"OVER_RATE_LIMIT\",\n    \"message\": \"You have exceeded your rate limit. Try again later or contact us at https://api.nasa.gov:443/contact/ for assistance\"\n  }\n}")

#warning("Get the Error response handling with parsing and showing the error message to the user")
#warning("Fix the image layout issue in PictureListItem and detail view")
#warning("Add an enum for the short date type")
#warning("Optimise for memory allocation")

@Reducer
struct PictureList {
    
    @Dependency(\.requestController) var requestController
    @Dependency(\.customDateFormatter) var customDateFormatter

    @ObservableState
    struct State: Equatable {
        var viewState: ViewEnumeration
        var pictureListItems: IdentifiedArrayOf<PictureListItem>
        
        init() {
            self.viewState = .loading
            self.pictureListItems = IdentifiedArrayOf<PictureListItem>()
        }
    }
    
    enum Action {
        case fetchPicturesOfTheWeek
        case presentPicturesOfTheWeek([PictureListItem])
        case presentError
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .fetchPicturesOfTheWeek:
                state.viewState = .loading
                let calendar = Calendar.current
                let today = Date()
                guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: today) else {
                    return .send(.presentError)
                }
                return .run(priority: .userInitiated, operation: { send in
                    let request = FetchPicturesRequest(startDate: try customDateFormatter.format(inputDate: today, to: "yyyy-MM-dd"), endDate: try customDateFormatter.format(inputDate: sevenDaysAgo, to: "yyyy-MM-dd"))
                    let response: [FetchPicturesResponse] = try await requestController.fetch(request: request)
                    let pictureListItems = try response.map { responseObj in
                        let date = try customDateFormatter.format(date: responseObj.date, from: "yyyy-MM-dd", to: "d MMM yyyy")
                        return PictureListItem(date: date, explanation: responseObj.explanation, hdurl: responseObj.hdurl, mediaType: responseObj.mediaType, serviceVersion: responseObj.serviceVersion, title: responseObj.title, url: responseObj.url, copyright: responseObj.copyright)
                    }
                    await send(.presentPicturesOfTheWeek(pictureListItems))
                }, catch: { error, send in
                    dump(error)
                    await send(.presentError)
                })
                
            case .presentPicturesOfTheWeek(let pictureListItems):
                state.pictureListItems = IdentifiedArray(uniqueElements: pictureListItems)
                state.viewState = .results
                return .none
                
            case .presentError:
                state.viewState = .error
                return .none
            }
        }
    }
    
}


