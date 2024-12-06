//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import Foundation
import SwiftUI

protocol HomeCoordinator: AnyObject {
    func openDetails(id: Int)
}

protocol HomeViewModelInput {
    func viewDidLoad()
    func filter(with type: Filter)
    func didSelectRow(at index: Int)
}

protocol HomeViewModelOutput {
    var characters: Observable<Characters> { get }
    var isLoading: Observable<Bool> { get }
    var showError: Observable<String> { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput { }

//MARK: - DefaultHomeViewModel
final class DefaultHomeViewModel {
    
    var characters: Observable<Characters> = Observable(Characters(info: nil, results: [])) {
        didSet {
            aliveFilter = nil
            deadFilter = nil
            unknownFilter = nil
        }
    }
    var isLoading: Observable<Bool> = Observable(false)
    var showError: Observable<String> = Observable("")
    weak var coordinator: HomeCoordinator?
    
    private var homeUseCases: HomeUseCases
    private var allCharacters: [Character]?
    private var aliveFilter: [Character]?
    private var deadFilter: [Character]?
    private var unknownFilter: [Character]?
    
    init(homeUseCases: HomeUseCases) {
        self.homeUseCases = homeUseCases
    }
}

//MARK: - Implementation
extension DefaultHomeViewModel: HomeViewModel {
    
    func viewDidLoad() {
        self.isLoading.value = true
        homeUseCases.fetchCharacters { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            switch result {
            case .failure(let error):
                self.showError.value = error.localizedDescription
            case .success(let value):
                self.characters.value = value
            }
        }
    }
    
    func didSelectRow(at index: Int) {
        guard let item = self.characters.value.results?[index],
              let id = item.id
        else { return }
        self.coordinator?.openDetails(id: id)
    }
    
    
    
    
    
    
    
    //MARK: - Filter
    func filter(with type: Filter) {
        switch type {
        case .alive:
            guard aliveFilter == nil else { return }
            aliveFilter = homeUseCases.filter(type: type, characters: self.characters.value.results ?? [])
        case .dead:
            guard deadFilter == nil else { return }
            deadFilter = homeUseCases.filter(type: type, characters: self.characters.value.results ?? [])
        case .unknown:
            guard unknownFilter == nil else { return }
            unknownFilter = homeUseCases.filter(type: type, characters: self.characters.value.results ?? [])
        }
    }
}
