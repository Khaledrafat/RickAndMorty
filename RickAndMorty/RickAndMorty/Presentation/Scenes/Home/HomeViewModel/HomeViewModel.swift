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
    func filter(with type: CharacterFilter)
    func didSelectRow(at index: Int)
}

protocol HomeViewModelOutput {
    var filteredCharacters: Observable<FilteredCharacters> { get }
    var isLoading: Observable<Bool> { get }
    var showError: Observable<String> { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput { }

//MARK: - DefaultHomeViewModel
final class DefaultHomeViewModel {
    
    var filteredCharacters: Observable<FilteredCharacters> = Observable(FilteredCharacters())
    var isLoading: Observable<Bool> = Observable(false)
    var showError: Observable<String> = Observable("")
    weak var coordinator: HomeCoordinator?
    
    private var homeUseCases: HomeUseCases
    private var characters: Characters?
    
    init(homeUseCases: HomeUseCases) {
        self.homeUseCases = homeUseCases
    }
}

extension DefaultHomeViewModel: HomeViewModel {
    //MARK: - ViewDidLoad
    func viewDidLoad() {
        self.isLoading.value = true
        homeUseCases.fetchCharacters { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            switch result {
            case .failure(let error):
                self.showError.value = error.localizedDescription
            case .success(let value):
                self.characters = value
                self.filteredCharacters.value = FilteredCharacters(characters: value.results, filter: .all)
            }
        }
    }
    
    //MARK: - Did Select Row
    func didSelectRow(at index: Int) {
        guard let item = self.filteredCharacters.value.characters?[index],
              let id = item.id
        else { return }
        self.coordinator?.openDetails(id: id)
    }
    
    //MARK: - Filter
    func filter(with type: CharacterFilter) {
        guard filteredCharacters.value.filter != type else { return }
        let filteredData = self.homeUseCases.filterCharacters(
            with: type,
            characters: self.characters?.results ?? []
        )
        
        let finalResult = FilteredCharacters(characters: filteredData, filter: type)
        self.filteredCharacters.value = finalResult
    }
}
