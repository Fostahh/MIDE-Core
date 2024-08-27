//
//  DataDummyProvider.swift
//
//
//  Created by Mohammaad Azri Khairuddin on 27/08/24.
//

@testable import Core

public final class DataDummyProvider {
    
    static var videoGamesResponse = [
        VideoGameResponse(
            id: 3498,
            name: "Grand Theft Auto V",
            backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
            released: "2013-09-17",
            rating: 4.48
        )
    ]
    
    static var videoGamesDomain = [
        VideoGame(
            id: 3498,
            name: "Grand Theft Auto V",
            released: "2013-09-17",
            backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
            rating: 4.48
        )
    ]
    
    static var detailVideoGameResponse = DetailVideoGameResponse(
        id: 3498,
        name: "Grand Theft Auto V",
        description: "Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update. \nSimultaneous storytelling from three unique perspectives: \nFollow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from. \nGTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged.\n\nEspañol\nRockstar Games se hizo más grande desde su entrega anterior de la serie. Obtienes la construcción del mundo complicada y realista de Liberty City de GTA4 en el escenario de Los Santos, un viejo favorito de los fans, GTA San Andreas. 561 vehículos diferentes (incluidos todos los transportes que puede operar) y la cantidad aumenta con cada actualización.\nNarración simultánea desde tres perspectivas únicas:\nSigue a Michael, ex-criminal que vive su vida de ocio lejos del pasado, Franklin, un niño que busca un futuro mejor, y Trevor, el pasado exacto del que Michael está tratando de huir.\nGTA Online proporcionará muchos desafíos adicionales incluso para los jugadores experimentados, recién llegados del modo historia. Ahora tendrás otros jugadores cerca que pueden ayudarte con la misma probabilidad que arruinar tu misión. Los jugadores pueden experimentar todas las mecánicas de GTA actualizadas a través del personaje personalizable único, y el contenido de la comunidad combinado con el sistema de nivelación tiende a mantener a todos ocupados y comprometidos.",
        backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
        released: "2013-09-17",
        backgroundImageAdditional: "https://media.rawg.io/media/screenshots/5f5/5f5a38a222252d996b18962806eed707.jpg",
        rating: 4.47,
        esrbRating: ESRBRatingResponse(id: 4, name: "Mature"),
        genres: [GenreResponse(id: 4, name: "Action")],
        developers: [
            DeveloperResponse(id: 3524, name: "Rockstar North"),
            DeveloperResponse(id: 10, name: "Rockstar Games")
        ]
    )
    
    static func createDetailVideoGameEntity() -> VideoGameEntity {
        let videoGameEntity = VideoGameEntity()
        
        videoGameEntity.id = 3498
        videoGameEntity.name = "Grand Theft Auto V"
        videoGameEntity.rating = 4.47
        videoGameEntity.released = "2013-09-17"
        videoGameEntity.desc = "Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update. \nSimultaneous storytelling from three unique perspectives: \nFollow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from. \nGTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged.\n\nEspañol\nRockstar Games se hizo más grande desde su entrega anterior de la serie. Obtienes la construcción del mundo complicada y realista de Liberty City de GTA4 en el escenario de Los Santos, un viejo favorito de los fans, GTA San Andreas. 561 vehículos diferentes (incluidos todos los transportes que puede operar) y la cantidad aumenta con cada actualización.\nNarración simultánea desde tres perspectivas únicas:\nSigue a Michael, ex-criminal que vive su vida de ocio lejos del pasado, Franklin, un niño que busca un futuro mejor, y Trevor, el pasado exacto del que Michael está tratando de huir.\nGTA Online proporcionará muchos desafíos adicionales incluso para los jugadores experimentados, recién llegados del modo historia. Ahora tendrás otros jugadores cerca que pueden ayudarte con la misma probabilidad que arruinar tu misión. Los jugadores pueden experimentar todas las mecánicas de GTA actualizadas a través del personaje personalizable único, y el contenido de la comunidad combinado con el sistema de nivelación tiende a mantener a todos ocupados y comprometidos."
        videoGameEntity.backgroundImage = "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg"
        videoGameEntity.backgroundImageAdditional = "https://media.rawg.io/media/screenshots/5f5/5f5a38a222252d996b18962806eed707.jpg"
        
        let genresEntity: [GenreEntity] = {
            var genreEntities = [GenreEntity]()
            DataDummyProvider.createDetailVideoGameDomain(isFavorite: false).genres.forEach { domainGenre in
                let genreEntity = GenreEntity()
                genreEntity.id = domainGenre.id
                genreEntity.name = domainGenre.name
                genreEntities.append(genreEntity)
            }
            return genreEntities
        }()
        videoGameEntity.genres.append(objectsIn: genresEntity)
        
        let esrbRatingEntity = ESRBRatingEntity()
        esrbRatingEntity.id = 4
        esrbRatingEntity.name = "Mature"
        videoGameEntity.esrbRating = esrbRatingEntity
        
        let developersEntity: [DeveloperEntity] = {
            var developerEntities = [DeveloperEntity]()
            DataDummyProvider.createDetailVideoGameDomain(isFavorite: false).developers.forEach { domainDeveloper in
                let developerEntity = DeveloperEntity()
                developerEntity.id = domainDeveloper.id
                developerEntity.name = domainDeveloper.name
                developerEntities.append(developerEntity)
            }
            return developerEntities
        }()
        videoGameEntity.developers.append(objectsIn: developersEntity)
        
        return videoGameEntity
    }
    
