import SwiftUI
import Model
import Common

public struct UserListView: View {
    @ObservedObject private var viewModel: UserListViewModel

    public init(viewModel: UserListViewModel) {
        self.viewModel =  viewModel
        Task {
            await viewModel.fetchUsers()
        }
    }

    public var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.users, id: \.id) { user in
                        NavigationLink(value: user) {
                            HStack(alignment: .top) {
                                UserImageView(urlString: user.photo)
                                
                                VStack(alignment: .leading) {
                                    Text(user.name).font(.headline)
                                    Text(user.email).font(.subheadline).foregroundColor(.gray)
                                    Text(user.company).font(.caption)
                                }
                            }
                        }
                    }
                    .navigationDestination(for: User.self, destination: { user in
                        UserDetailView(user: user)
                    })
                }
            }.navigationTitle("Users")
                .refreshable {
                    Task {
                        await viewModel.fetchUsers()
                    }
                }
        }
    }
}
