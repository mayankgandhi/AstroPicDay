import XCTest
@testable import PictureList
import Utils
import ComposableArchitecture
import UtilsTests

@MainActor
final class PictureListTests: XCTestCase {

    func testFetchPicturesOfTheWeek_Success() async throws {
        
        let mockData = """
        [
          {
            "copyright": "\\nPhil Hart\\n",
            "date": "2024-04-02",
            "explanation": "Only in the fleeting darkness of a total solar eclipse is the light of the solar corona easily visible.",
            "hdurl": "https://apod.nasa.gov/apod/image/2404/CoronaExmouth_Hart_1920.jpg",
            "media_type": "image",
            "service_version": "v1",
            "title": "Detailed View of a Solar Eclipse Corona",
            "url": "https://apod.nasa.gov/apod/image/2404/CoronaExmouth_Hart_1080.jpg"
          }
        ]
        """.data(using: .utf8)!
        
        let requestController = MockRequestControllerWithSingularData(mockResponse: mockData)
                
        let store = TestStore(
            initialState: PictureList.State(),
            reducer: { PictureList() }
        ) {
            $0.requestController = requestController
        }

        XCTAssertEqual(store.state.viewState, .loading)
        
        await store.send(.fetchPicturesOfTheWeek)

        await store.receive(.presentPicturesOfTheWeek([
            PictureListItem.State(date: "2 Apr 2024", explanation: "Only in the fleeting darkness of a total solar eclipse is the light of the solar corona easily visible.", hdurl: URL(string: "https://apod.nasa.gov/apod/image/2404/CoronaExmouth_Hart_1920.jpg"), mediaType: "image", serviceVersion: "v1", title: "Detailed View of a Solar Eclipse Corona", url: URL(string: "https://apod.nasa.gov/apod/image/2404/CoronaExmouth_Hart_1080.jpg")!, copyright: "\nPhil Hart\n")
        ])) {
            $0.pictureListItems = IdentifiedArray(uniqueElements: [
                PictureListItem.State(date: "2 Apr 2024", explanation: "Only in the fleeting darkness of a total solar eclipse is the light of the solar corona easily visible.", hdurl: URL(string: "https://apod.nasa.gov/apod/image/2404/CoronaExmouth_Hart_1920.jpg"), mediaType: "image", serviceVersion: "v1", title: "Detailed View of a Solar Eclipse Corona", url: URL(string: "https://apod.nasa.gov/apod/image/2404/CoronaExmouth_Hart_1080.jpg")!, copyright: "\nPhil Hart\n")
            ])
            
            $0.viewState = .results
        }
        
    }

}
