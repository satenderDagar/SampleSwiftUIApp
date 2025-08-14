import Foundation

public protocol NetworkServiceProtocol: Actor {
    func fetchData(from url: URL) async throws -> Data
}

public final actor NetworkService: NetworkServiceProtocol {
    public static let shared = NetworkService()
    private let sesssion: URLSession
    public init(session: URLSession = .shared) {
        self.sesssion = session
    }
    
    public func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await sesssion.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return data
    }
}
    
enum NetworkError: Error {
    case invalidResponse
    case invalidUrl
}
