import SwiftUI
import User

struct ContentView: View {
    var body: some View {
        UserListView(viewModel: UserListViewModel())
    }
}

#Preview {
    ContentView()
}
