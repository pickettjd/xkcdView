//
//  xkcdViewTests.swift
//  xkcdViewTests
//
//  Created by Jeff Pickett on 5/6/25.
//

import XCTest
@testable import xkcdView

@MainActor
final class ComicDetailViewModelTests: XCTestCase {
    
    var mockDataManager: MockDataManager!
    
    override func setUp() {
        super.setUp()
        mockDataManager = MockDataManager()
    }
    
    func testFetchComicSuccess() async {
        let viewModel = ComicDetailViewModel(comicId: 2000, dataManager: mockDataManager)
        
        await viewModel.fetchComic()
        
        let comic = viewModel.comic
        
        XCTAssertNotNil(comic)
        XCTAssertEqual(comic?.id, 2000) 
        XCTAssertEqual(comic?.month, "5")
        XCTAssertEqual(comic?.day, "22")
        XCTAssertEqual(comic?.year, "2001")
        XCTAssertEqual(comic?.link, "")
        XCTAssertEqual(comic?.news, "")
        XCTAssertEqual(comic?.safeTitle, "xkcd Phone 2000")
        XCTAssertEqual(comic?.transcript, "")
        XCTAssertEqual(comic?.alt, "Our retina display features hundreds of pixels per inch in the central fovea region.")
        XCTAssertEqual(comic?.img, "https://imgs.xkcd.com/comics/xkcd_phone_2000.png")
        XCTAssertEqual(comic?.title, "xkcd Phone 2000")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchComicFailure() async {
        mockDataManager.shouldThrowError = true
        let viewModel = ComicDetailViewModel(comicId: 2000, dataManager: mockDataManager)
        
        await viewModel.fetchComic()
        
        XCTAssertNil(viewModel.comic)
        XCTAssertEqual(viewModel.errorMessage, "Error fetching the comic")
        XCTAssertFalse(viewModel.isLoading)
    }
}

    
