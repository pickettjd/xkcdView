//
//  ComicDetailViewModel.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/6/25.
//

import Foundation
import SwiftData

@MainActor
class ComicDetailViewModel: ObservableObject {
    @Published var comic: ComicModel? = nil
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    var comicId: Int
    private var dataManager: DataAPI
    private var context: ModelContext?

    init(comicId: Int, dataManager: DataAPI = DataManager()) {
        self.dataManager = dataManager
        self.comicId = comicId
    }

    func setContext(_ context: ModelContext) {
        self.context = context
    }

    func fetchComic() async {
        guard let context = context else { return }

        do {
            self.isLoading = true
            defer { self.isLoading = false }

            // Check to see if the data exists in the cache first by comicId
            let id = comicId
            let descriptor = FetchDescriptor<CachedComic>(
                predicate: #Predicate { $0.id == id }
            )
            
            if let cachedComic = try? context.fetch(descriptor).first {
                print("Found cached comic \(cachedComic.id)")
                self.comic = ComicModel(cachedComic: cachedComic)
                return
            }
            
            // It was not in the cache - hit the api and store in the cache
            let comic = try await dataManager.fetchComic(comicId: comicId)
            self.comic = comic
            
            // Put the new comic in the cache
            let cachedComic = CachedComic(
                id: comic.id,
                title: comic.title,
                imageUrl: comic.img,
                month: comic.month,
                day: comic.day,
                year: comic.year
            )
            context.insert(cachedComic)
            try context.save()

            print("Cached away comic \(cachedComic.id)...")
        } catch {
            print("Error fetching the provided comic \(comicId): \(error.localizedDescription)")
            errorMessage = "Error fetching the comic"
        }
    }
}