    static var detailVideoGameEntity = DetailVideoGameResponse(
        id: 3498,
        name: "Grand Theft Auto V",
        description: "Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update. \nSimultaneous storytelling from three unique perspectives: \nFollow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from. \nGTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged.\n\nEspañol\nRockstar Games se hizo más grande desde su entrega anterior de la serie. Obtienes la construcción del mundo complicada y realista de Liberty City de GTA4 en el escenario de Los Santos, un viejo favorito de los fans, GTA San Andreas. 561 vehículos diferentes (incluidos todos los transportes que puede operar) y la cantidad aumenta con cada actualización.\nNarración simultánea desde tres perspectivas únicas:\nSigue a Michael, ex-criminal que vive su vida de ocio lejos del pasado, Franklin, un niño que busca un futuro mejor, y Trevor, el pasado exacto del que Michael está tratando de huir.\nGTA Online proporcionará muchos desafíos adicionales incluso para los jugadores experimentados, recién llegados del modo historia. Ahora tendrás otros jugadores cerca que pueden ayudarte con la misma probabilidad que arruinar tu misión. Los jugadores pueden experimentar todas las mecánicas de GTA actualizadas a través del personaje personalizable único, y el contenido de la comunidad combinado con el sistema de nivelación tiende a mantener a todos ocupados y comprometidos.",
        backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
        released: "2013-09-17",
        backgroundImageAdditional: "https://media.rawg.io/media/screenshots/5f5/5f5a38a222252d996b18962806eed707.jpg",
        rating: 4.47,
        esrbRating: ESRBRatingResponse(id: 4, name: "Mature"),
        genres: [GenreResponse(id: 4, name: "Action")],
        developers: [
            DeveloperResponse(id: 3524, name: "Rockstar North"),
            DeveloperResponse(id: 10, name: "Rockstar Games")
        ]
    )
    
    static func createDetailVideoGameDomain(isFavorite: Bool) -> DetailVideoGame {
        DetailVideoGame(
            id: 3498,
            name: "Grand Theft Auto V",
            description: "Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update. \nSimultaneous storytelling from three unique perspectives: \nFollow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from. \nGTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged.\n\nEspañol\nRockstar Games se hizo más grande desde su entrega anterior de la serie. Obtienes la construcción del mundo complicada y realista de Liberty City de GTA4 en el escenario de Los Santos, un viejo favorito de los fans, GTA San Andreas. 561 vehículos diferentes (incluidos todos los transportes que puede operar) y la cantidad aumenta con cada actualización.\nNarración simultánea desde tres perspectivas únicas:\nSigue a Michael, ex-criminal que vive su vida de ocio lejos del pasado, Franklin, un niño que busca un futuro mejor, y Trevor, el pasado exacto del que Michael está tratando de huir.\nGTA Online proporcionará muchos desafíos adicionales incluso para los jugadores experimentados, recién llegados del modo historia. Ahora tendrás otros jugadores cerca que pueden ayudarte con la misma probabilidad que arruinar tu misión. Los jugadores pueden experimentar todas las mecánicas de GTA actualizadas a través del personaje personalizable único, y el contenido de la comunidad combinado con el sistema de nivelación tiende a mantener a todos ocupados y comprometidos.",
            backgroundImage: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
            released: "2013-09-17",
            backgroundImageAdditional: "https://media.rawg.io/media/screenshots/5f5/5f5a38a222252d996b18962806eed707.jpg",
            rating: 4.47,
            esrbRating: ESRBRating(id: 4, name: "Mature"),
            genres: [Genre(id: 4, name: "Action")],
            developers: [
                Developer(id: 3524, name: "Rockstar North"),
                Developer(id: 10, name: "Rockstar Games")
            ],
            isFavorite: isFavorite
        )
    }
    
}
