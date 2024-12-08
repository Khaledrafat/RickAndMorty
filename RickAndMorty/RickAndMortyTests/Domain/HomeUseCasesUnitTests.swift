//
//  HomeUseCasesUnitTests.swift
//  RickAndMortyTests
//
//  Created by Khaled on 08/12/2024.
//

import XCTest
@testable import RickAndMorty

final class HomeUseCasesUnitTests: XCTestCase {
    
    let characters = [
        Character.mockStatus(id: 1, name: "Rick Shanchez", status: .alive),
        Character.mockStatus(id: 2, name: "Prime Rick", status: .dead),
        Character.mockStatus(id: 3, name: "Evil Morty", status: .unknown)
    ]
    
    class MockHomeRepo: HomeRepo {
        
        func fetchCharacters(page: Int, completion: @escaping (Result<RickAndMorty.Characters, Error>) -> Void) { }
        
    }
    
    //MARK: - Test Alive Filter
    func test_FilteredAliveDataSuccessfully() {
        let homerepo = MockHomeRepo()
        let homeUseCases = DefaultHomeUseCases(homeRepo: homerepo)
        let alive = homeUseCases.filterCharacters(with: .alive, characters: characters)
        
        XCTAssertEqual(alive.count, 1)
        XCTAssertEqual(alive[0].name, "Rick Shanchez")
        XCTAssertEqual(alive[0].id, 1)
    }
    
    //MARK: - Test Dead Filter
    func test_FilteredDeadDataSuccessfully() {
        let homerepo = MockHomeRepo()
        let homeUseCases = DefaultHomeUseCases(homeRepo: homerepo)
        let dead = homeUseCases.filterCharacters(with: .dead, characters: characters)
        
        XCTAssertEqual(dead.count, 1)
        XCTAssertEqual(dead[0].name, "Prime Rick")
        XCTAssertEqual(dead[0].id, 2)
    }
    
    //MARK: - Test Unknown Filter
    func test_FilteredUnknownDataSuccessfully() {
        let homerepo = MockHomeRepo()
        let homeUseCases = DefaultHomeUseCases(homeRepo: homerepo)
        let unknown = homeUseCases.filterCharacters(with: .unknown, characters: characters)
        
        XCTAssertEqual(unknown.count, 1)
        XCTAssertEqual(unknown[0].name, "Evil Morty")
        XCTAssertEqual(unknown[0].id, 3)
    }
    
    //MARK: - Test All Filter
    func test_FilteredAllDataSuccessfully() {
        let homerepo = MockHomeRepo()
        let homeUseCases = DefaultHomeUseCases(homeRepo: homerepo)
        let unknown = homeUseCases.filterCharacters(with: .all, characters: characters)
        
        XCTAssertEqual(unknown.count, 3)
    }
    
}
