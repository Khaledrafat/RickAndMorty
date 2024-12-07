//
//  CharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by Khaled on 06/12/2024.
//

import Foundation

protocol CharacterDetailsViewModelInput {
    func viewDidLoad()
}

protocol CharacterDetailsViewModelOutput {
    var isLoading: Observable<Bool> { get }
    var showError: Observable<String> { get }
    var character: Observable<Character?> { get }
}

protocol CharacterDetailsViewModel: CharacterDetailsViewModelInput, CharacterDetailsViewModelOutput { }

//MARK: - DefaultCharacterDetailsViewModel
final class DefaultCharacterDetailsViewModel {
    
    private let id: Int
    private let characterDetailsUseCase: CharacterDetailsUseCase
    
    var isLoading: Observable<Bool> = Observable(false)
    var showError: Observable<String> = Observable("")
    var character: Observable<Character?> = Observable(nil)
    
    init(id: Int, useCase: CharacterDetailsUseCase) {
        self.id = id
        self.characterDetailsUseCase = useCase
    }
    
}

//MARK: - Implementation
extension DefaultCharacterDetailsViewModel: CharacterDetailsViewModel {
    func viewDidLoad() {
        self.isLoading.value = true
        characterDetailsUseCase.fetchCharacterDetails(
            id: self.id) { [weak self] result in
                guard let self = self else { return }
                self.isLoading.value = false
                switch result {
                case.success(let details):
                    self.character.value = details
                    print(details)
                case .failure(let error):
                    self.showError.value = error.localizedDescription
                }
            }
    }
}
