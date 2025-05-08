//
//  xkcdViewApp.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/6/25.
//

import SwiftUI
import SwiftData

@main
struct xkcdViewApp: App {
    var body: some Scene {
        WindowGroup {
            ComicSelectionView()
        }
        .modelContainer(for: CachedComic.self)
    }
}
