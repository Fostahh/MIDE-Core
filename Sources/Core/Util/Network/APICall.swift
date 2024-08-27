//
//  APICall.swift
//  Submission Fundamental iOS
//
//  Created by Mohammad Azri on 01/08/23.
//

import Foundation

// https://api.rawg.io/api/games/3498?key=e2037d96ffc84a45b3d9b74e9e3d5fea

struct API {
    static let baseUrl = "https://api.rawg.io/api/games"
    static var key: String {
        return "e2037d96ffc84a45b3d9b74e9e3d5fea"
    }
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case games
        case detailGame(id: Int)
        case search(query: String)
        
        public var url: String {
            switch self {
            case .games:
                return "\(API.baseUrl)?key=\(API.key)"
            case .detailGame(let id):
                return "\(API.baseUrl)/\(id)?key=\(API.key)"
            case .search(let query):
                return "\(API.baseUrl)?key=\(API.key)&search=\(query)"
            }
        }
    }
    
}
