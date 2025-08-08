import SwiftUI
import Model
import Common

public struct UserDetailView: View {
    let user: User

    public init(user: User) {
        self.user = user
    }

    public var body: some View {
        UserImageView(urlString: user.photo,
                      shape: RoundedRectangle(cornerRadius: 10),
                      frameSize: CGSize(width: 200, height: 200))
        
        VStack(alignment: .leading, spacing: 10) {
            Text(user.name).font(.title)
            Text("Email: \(user.email)")
            Text("Phone: \(user.phone)")
            Text("State: \(user.state)")
            Text("Country: \(user.country)")
            Text("Company: \(user.company)")
        }
        .padding()
        .navigationTitle("User Detail")
    }
}
