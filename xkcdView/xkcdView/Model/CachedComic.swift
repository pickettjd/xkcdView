//
//  CachedComic.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/7/25.
//

import Foundation
import SwiftData

@Model
class CachedComic {
    @Attribute(.unique) var id: Int
    var title: String
    var imageUrl: String
    var month: String
    var day: String
    var year: String

    init(id: Int, title: String, imageUrl: String, month: String, day: String, year: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.month = month
        self.day = day
        self.year = year
    }
}
