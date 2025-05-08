#Quick xkcdViewer


My initial goal was to complete the essential features first and then, if time permitted, add a few additional enhancements.

The core functionality of this project was completed in approximately 5–6 hours. While this time wasn’t spent continuously, it reflects the total effort invested.

- I aimed for the app to be effective, reliable, and streamlined.  
- I prioritized code readability, always keeping in mind “the next poor person” who might need to maintain the code — even if that person is me in the future.  
- I chose to implement the MVVM architecture, as SwiftUI natively supports binding and it’s a widely adopted and familiar pattern.

Here’s an overview of the steps I followed:

- Began with simple sketches to outline the desired functionality.  
- Reviewed the API in Postman to understand the available endpoints.  
- Developed the Model and the DataManager.  
- Built the `ComicSelectionView` (main page) and started work on the `ComicDetailView`.  
- Tested navigation between the two views.  
- Determined that a ViewModel wasn’t necessary for the main view, as it contained minimal business logic.  
- Added the UI components for `ComicDetailView` and implemented the ViewModel to handle its logic.  
- Wrote unit tests to validate functionality.  
- Performed initial code cleanup.

Once the fundamentals were in place, I spentn some additional time  added several improvements:

- Integrated SwiftData for caching. While I don’t have extensive experience with SwiftData, this was a good opportunity to explore it and implement response caching.  
- Identified and resolved several layout issues.  
- Conducted additional code cleanup.
- Added the no network page

