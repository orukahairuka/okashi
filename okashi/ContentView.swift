import SwiftUI


import SwiftUI

struct GithubUserView: View {
    private var viewModel = GithubUserViewModel()
    @State private var users: [GithubUserViewModel.User.Item] = []

    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                VStack(alignment: .leading) {
                    Text(user.login)
                        .font(.headline)
                    Text(user.html_url.absoluteString)
                        .font(.subheadline)
                }
            }
            .navigationBarTitle("GitHub Users")
            .onAppear {
                viewModel.searchGithubUser(query: "tarou") { fetchedUsers in
                    self.users = fetchedUsers
                }
            }
        }
    }
}





// SwiftUI App Entry Point
@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            GithubUserView()
        }
    }
}

