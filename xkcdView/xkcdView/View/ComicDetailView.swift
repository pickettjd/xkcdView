//
//  ComicDetailView.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/6/25.
//

import SwiftUI

struct ComicDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: ComicDetailViewModel
    
    init(comicNumber: Int) {
        self._viewModel = StateObject(wrappedValue: ComicDetailViewModel(comicId: comicNumber))
    }
    
    var body: some View {
        VStack (alignment: .center) {
            if viewModel.isLoading {
                ProgressView()
            } else if let comic = viewModel.comic,
                      let url = URL(string: comic.img) {
                ComicView(comic: comic, comicImgURL: url)
            } else {
                EmptyView()
            }
        }
        .navigationTitle("xkcd Comic #\(viewModel.comicId)")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), presenting: viewModel.errorMessage) { errorMessage in
            Button("Ok", role: .cancel) {
                viewModel.errorMessage = nil
                dismiss()
            }
        } message: { errorMsg in
            Text(errorMsg)
        }
        .task {
            viewModel.setContext(modelContext)
            await viewModel.fetchComic()
        }
    }
}

#Preview {
    ComicDetailView(comicNumber: 111)
}

struct ComicView: View {
    private var comic: ComicModel
    private var comicImgURL: URL
    
    init(comic: ComicModel, comicImgURL: URL ) {
        self.comic = comic
        self.comicImgURL = comicImgURL
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("\(comic.title)")
                .font(.headline)
                .fontWeight(.bold)
            
            AsyncImage(url: comicImgURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 10)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            .padding()
            Text("\(comic.date)")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}
