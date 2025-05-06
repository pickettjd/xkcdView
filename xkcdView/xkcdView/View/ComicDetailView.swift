//
//  ComicDetailView.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/6/25.
//

import SwiftUI

struct ComicDetailView: View {
    @StateObject var viewModel: ComicDetailViewModel
    @State var comicNum: Int
    
    init(comicNumber: Int) {
        self._viewModel = StateObject(wrappedValue: ComicDetailViewModel(comicId: comicNumber))
        self.comicNum = comicNumber
    }
    
    var body: some View {
        Text("Hello Comic \(comicNum)!")
    }
}

#Preview {
    ComicDetailView(comicNumber: 3083)
}
