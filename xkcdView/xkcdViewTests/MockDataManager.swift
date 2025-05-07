//
//  MockDataManager.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/7/25.
//

import Foundation

@testable import xkcdView

final class MockDataManager: DataAPI {
    var shouldThrowError = false
    
    var mockComic: ComicModel = ComicModel(
        month: "5",
        id: 2000,
        link: "",
        year: "2001",
        news: "",
        safeTitle: "xkcd Phone 2000",
        transcript: "",
        alt: "Our retina display features hundreds of pixels per inch in the central fovea region.",
        img: "https://imgs.xkcd.com/comics/xkcd_phone_2000.png",
        title: "xkcd Phone 2000",
        day: "22"
    )

    func fetchComic(comicId: Int) async throws -> ComicModel {
        if shouldThrowError {
            throw APIError.serverError("Mock error")
        }
        return mockComic
    }
}
