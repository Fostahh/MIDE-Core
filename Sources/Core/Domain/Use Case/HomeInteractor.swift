//
//  HomeInteractor.swift
//  Submission Fundamental iOS
//
//  Created by Mohammad Azri on 01/08/23.
//

import Combine

public protocol HomeUseCase {
    func getGames() -> AnyPublisher<[VideoGame], Error>
    func getGamesByName(query: String) -> AnyPublisher<[VideoGame], Error>
    
}

public class HomeInteractor: HomeUseCase {
    
    private let repository: GameRepositoryProtocol
    
    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getGames() -> AnyPublisher<[VideoGame], Error> {
        repository.getGames()
    }
    
    public func getGamesByName(query: String) -> AnyPublisher<[VideoGame], Error> {
        repository.getGamesByName(query: query)
    }
    
}
