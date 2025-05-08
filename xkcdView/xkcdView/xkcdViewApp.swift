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
    @StateObject private var networkManager = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            ComicSelectionView()
                .environmentObject(networkManager)
        }
        .modelContainer(for: CachedComic.self)
    }
}
