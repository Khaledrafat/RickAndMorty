//
//  TestCell.swift
//  RickAndMorty
//
//  Created by Khaled on 07/12/2024.
//

import UIKit

class TestCell: UICollectionViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(character: Character?) {
        self.nameLbl.text = character?.name
        self.statusLbl.text = character?.status?.rawValue
    }

}
