//
//  AsyncImageView.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    let placeholder: Image

    init(url: URL, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                placeholder
            }
        }
        .onAppear {
            loader.load()
        }
    }
}
