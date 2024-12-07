//
//  CustomCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Khaled on 08/12/2024.
//

import UIKit
import SwiftUI

class CustomCollectionViewCell: UICollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        contentConfiguration = nil
    }
}

