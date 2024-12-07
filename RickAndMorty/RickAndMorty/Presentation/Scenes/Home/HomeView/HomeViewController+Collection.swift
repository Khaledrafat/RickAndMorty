//
//  HomeViewController+Collection.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.filteredCharacters.value.characters?.count).defaultValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultHomeCollectionCell", for: indexPath) as? HomeCollectionCell else {
//            return UICollectionViewCell()
//        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as? TestCell else {
            return UICollectionViewCell()
        }
        
        cell.nameLbl.text = viewModel?.filteredCharacters.value.characters?[indexPath.row].name
        
        cell.statusLbl.text = viewModel?.filteredCharacters.value.characters?[indexPath.row].status?.rawValue
        
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
