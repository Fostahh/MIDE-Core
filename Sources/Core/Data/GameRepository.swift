//
//  GameRepository.swift
//  Submission Fundamental iOS
//
//  Created by Mohammad Azri on 01/08/23.
//

import Combine

public protocol GameRepositoryProtocol {
    func getGames() -> AnyPublisher<[VideoGame], Error>
    func getGamesByName(query: String) -> AnyPublisher<[VideoGame], Error>
    func getGameDetails(id: Int) -> AnyPublisher<DetailVideoGame, Error>
    func addGame(from detailVideoGame: DetailVideoGame) -> AnyPublisher<Bool, Error>
    func deleteVideoGame(id: Int) -> AnyPublisher<Bool, Error>
    func getFavoriteGames() -> AnyPublisher<[VideoGame], Error>
}

public final class GameRepository: GameRepositoryProtocol {
    
    public init(remote: RemoteDataSourceProtocol, local: LocalDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }
    
    private let remote: RemoteDataSourceProtocol
    private let local: LocalDataSourceProtocol
    
    public func getGames() -> AnyPublisher<[VideoGame], Error> {
        return self.remote.getGames()
            .map { ObjectMapper.mapListVideoGameResponseToListVideoGameDomain(videoGames: $0) }
            .eraseToAnyPublisher()
    }
    
    public func getGamesByName(query: String) -> AnyPublisher<[VideoGame], Error> {
        return self.remote.getGamesByName(query: query)
            .map { ObjectMapper.mapListVideoGameResponseToListVideoGameDomain(videoGames: $0) }
            .eraseToAnyPublisher()
    }
    
    public func getGameDetails(id: Int) -> AnyPublisher<DetailVideoGame, Error> {
        return self.local.getVideoGame(by: id)
            .flatMap { result -> AnyPublisher<DetailVideoGame, Error> in
                if let result = result {
                    return self.local.getVideoGame(by: id)
                        .map { _ in
                            return ObjectMapper.mapDetailVideoGameEntityToDetailVideoGameDomain(entity: result)
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.remote.getGameDetails(id: id)
                        .map { ObjectMapper.mapDetailVideoGameResponseToDetailVideoGameDomain(response: $0) }
                        .eraseToAnyPublisher()
                }
            }
            .catch { _ in
                return self.remote.getGameDetails(id: id)
                    .map { ObjectMapper.mapDetailVideoGameResponseToDetailVideoGameDomain(response: $0) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func addGame(from detailVideoGame: DetailVideoGame) -> AnyPublisher<Bool, Error> {
        return self.local.addVideoGame(
            from: ObjectMapper.mapDetailVideoGameDomainToDetailVideoGameEntity(domain: detailVideoGame)
        )
        .eraseToAnyPublisher()
    }
    
    public func deleteVideoGame(id: Int) -> AnyPublisher<Bool, Error> {
        return self.local.deleteVideoGame(by: id)
    }
    
    public func getFavoriteGames() -> AnyPublisher<[VideoGame], Error> {
        return self.local.getVideoGames()
            .map { ObjectMapper.mapListVideoGameEntityToListVideoGameDomain(videoGames: $0) }
            .eraseToAnyPublisher()
    }
}
