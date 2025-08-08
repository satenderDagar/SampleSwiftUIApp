import XCTest
@testable import User
@testable import Networking
@testable import Model

@MainActor
final class UserListViewModelTests: XCTestCase {
    
    func testFetchUsers_Success() async {
        let mockService = MockUserService()
        let sampleUser = Model.User(id: 1, name: "John", company: "Apple", username: "johnDoe", email: "johndoe@example.com", address: "Main Street", zip: "10001", state: "state", country: "US", phone: "1-899-997-3985", photo: "photourl")

        let sampleUsers: [Model.User] = [sampleUser]
        mockService.usersToReturn = sampleUsers
        
        let viewModel = UserListViewModel(userService: mockService)

        await viewModel.fetchUsers()
        
        XCTAssertEqual(viewModel.users, sampleUsers)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchUsers_Failure() async {
        let mockService = MockUserService()
        mockService.shouldReturnError = true
        
        let viewModel = UserListViewModel(userService: mockService)

        await viewModel.fetchUsers()

        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "Mock error")
    }
}

final class MockUserService: UserServiceProtocol {
    
    var shouldReturnError = false
    var usersToReturn: [Model.User] = []
    var errorToThrow: Error = NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])

    func fetchUsers() async throws -> [Model.User] {
        if shouldReturnError {
            throw errorToThrow
        }
        return usersToReturn
    }
}
