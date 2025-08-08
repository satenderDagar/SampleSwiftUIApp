public struct Constants {
    public static let baseUrlString: String = "https://fake-json-api.mock.beeceptor.com"
}

public enum Endpoint: String {
    case users = "users"
    
    public var path: String {
        var path:String
        switch self {
        case .users:
            path = "/users"
        }
        return Constants.baseUrlString + path
    }
}
