

import SwiftUI

struct GithubUserView: View {
    private var viewModel = GithubUserViewModel()
    @State private var users: [GithubUserViewModel.User.Item] = []
    @State private var inputText: String = "tarou"

    var body: some View {
        VStack {
            Spacer()
            TextField("名前検索するよ", text: $inputText)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button {
                viewModel.searchGithubUser(query: inputText) { fetchedUsers in
                    self.users = fetchedUsers
                }
            } label: {
                Text("検索する")
            }
            .frame(width: 130,height:  90)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
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
//                .onAppear {
//                    viewModel.searchGithubUser(query: inputText) { fetchedUsers in
//                        self.users = fetchedUsers
//                    }
//                }
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

