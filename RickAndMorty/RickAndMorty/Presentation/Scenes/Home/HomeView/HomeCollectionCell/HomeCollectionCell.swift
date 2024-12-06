//
//  HomeCollectionCell.swift
//  RickAndMorty
//
//  Created by Khaled on 06/12/2024.
//

import UIKit
import SwiftUI

protocol HomeCollectionCell: UICollectionViewCell {
    func configure(character: Character?, width: CGFloat)
}

class DefaultHomeCollectionCell: UICollectionViewCell, HomeCollectionCell {
    
    private var hostingController: UIHostingController<HomeCollectionSwiftUICell>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(character: Character?, width: CGFloat) {
        let cellView = HomeCollectionSwiftUICell(
            name: (character?.name).defaultValue,
            type: (character?.type).defaultValue,
            imageUrl: (character?.image).defaultValue,
            width: width
        )
        
        if let hostingController = hostingController {
            hostingController.rootView = cellView
        } else {
            let hostingController = UIHostingController(rootView: cellView)
            self.hostingController = hostingController
            
            if let view = hostingController.view {
                view.translatesAutoresizingMaskIntoConstraints = false
                view.frame = CGRect(
                    x: 0,
                    y: 0,
                    width: width,
                    height: 100
                )
                view.center = contentView.center
                contentView.addSubview(view)
            }
        }
    }
    
}
