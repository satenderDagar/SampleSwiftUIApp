import Foundation
import Model
import Networking

@MainActor
public final class UserListViewModel: ObservableObject {
    @Published public private(set) var users: [User] = []
    @Published public private(set) var isLoading = false
    @Published public private(set) var errorMessage: String?

    private let userService: UserServiceProtocol

    public init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }

    public func fetchUsers() async {
        isLoading = true
        defer { isLoading = false }
        
        let service = userService
        do {
            let users = try await service.fetchUsers()
        } catch {
            errorMessage = error.localizedDescription
            
        }
        self.users = users        
    }
}
