# AstroPicDay - Astronomy Picture of the day

## Features
`AstroPicDay` is an iOS App built in SwiftUI with minimum deployment version iOS 15. A list of last 7 days of Astronomy picture of the day from the NASA API. Tapping on each image presents a detail view with a sneak peek of the picture with it's description.

## System Design
The Application is built using a multi-package architecture using SPM with each of the modules used are built using Composable Architecture(TCA).

The Application is divided into 2 packages: 
- `Utils`: This package contains utilities(building blocks) needed for feature implementation like:
    - Generic Networking Layer
    - Data Caching mechanism for caching images
    - Custom Date Formatter

- `PictureList`: This package contains the core feature implementation of the main list view, each list item in the view and the detail view.

## Implementation Details

- The `ContentView` loads the `PictureListView` using the factory that abstracts the TCA Store and Reducer initialisation.

- The `PictureListView` has various view enumerations i.e. error, results and loading states to present based on the response from the API.

- The API call is made using `RequestController` that takes in a custom request object `FetchPicturesRequest` and parses the data received into `FetchPicturesResponse`. 

- `RequestController` also has a fallback mechanism to parse the error response in case there is an API error, and present to the user on screen.

- All the dependencies are injected using `@Dependencies` property wrapper that comes with `swift-dependencies`.

- The `PictureListView` contains manual lazy loading logic that presents a list of pictures with an image fetcher loading images once the listItem appears on the screen.

- This manual lazy loading logic can be extended to implement a prefetching logic for the list where a few following items of the list are prefetched to present on the screen.

- Unit testing is implemented for `PictureListView` and some utility tools with all tests passing.

