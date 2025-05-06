//
//  ComicSelectionView.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/6/25.
//

import SwiftUI

struct ComicSelectionView: View {
    @State private var selectedComicNum:String = ""
    @State private var navPath = NavigationPath()
    
    
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack (spacing: 200) {
                TitleView()
                VStack (alignment: .center) {
                    HStack {
                        Text("Load Comic #:")
                            .font(.headline)
                        TextField("Enter comic #", text: $selectedComicNum)
                            .font(.headline)
                            .padding()
                            .keyboardType(.numberPad)
                            .background(Color(UIColor.secondarySystemBackground))
                            .foregroundColor(.primary)
                            .frame(width: 150)
                    }
                    .padding(.vertical, 30)
                    
                    Button("Submit") {
                        if let num = Int(selectedComicNum) {
                            navPath.append(num)
                        }
                    }
                    .disabled(selectedComicNum.isEmpty)
                    .frame(maxWidth: 200)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .opacity(selectedComicNum.isEmpty ? 0.6 : 1.0)
                }
                Spacer()
            }
            .padding()
            .navigationDestination(for: Int.self) { num in
                ComicDetailView(comicNumber: num)
            }
        }
    }
}

#Preview {
    ComicSelectionView()
}

struct TitleView: View {
    var body: some View {
        HStack {
            Text("xkcd")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("A webcomic of romance, sarcasm, math, and language")
                .font(.footnote)
                .foregroundColor(.secondary)
                .frame(width: 200)
        }
    }
}
