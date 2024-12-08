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
    
    private let defaultCharacter = DefaultCharacter()
    
    //MARK: - Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScreen()
        bind()
        loadUIView(on: self)
    }
    
    //MARK: - Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        viewModel?.viewWillAppear()
    }
    
    //MARK: - Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Setup Screen
    private func setupScreen() {
        if baseVCActions == nil {
            baseVCActions = DefaultBaseViewAction()
        }
    }
    
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
        var swiftUIView = CharacterDetailsView(character: defaultCharacter)
        swiftUIView.btnClosure = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        let vc = UIHostingController(rootView: swiftUIView)
        
        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(vc)
        view.addSubview(swiftuiView)
        
        NSLayoutConstraint.activate([
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            swiftuiView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        vc.didMove(toParent: self)
    }
    
}
