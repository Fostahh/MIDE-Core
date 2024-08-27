//
//  VideoGameResponse.swift
//  Submission Fundamental iOS
//
//  Created by Mohammad Azri on 08/01/23.
//

import Foundation

public struct ListVideoGameResponse: Codable {
    let results: [VideoGameResponse]
}

public struct VideoGameResponse: Codable, Equatable {
    let id: Int
    let name: String
    let backgroundImage, released: String?
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating
    }
}

