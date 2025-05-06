//
//  ComicDetailViewModel.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/6/25.
//

import Foundation


@MainActor
class ComicDetailViewModel:ObservableObject {
    private var comicId: Int
   
    init(comicId: Int = 0) {
        self.comicId = comicId
    }

}

