//
//  DetailInteractor.swift
//  Submission Fundamental iOS
//
//  Created by Mohammad Azri on 01/08/23.
//

import Combine

public protocol DetailUseCase {
    func getGameDetails(id: Int) -> AnyPublisher<DetailVideoGame, Error>
    func addGame(detailVideoGame: DetailVideoGame) -> AnyPublisher<Bool, Error>
    func deleteVideoGame(id: Int) -> AnyPublisher<Bool, Error>
}

public class DetailInteractor: DetailUseCase {
    
    private let repository: GameRepositoryProtocol
    
    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getGameDetails(id: Int) -> AnyPublisher<DetailVideoGame, Error> {
        repository.getGameDetails(id: id)
    }
    
    public func addGame(detailVideoGame: DetailVideoGame) -> AnyPublisher<Bool, Error> {
        repository.addGame(from: detailVideoGame)
    }
    
    public func deleteVideoGame(id: Int) -> AnyPublisher<Bool, Error> {
        repository.deleteVideoGame(id: id)
    }
}
