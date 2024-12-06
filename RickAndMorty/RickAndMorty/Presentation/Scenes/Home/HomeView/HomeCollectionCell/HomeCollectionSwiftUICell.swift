//
//  HomeCollectionSwiftUICell.swift
//  RickAndMorty
//
//  Created by Khaled on 06/12/2024.
//

import SwiftUI

struct HomeCollectionSwiftUICell: View {
    
    var name: String
    var type: String
    var imageUrl: String?
    var width: CGFloat
    
    //MARK: - Body
    var body: some View {
        HStack {
            contentView
            
            Spacer()
        }
        .padding()
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 0.5)
        )
        .padding()
        .frame(width: width, height: 92)
    }
    
    //MARK: - Content View
    var contentView: some View {
        HStack(alignment: .top) {
            if let url = URL(string: imageUrl.defaultValue) {
                AsyncImageView(url: url)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            } else {
                //Can Use Default Image Here
                Color.clear
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.system(size: 20))
                
                Text("Type")
                    .font(.system(size: 14))
            }
        }
    }
}

struct HomeCollectionSwiftUICell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCollectionSwiftUICell(name: "Test", type: "Type", imageUrl: nil, width: 200)
    }
}
