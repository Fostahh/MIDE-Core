//
//  FavoriteInteractor.swift
//  Submission Fundamental iOS
//
//  Created by Mohammad Azri on 16/08/23.
//

import Combine

public protocol FavoriteUseCase {
    func getGames() -> AnyPublisher<[VideoGame], Error>
}

public class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: GameRepositoryProtocol
    
    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getGames() -> AnyPublisher<[VideoGame], Error> {
        repository.getFavoriteGames()
    }
    
}
