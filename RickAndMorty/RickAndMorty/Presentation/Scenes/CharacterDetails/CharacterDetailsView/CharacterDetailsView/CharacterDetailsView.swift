//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Khaled on 06/12/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    @ObservedObject var character: DefaultCharacter
    var btnClosure: (()->())?
    
    var body: some View {
        ZStack {
            contentView
                .edgesIgnoringSafeArea(.top)
            
            Button {
                        btnClosure?()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.black)
                    .frame(width: 50, height: 50)
                    .background(.white)
                    .cornerRadius(25)
                    .position(x:50, y:60)
        }
        .background(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    //MARK: - Content View
    var contentView: some View {
        VStack(spacing: 8) {
            if let url = URL(string: (character.character?.image).defaultValue) {
                AsyncImageView(url: url)
                    .frame(height: 350)
                    .cornerRadius(40)
            } else {
                Color.clear
                    .frame(height: 350)
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
            Text((character.character?.name).defaultValue)
                .font(.bold(.largeTitle)())
                .foregroundColor(.black)
            
            Spacer()
            Text((character.character?.status?.rawValue).defaultValue)
                .padding(12)
                .background(character.character?.status?.color ?? .clear)
                .foregroundColor(.black)
                .frame(height: 32)
                .cornerRadius(16)
        }
    }
    
    //MARK: - Gender View
    var genderView: some View {
        HStack {
            Text((character.character?.species).defaultValue)
                .font(.bold(.title3)())
                .foregroundColor(.black)
            
            Text("●")
                .font(.system(size: 8))
                .foregroundColor(.black)
            
            Text((character.character?.gender).defaultValue)
                .font(.bold(.title3)())
                .foregroundColor(.gray)
        }
    }
    
    //MARK: - Location View
    var locationView: some View {
        HStack {
            Text("Location :")
                .font(.bold(.title3)())
            
            Text((character.character?.location?.name).defaultValue)
                .font(.system(size: 18))
                .foregroundColor(.gray)
        }
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(character: DefaultCharacter())
    }
}
