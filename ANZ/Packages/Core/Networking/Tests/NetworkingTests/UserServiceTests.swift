import XCTest
@testable import Networking
@testable import Model
@testable import Common

final class UserServiceTests: XCTestCase {
    
    func testFetchUsersAndReturnsUsersOnSuccess() async throws {
        let sampleUser = User(id: 1, name: "John", company: "Apple", username: "johnDoe", email: "johndoe@example.com", address: "Main Street", zip: "10001", state: "state", country: "US", phone: "1-899-997-3985", photo: "photourl")
        let users = [sampleUser]
        
        let data = try! JSONEncoder().encode(users)
        
        let mockNetwork = MockNetworkService()
        mockNetwork.dataToReturn = data
        
        let sut = UserService(network: mockNetwork)
        
        let result = try await sut.fetchUsers()
        
        XCTAssertEqual(result.first, sampleUser)
        XCTAssertEqual(mockNetwork.urlValueReceived, URL(string: Endpoint.users.path)!)
    }
    
    func testFetchUsersThrowsDecodingErrorOnInvalidData() async {
        let invalidJSON = Data("invalid json".utf8)
        
        let mockNetwork = MockNetworkService()
        mockNetwork.dataToReturn = invalidJSON
        
        let sut = UserService(network: mockNetwork)
        
        do {
            _ = try await sut.fetchUsers()
            XCTFail("Method did not throw expected error.")
        } catch let error as DecodingError {
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
}

final class MockNetworkService: NetworkServiceProtocol {
    var dataToReturn: Data?
    var errorToThrow: Error?
    var urlValueReceived: URL?

    func fetchData(from url: URL) async throws -> Data {
        urlValueReceived = url
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn ?? Data()
    }
}
