//
//  ComicDetailViewModel.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/6/25.
//

import Foundation

@MainActor
class ComicDetailViewModel: ObservableObject {
    @Published var comic: ComicModel? = nil
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    var comicId: Int
    private var dataManager: DataAPI
    
    init(comicId: Int, dataManager: DataAPI = DataManager()) {
        self.dataManager = dataManager
        self.comicId = comicId
    }
    func fetchComic() async {
        do {
            self.isLoading = true
            defer { self.isLoading = false }
            
            let comic = try await dataManager.fetchComic(comicId: comicId)
            self.comic = comic
        } catch {
            print("Error fetching the provided comic \(comicId): \(error.localizedDescription)")
            errorMessage = "Error fetching the comic"
        }
    }
}
