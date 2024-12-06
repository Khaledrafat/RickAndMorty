//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Khaled on 06/12/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    @State var character: Character?
    
    var body: some View {
        ZStack {
            contentView
                .edgesIgnoringSafeArea(.top)
            
            
        }
    }
    
    //MARK: - Content View
    var contentView: some View {
        VStack() {
            if let url = URL(string: (character?.image).defaultValue) {
                AsyncImageView(url: url)
                    .frame(height: 320)
            } else {
                Color.clear
                    .frame(height: 320)
            }
            
            bottomView
                .padding()
            
            Spacer()
        }
    }
    
    //MARK: - Bottom View
    var bottomView: some View {
        VStack(alignment: .leading) {
            nameView
            
            genderView
            
            Spacer()
                .frame(height: 32)
            locationView
        }
    }
    
    //MARK: - name View
    var nameView: some View {
        HStack {
            Text("Zephyr")
                .font(.bold(.largeTitle)())
                .foregroundColor(.black)
            
            Spacer()
            Text("Status")
                .padding(12)
                .background(.cyan)
                .foregroundColor(.white)
                .frame(height: 32)
                .cornerRadius(16)
        }
    }
    
    //MARK: - Gender View
    var genderView: some View {
        HStack {
            Text((character?.type).defaultValue)
                .font(.bold(.title3)())
                .foregroundColor(.black)
            
            Text("●")
                .font(.system(size: 8))
                .foregroundColor(.black)
            
            Text((character?.gender).defaultValue)
                .font(.bold(.title3)())
                .foregroundColor(.gray)
        }
    }
    
    //MARK: - Location View
    var locationView: some View {
        HStack {
            Text("Location :")
                .font(.bold(.title3)())
            
            Text((character?.location?.name).defaultValue)
                .font(.system(size: 18))
                .foregroundColor(.gray)
        }
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView()
    }
}
