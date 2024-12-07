//
//  HomeViewController+Collection.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import UIKit
import SwiftUI

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.filteredCharacters.value.characters?.count).defaultValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        let defaultCharacter = DefaultCharacter()
        let item = self.viewModel?.filteredCharacters.value.characters?[indexPath.row]
        defaultCharacter.character = item
        
        cell.contentConfiguration = UIHostingConfiguration {
            HomeCollectionSwiftUICell(
                character: defaultCharacter,
                width: collectionView.frame.size.width - 12
            )
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 12, height: CGFloat(92))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didSelectRow(at: indexPath.row)
    }
    
}
