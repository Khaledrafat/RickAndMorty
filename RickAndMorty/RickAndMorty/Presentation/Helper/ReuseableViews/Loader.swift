//
//  Loader.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import SwiftUI

struct Loader: View {
    var body: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
