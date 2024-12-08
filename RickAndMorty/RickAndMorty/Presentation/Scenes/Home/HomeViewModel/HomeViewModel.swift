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
    func filter(fromHome: Bool, with type: CharacterFilter)
    func didSelectRow(at index: Int)
    func paginate()
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
    private var isPaginating: Bool = false
    private var page: Int = 1
    
    init(homeUseCases: HomeUseCases) {
        self.homeUseCases = homeUseCases
    }
}

extension DefaultHomeViewModel: HomeViewModel {
    //MARK: - ViewDidLoad
    func viewDidLoad() {
        self.isLoading.value = true
        homeUseCases.fetchCharacters(page: page) { [weak self] result in
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
    
    //MARK: - Paginate
    func paginate() {
        let pages = self.characters?.info?.pages ?? 1
        guard !isPaginating , pages > page else { return }
        self.isPaginating = true
        self.isLoading.value = true
        let newPage = page + 1
        homeUseCases.fetchCharacters(page: newPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            switch result {
            case .failure(let error):
                self.showError.value = error.localizedDescription
                self.isPaginating = false
                
            case .success(let value):
                self.page = newPage
                value.results?.forEach({ self.characters?.results?.append($0) })
                self.filter(fromHome: false, with: self.filteredCharacters.value.filter)
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
    func filter(fromHome: Bool, with type: CharacterFilter) {
        isPaginating = fromHome ? true : isPaginating
        let filteredData = self.homeUseCases.filterCharacters(
            with: type,
            characters: self.characters?.results ?? []
        )
        
        let finalResult = FilteredCharacters(characters: filteredData, filter: type)
        self.filteredCharacters.value = finalResult
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
            self.isPaginating = false
        }
    }
}
