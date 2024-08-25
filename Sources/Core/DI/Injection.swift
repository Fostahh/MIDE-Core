//
//  Injection.swift
//  Submission Fundamental iOS
//
//  Created by Mohammad Azri on 01/08/23.
//

import RealmSwift

public final class Injection {
    
    public init() { }
    
    private func provideRepository() -> GameRepositoryProtocol {
        let remote: RemoteDataSourceProtocol = RemoteDataSource()
        let realm = try? Realm()
        let local: LocalDataSourceProtocol = LocalDataSource(realm: realm)
        
        return GameRepository(remote: remote, local: local)
    }
    
    public func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    public func provideDetail() -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
    
    public func provideFavorite() -> FavoriteUseCase {
        let repo = provideRepository()
        return FavoriteInteractor(repository: repo)
    }
    
}
