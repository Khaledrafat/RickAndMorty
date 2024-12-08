//
//  HomeViewModelUnitTests.swift
//  RickAndMortyTests
//
//  Created by Khaled on 08/12/2024.
//

import XCTest
@testable import RickAndMorty

final class HomeViewModelUnitTests: XCTestCase {
    
    let characters = [
        Character.mockStatus(id: 1, name: "Rick Shanchez", status: .alive),
        Character.mockStatus(id: 2, name: "Prime Rick", status: .dead),
        Character.mockStatus(id: 3, name: "Evil Morty", status: .unknown)
    ]
    
    
    class MockedHomeUseCases: HomeUseCases {
        
        var isSuccess = true
        var characters: Characters = Characters(info: nil)
        var error: NetworkError = .unexpectedError
        
        func fetchCharacters(page: Int, completion: @escaping (Result<RickAndMorty.Characters, Error>) -> Void) {
            if isSuccess {
                completion(.success(characters))
            } else {
                completion(.failure(error))
            }
        }
        
        func filterCharacters(with filter: RickAndMorty.CharacterFilter, characters: [RickAndMorty.Character]) -> [RickAndMorty.Character] {
            return self.characters.results ?? []
        }
    }
    
    //MARK: - Test IsLoading
    func test_isLoadingState() {
        let mockUseCase = MockedHomeUseCases()
        let viewModel = DefaultHomeViewModel(homeUseCases: mockUseCase)
        
        let expectation = XCTestExpectation(description: "Loading state updated correctly")
        
        viewModel.isLoading.observe(on: self) { loading in
            if loading {
                expectation.fulfill()
            }
        }
        
        viewModel.viewDidLoad()
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.isLoading.value, false)
    }
    
    //MARK: - Test Fetching Data Successfully
    func test_DataFetchedSuccessfully() {
        let mockUseCase = MockedHomeUseCases()
        let viewModel = DefaultHomeViewModel(homeUseCases: mockUseCase)
        
        let charactersData = Characters(info: nil, results: characters)
        mockUseCase.characters = charactersData
        
        let expectation = XCTestExpectation(description: "Loading state updated correctly")
        
        viewModel.filteredCharacters.observe(on: self) { result in
            if result.characters ?? [] == self.characters {
                expectation.fulfill()
            }
        }
        
        viewModel.viewDidLoad()
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.isLoading.value, false)
    }
    
    //MARK: - Test Fetching Data Failed
    func test_DataFetchedFailed() {
        let mockUseCase = MockedHomeUseCases()
        let viewModel = DefaultHomeViewModel(homeUseCases: mockUseCase)
        
        mockUseCase.isSuccess = false
        mockUseCase.error = NetworkError.urlGeneration
        
        let expectation = XCTestExpectation(description: "Loading state updated correctly")
        
        viewModel.showError.observe(on: self) { message in
            if message == mockUseCase.error.localizedDescription {
                expectation.fulfill()
            }
        }
        
        viewModel.viewDidLoad()
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.isLoading.value, false)
    }
    
}
