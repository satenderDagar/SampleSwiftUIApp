public struct User: Codable, Identifiable, Hashable, Sendable {
    
    public let id: Int
    public let name: String
    public let company: String
    public let username: String
    public let email: String
    public let address: String
    public let zip: String
    public let state: String
    public let country: String
    public let phone: String
    public let photo: String
    
    public init(id: Int, name: String, company: String, username: String, email: String, address: String, zip: String, state: String, country: String, phone: String, photo: String) {
        self.id = id
        self.name = name
        self.company = company
        self.username = username
        self.email = email
        self.address = address
        self.zip = zip
        self.state = state
        self.country = country
        self.phone = phone
        self.photo = photo
    }
}
