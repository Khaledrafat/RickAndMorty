//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Khaled on 06/12/2024.
//

import UIKit
import SwiftUI

class CharacterDetailsViewController: UIViewController {
    
    //Variables
    var viewModel: CharacterDetailsViewModel?
    var baseVCActions: BaseViewAction?
    
    private var characterDetailsHostController: UIHostingController<CharacterDetailsView>?
    
    private let defaultCharacter = DefaultCharacter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScreen()
        bind()
        viewModel?.viewDidLoad()
    }
    
    //MARK: - Setup Screen
    private func setupScreen() {
        if baseVCActions == nil {
            baseVCActions = DefaultBaseViewAction()
        }
    }
    
    //MARK: - Bind
    private func bind() {
        //MARK: - Bind Loading
        viewModel?.isLoading.observe(on: self, observerBlock: {
            [weak self] show in
            guard let self = self else { return }
            DispatchQueue.main.async {
                show ? self.baseVCActions?.showLoader(on: self) : self.baseVCActions?.hideLoader()
            }
        })
        
        //MARK: - Bind Alert
        viewModel?.showError.observe(on: self, observerBlock: {
            [weak self] message in
            guard let self = self, !message.isEmpty else { return }
            DispatchQueue.main.async {
                self.baseVCActions?.showAlert(on: self, title: "Error", message: message, action: {
                    self.baseVCActions?.dismissAlert()
                } )
            }
        })
        
        //MARK: - Load Data
        viewModel?.character.observe(on: self, observerBlock: {
            [weak self] character in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.defaultCharacter.character = character
            }
        })
    }
    
}

extension CharacterDetailsViewController {
    //MARK: - Load View
    private func loadUIView(on parent: UIViewController) {
        let swiftUIView = CharacterDetailsView(character: defaultCharacter)
        characterDetailsHostController = UIHostingController(rootView: swiftUIView)
        
        let host = UIHostingController(rootView: swiftUIView)
        addChild(host)
        
        host.view.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height
        )
        view.center = self.view.center
        
        view.addSubview(host.view)
        host.didMove(toParent: self)
        
        host.view.translatesAutoresizingMaskIntoConstraints = false
        self.characterDetailsHostController = host
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.loadUIView(on: self)
    }
}
