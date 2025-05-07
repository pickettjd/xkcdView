//
//  ComicModel.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/6/25.
//

import Foundation


struct ComicModel: Codable, Identifiable {
    let month: String
    let id: Int
    let link: String?
    let year: String
    let news: String?
    let safeTitle: String
    let transcript: String?
    let alt: String
    let img: String
    let title: String
    let day: String

    enum CodingKeys: String, CodingKey {
        case id = "num"
        case month, link, year, news
        case safeTitle = "safe_title"
        case transcript, alt, img, title, day
    }
    
    var date: String {
        return Date.createDateStringFromComponents(year: year, month: month, day: day)
    }
}
