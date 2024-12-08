//
//  CharacterDetailsRepoImpUnitTests.swift
//  RickAndMortyTests
//
//  Created by Khaled on 08/12/2024.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailsRepoImpUnitTests: XCTestCase {
    
    //MARK: - Fetch Successfully
    func test_fetchCharacterDetailsSuccessfully() {
        let mockNetwork = MockNetworkService()
        mockNetwork.isSuccess = true
        let data = Character.mock(id: 1, name: "Rick Sanchez")
        let expectedData = try! JSONEncoder().encode(data)
        
        let expectation = self.expectation(description: "Success completion handler is called")
        
        mockNetwork.data = expectedData
        let repo = DefaultCharacterDetailsRepoImp(network: mockNetwork)
        
        repo.fetchDetails(id: 1) { result in
            switch result {
            case .success(let character):
                XCTAssertEqual(character.id, 1)
                XCTAssertEqual(character.name, "Rick Sanchez")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    //MARK: - Fetch Failed
    func test_fetchCharacterDetailsFailed() {
        let mockNetwork = MockNetworkService()
        mockNetwork.isSuccess = false
        mockNetwork.data = nil
        mockNetwork.error = .unexpectedError
        let repo = DefaultCharacterDetailsRepoImp(network: mockNetwork)
        let expectation = self.expectation(description: "Failure completion handler is called")
        
        repo.fetchDetails(id: 1) { result in
            switch result {
            case .success(_):
                XCTFail("Expected success but got failure")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.unexpectedError.localizedDescription)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
