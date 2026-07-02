The Core layer for the Menjadi iOS Developer Expert capstone ([DicodingiOS](https://github.com/Fostahh/DicodingiOS), branch [`MIDE-second-submission-SPM`](https://github.com/Fostahh/DicodingiOS/tree/MIDE-second-submission-SPM)), extracted as a standalone remote Swift package. It carries the app's entire Clean Architecture core — Alamofire networking against the [RAWG Video Games Database API](https://rawg.io/apidocs), Realm persistence for favorites, domain models, and use-case interactors — exposed through Combine publishers and consumed by the app's feature modules (Home, DetailGame, Favorite).

## Tech Stack

| Layer | Technology |
| --- | --- |
| Language | Swift (tools 5.10) |
| Networking | [Alamofire](https://github.com/Alamofire/Alamofire) |
| Local storage | [Realm](https://github.com/realm/realm-swift) |
| Concurrency | Combine (`AnyPublisher` across all layers) |
| Decoding | `Codable` response DTOs |
| Tests | XCTest — mocked data sources + bundled JSON fixtures |
| Distribution | Swift Package Manager |

## Installation

Add the package in Xcode (**File → Add Package Dependencies…**) or in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Fostahh/MIDE-Core.git", exact: "1.0.0")
]
```

## Usage

`Injection` is the entry point — it wires the repository with its remote (Alamofire) and local (Realm) data sources, and returns a screen-scoped use case:

```swift
import Core

let injection = Injection()
let homeUseCase = injection.provideHome()

homeUseCase.getGames()
    .receive(on: DispatchQueue.main)
    .sink(receiveCompletion: { completion in
        if case .failure(let error) = completion {
            // show error
        }
    }, receiveValue: { games in
        // render [VideoGame]
    })
    .store(in: &cancellables)
```

- `provideHome()` → `HomeUseCase` — game list and search
- `provideDetail()` → `DetailUseCase` — game detail, add/remove favorite
- `provideFavorite()` → `FavoriteUseCase` — saved games

## API

The use cases sit on top of a single repository:

```swift
public protocol GameRepositoryProtocol {
    func getGames() -> AnyPublisher<[VideoGame], Error>
    func getGamesByName(query: String) -> AnyPublisher<[VideoGame], Error>
    func getGameDetails(id: Int) -> AnyPublisher<DetailVideoGame, Error>
    func addGame(from detailVideoGame: DetailVideoGame) -> AnyPublisher<Bool, Error>
    func deleteVideoGame(id: Int) -> AnyPublisher<Bool, Error>
    func getFavoriteGames() -> AnyPublisher<[VideoGame], Error>
}
```

`getGameDetails` is offline-aware: a favorited game is served from Realm, everything else falls back to the RAWG API.

Domain models (`VideoGame`, `DetailVideoGame` with its `ESRBRating`, `Genre`, and `Developer`) are plain public structs, decoupled from the RAWG response format, with presentation helpers such as `ageRestriction`.

## Architecture

```
Use Case (Interactor) ──▶ GameRepository ──▶ RemoteDataSource ──▶ RAWG API
                               │                (Alamofire)
                               ├────────────▶ LocalDataSource ──▶ Realm
                               ▼
                         ObjectMapper (response / entity → domain model)
```

```
Sources/Core/
├── DI/                      # Injection — public entry point
├── Data/
│   ├── GameRepository.swift
│   ├── Remote Data Source/  # Alamofire networking, Codable response DTOs
│   └── Local Data Source/   # Realm entities + CRUD
├── Domain/
│   ├── Model/               # VideoGame, DetailVideoGame
│   └── Use Case/            # Home / Detail / Favorite interactors
└── Util/                    # ObjectMapper, endpoints, bundled mock JSON
Tests/
└── CoreTests/               # GameRepositoryTests + mocked data sources
```

## Testing

Repository behavior is covered by unit tests against mocked remote and local data sources: each mock is driven by a `TestScenario` (`.success` / `.failure`), with JSON fixtures bundled as package resources standing in for RAWG responses.

## Requirements

- iOS 15.0+
- Swift 5.10 toolchain

## Acknowledgements

- Video game data provided by [RAWG](https://rawg.io/). This product uses the RAWG API but is not endorsed or certified by RAWG.
