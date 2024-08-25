//
//  DetailVideoGame.swift
//  Submission Fundamental iOS
//
//  Created by Mohammad Azri on 23/03/23.
//

import Foundation

public struct DetailVideoGame: Encodable {
    public let id: Int
    public let name, description, backgroundImage, released, backgroundImageAdditional: String
    public let rating: Double
    public let esrbRating: ESRBRating
    public let genres: [Genre]
    public let developers: [Developer]
    public var isFavorite: Bool = false
    
    public var ageRestriction: String {
        switch esrbRating.id {
        case 2: return "10+"
        case 3: return "13+"
        case 4: return "18+"
        case 5: return "18+"
        default: return esrbRating.name
        }
    }
    
    public var genresInString: String {
        var genreInString = ""
        
        for (index, genre) in genres.enumerated() {
            if index == genres.count - 1 {
                genreInString += genre.name
            } else {
                genreInString += genre.name + ", "
            }
            
        }
        
        return genreInString
    }
    
    public var developersInString: String {
        var developerInString = ""
        
        for (index, developer) in developers.enumerated() {
            if index == developers.count - 1 {
                developerInString += developer.name
            } else {
                developerInString += developer.name + ", "
            }
            
        }
        
        return developerInString
    }
}

public struct ESRBRating: Encodable {
    let id: Int
    let name: String
}

public struct Genre: Encodable {
    let id: Int
    let name: String
}

public struct Developer: Encodable {
    let id: Int
    let name: String
}
