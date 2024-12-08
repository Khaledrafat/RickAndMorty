//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator, HomeCoordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        goHome()
    }
    
    // MARK: - GO Home
    func goHome() {
        let vc = HomeViewController()
        let repo = HomeRepoImp()
        let useCases = DefaultHomeUseCases(homeRepo: repo)
        let homeVM = DefaultHomeViewModel(homeUseCases: useCases)
        homeVM.coordinator = self
        vc.viewModel = homeVM
        navigationController.pushViewController(vc, animated: true)
    }
    
    //MARK: - Open Details
    func openDetails(id: Int) {
        let vc = CharacterDetailsViewController()
        let repo = DefaultCharacterDetailsRepoImp()
        let useCase = DefaultCharacterDetailsUseCase(detailsRepo: repo)
        let vm = DefaultCharacterDetailsViewModel(id: id, useCase: useCase)
        vc.viewModel = vm
        navigationController.pushViewController(vc, animated: true)
    }
    
}
