import XCTest
import Combine
import Foundation
@testable import Core

final class GameRepositoryTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var mockRemoteDataSource: RemoteDataSourceProtocol!
    private var mockLocalDataSource: LocalDataSourceProtocol!
    private var mockRepository: GameRepositoryProtocol!
    
    override func tearDown() {
        mockRemoteDataSource = nil
        mockLocalDataSource = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: getGames()
    func testGetGamesSuccess() throws {
        setupMocks(remoteScenario: .success, localScenario: .success)
        
        let remoteMockData = DataDummyProvider.videoGamesResponse
        let domainMockData = DataDummyProvider.videoGamesDomain
        
        executePublisherTest(
            publisher: mockRemoteDataSource.getGames()
        ) { videoGamesResponse, error in
            XCTAssertNil(error)
            XCTAssertNotNil(videoGamesResponse)
            XCTAssertEqual(videoGamesResponse!.count, remoteMockData.count)
            XCTAssertEqual(videoGamesResponse!, remoteMockData)
        }
        
        executePublisherTest(
            publisher: mockRepository.getGames()
        ) { videoGamesDomain, error in
            XCTAssertNil(error)
            XCTAssertNotNil(videoGamesDomain)
            XCTAssertEqual(videoGamesDomain!.count, domainMockData.count)
            XCTAssertEqual(videoGamesDomain!, domainMockData)
        }
    }
    
    func testGetGamesFailure() throws {
        setupMocks(remoteScenario: .failure, localScenario: .failure)
        
        let remoteMockData = DataDummyProvider.videoGamesResponse
        let domainMockData = DataDummyProvider.videoGamesDomain
        
        executePublisherTest(
            publisher: mockRemoteDataSource.getGames()
        ) { videoGamesResponse, error in
            XCTAssertNotNil(error)
            XCTAssertNil(videoGamesResponse)
            XCTAssertNotEqual(videoGamesResponse, remoteMockData)
        }
        
        executePublisherTest(
            publisher: mockRepository.getGames()
        ) { videoGamesDomain, error in
            XCTAssertNotNil(error)
            XCTAssertNil(videoGamesDomain)
            XCTAssertNotEqual(videoGamesDomain, domainMockData)
        }
    }
    
    // MARK: getGamesByName(query: String)
    func testGetGamesByNameSuccess() throws {
        setupMocks(remoteScenario: .success, localScenario: .success)
        
        let remoteMockData = DataDummyProvider.videoGamesResponse
        let domainMockData = DataDummyProvider.videoGamesDomain
        
        executePublisherTest(
            publisher: mockRemoteDataSource.getGamesByName(query: "")
        ) { videoGamesResponse, error in
            XCTAssertNil(error)
            XCTAssertNotNil(videoGamesResponse)
            XCTAssertEqual(videoGamesResponse!.count, remoteMockData.count)
            XCTAssertEqual(videoGamesResponse!, remoteMockData)
        }
        
        executePublisherTest(
            publisher: mockRepository.getGamesByName(query: "")
        ) { videoGamesDomain, error in
            XCTAssertNil(error)
            XCTAssertNotNil(videoGamesDomain)
            XCTAssertEqual(videoGamesDomain!.count, domainMockData.count)
            XCTAssertEqual(videoGamesDomain!, domainMockData)
        }
    }
    
    func testGetGamesByNameFailure() throws {
        setupMocks(remoteScenario: .failure, localScenario: .failure)
        
        let remoteMockData = DataDummyProvider.videoGamesResponse
        let domainMockData = DataDummyProvider.videoGamesDomain
        
        executePublisherTest(
            publisher: mockRemoteDataSource.getGamesByName(query: "")
        ) { videoGamesResponse, error in
            XCTAssertNotNil(error)
            XCTAssertNil(videoGamesResponse)
            XCTAssertNotEqual(videoGamesResponse, remoteMockData)
        }
        
        executePublisherTest(
            publisher: mockRepository.getGamesByName(query: "")
        ) { videoGamesDomain, error in
            XCTAssertNotNil(error)
            XCTAssertNil(videoGamesDomain)
            XCTAssertNotEqual(videoGamesDomain, domainMockData)
        }
    }
    
    // MARK: - getGameDetails(id: Int)
    func testGetGameDetailFromLocalSuccess() throws {
        setupMocks(remoteScenario: .success, localScenario: .success)
        
        let localMockData = DataDummyProvider.createDetailVideoGameEntity()
        let domainMockData = DataDummyProvider.createDetailVideoGameDomain(isFavorite: true)
        
        _ = mockLocalDataSource.addVideoGame(from: localMockData)
        
        executePublisherTest(
            publisher: mockLocalDataSource.getVideoGame(by: localMockData.id)
        ) { detailVideoGameEntity, error in
            XCTAssertNil(error)
            let unwrappedDetailVideoGameEntity = detailVideoGameEntity ?? nil
            XCTAssertNotNil(unwrappedDetailVideoGameEntity)
            XCTAssertEqual(unwrappedDetailVideoGameEntity, localMockData)
        }
        
        executePublisherTest(
            publisher: mockRepository.getGameDetails(id: localMockData.id)
        ) { detailVideoGameDomain, error in
            XCTAssertNil(error)
            XCTAssertNotNil(detailVideoGameDomain)
            XCTAssertEqual(detailVideoGameDomain, domainMockData)
        }
    }
    
    func testGetGameDetailFromLocalSuccessButNilThenFromRemoteSuccess() throws {
        setupMocks(remoteScenario: .success, localScenario: .success)
        
        let localMockData = DataDummyProvider.createDetailVideoGameEntity()
        let remoteMockData = DataDummyProvider.detailVideoGameResponse
        let domainMockData = DataDummyProvider.createDetailVideoGameDomain(isFavorite: false)
        
        executePublisherTest(
            publisher: mockLocalDataSource.getVideoGame(by: localMockData.id)
        ) { detailVideoGameEntity, error in
            XCTAssertNil(error)
            let unwrappedDetailVideoGameEntity = detailVideoGameEntity ?? nil
            XCTAssertNil(unwrappedDetailVideoGameEntity)
            XCTAssertNotEqual(unwrappedDetailVideoGameEntity, localMockData)
        }
        
        executePublisherTest(
            publisher: mockRemoteDataSource.getGameDetails(id: localMockData.id)
        ) { detailVideoGameResponse, error in
            XCTAssertNil(error)
            XCTAssertNotNil(detailVideoGameResponse)
            XCTAssertEqual(detailVideoGameResponse, remoteMockData)
        }
        
        executePublisherTest(
            publisher: mockRepository.getGameDetails(id: localMockData.id)
        ) { detailVideoGameDomain, error in
            XCTAssertNil(error)
            XCTAssertEqual(detailVideoGameDomain, domainMockData)
        }
    }
    
    func testGetGameDetailFromLocalFailedThenFromRemoteSuccess() throws {
        setupMocks(remoteScenario: .success, localScenario: .failure)
        
        let localMockData = DataDummyProvider.createDetailVideoGameEntity()
        let remoteMockData = DataDummyProvider.detailVideoGameResponse
        let domainMockData = DataDummyProvider.createDetailVideoGameDomain(isFavorite: false)
        
        executePublisherTest(
            publisher: mockLocalDataSource.getVideoGame(by: localMockData.id)
        ) { detailVideoGameEntity, error in
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? DatabaseError, DatabaseError.invalidInstance)
            let unwrappedDetailVideoGameEntity = detailVideoGameEntity ?? nil
            XCTAssertNil(unwrappedDetailVideoGameEntity)
            XCTAssertNotEqual(unwrappedDetailVideoGameEntity, localMockData)
        }
        
        executePublisherTest(
            publisher: mockRemoteDataSource.getGameDetails(id: localMockData.id)
        ) { detailVideoGameResponse, error in
            XCTAssertNil(error)
            XCTAssertNotNil(detailVideoGameResponse)
            XCTAssertEqual(detailVideoGameResponse, remoteMockData)
        }
        
        executePublisherTest(
            publisher: mockRepository.getGameDetails(id: localMockData.id)
        ) { detailVideoGameDomain, error in
            XCTAssertNil(error)
            XCTAssertEqual(detailVideoGameDomain, domainMockData)
        }
    }
    
    func testGetGameDetailFromLocalFailedThenFromRemoteFailed() throws {
        setupMocks(remoteScenario: .failure, localScenario: .failure)
        
        let localMockData = DataDummyProvider.createDetailVideoGameEntity()
        let remoteMockData = DataDummyProvider.detailVideoGameResponse
        let domainMockData = DataDummyProvider.createDetailVideoGameDomain(isFavorite: false)
        
        executePublisherTest(
            publisher: mockLocalDataSource.getVideoGame(by: 0)
        ) { detailVideoGameEntity, error in
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? DatabaseError, DatabaseError.invalidInstance)
            let unwrappedDetailVideoGameEntity = detailVideoGameEntity ?? nil
            XCTAssertNil(unwrappedDetailVideoGameEntity)
            XCTAssertNotEqual(unwrappedDetailVideoGameEntity, localMockData)
        }
        
        executePublisherTest(
            publisher: mockRemoteDataSource.getGameDetails(id: 0)
        ) { detailVideoGameResponse, error in
            XCTAssertNil(detailVideoGameResponse)
            XCTAssertNotEqual(detailVideoGameResponse, remoteMockData)
            XCTAssertNotNil(error)
        }
        
        executePublisherTest(
            publisher: mockRepository.getGameDetails(id: 0)
        ) { detailVideoGameDomain, error in
            XCTAssertNil(detailVideoGameDomain)
            XCTAssertNotEqual(detailVideoGameDomain, domainMockData)
            XCTAssertNotNil(error)
        }
    }
    
    // MARK: - addGame(from detailVideoGame: DetailVideoGame)
    func testAddGameSuccess() throws {
        setupMocks(remoteScenario: .success, localScenario: .success)
        
        let domainMockData = DataDummyProvider.createDetailVideoGameDomain(isFavorite: true)
        let localMockData = DataDummyProvider.createDetailVideoGameEntity()
    }
    
    func testAddGameFailed() throws {
        setupMocks(remoteScenario: .failure, localScenario: .failure)
    }
    
    // MARK: - Private Methods
    private func setupMocks(remoteScenario: TestScenario, localScenario: TestScenario) {
        mockRemoteDataSource = MockRemoteDataSource(scenario: remoteScenario)
        mockLocalDataSource = MockLocalDataSource(scenario: localScenario)
        mockRepository = GameRepository(remote: mockRemoteDataSource, local: mockLocalDataSource)
    }
    
    private func executePublisherTest<T: Equatable>(
        publisher: AnyPublisher<T, Error>,
        file: StaticString = #file,
        line: UInt = #line,
        timeout: TimeInterval = 5.0,
        completion: @escaping (T?, Error?) -> Void
    ) {
        let expectation = XCTestExpectation(description: "Publisher Completed")
        var receivedError: Error?
        var receivedValue: T?
        
        publisher
            .sink(receiveCompletion: { completionResult in
                if case .failure(let error)  = completionResult {
                    receivedError = error
                }
                expectation.fulfill()
            }, receiveValue: { value in
                receivedValue = value
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeout)
        completion(receivedValue ?? nil, receivedError)
    }
    
}
