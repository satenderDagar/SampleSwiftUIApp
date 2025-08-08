import Foundation
import Model
import Common

public protocol UserServiceProtocol {
    func fetchUsers() async throws -> [User]
}

public final class UserService: UserServiceProtocol {
    private let network: NetworkServiceProtocol
    private let endpoint = URL(string: Endpoint.users.path)

    public init(network: NetworkServiceProtocol = NetworkService()) {
        self.network = network
    }

    public func fetchUsers() async throws -> [User] {
        guard let endpoint else {
            throw NetworkError.invalidUrl
        }
        let data = try await network.fetchData(from: endpoint)
        return try JSONDecoder().decode([User].self, from: data)
    }
}
