//
//  AlertView.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import SwiftUI

struct AlertView: View {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    let action: (() -> Void)?

    var body: some View {
        Text("")
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: .cancel(Text("OK")) {
                        action?()
                    }
                )
            }
    }
}
