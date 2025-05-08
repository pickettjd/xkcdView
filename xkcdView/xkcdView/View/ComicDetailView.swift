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
    @EnvironmentObject var networkManager: NetworkManager
    @StateObject var viewModel: ComicDetailViewModel
    
    init(comicNumber: Int) {
        self._viewModel = StateObject(wrappedValue: ComicDetailViewModel(comicId: comicNumber))
    }
    
    var body: some View {
        if networkManager.isConnected {
            ScrollView {
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
                .navigationTitle("Comic #: \(String(viewModel.comicId))")
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
        } else {
            NoNetworkView()
        }
    }
}

#Preview {
    ComicDetailView(comicNumber: 3086)
        .environmentObject(NetworkManager())
}

struct ComicView: View {
    private var comic: ComicModel
    private var comicImgURL: URL
    
    init(comic: ComicModel, comicImgURL: URL ) {
        self.comic = comic
        self.comicImgURL = comicImgURL
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(comic.title)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 30)
            Text(comic.date)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 60)

            AsyncImage(url: comicImgURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 10)
                        .border(.primary, width: 3)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }}
