//
//  NoNetworkView.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/8/25.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Icon representing no connectivity
            Image(systemName: "wifi.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)

            Text("You're Currently Offline")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text("Please connect to the internet")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    NoNetworkView()
}
