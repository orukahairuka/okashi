import SwiftUI
import Combine

// Make sure QiitaViewModel is an ObservableObject
class QiitaViewModel: ObservableObject {
    @Published var articles: [QiitaStruct] = []

    init() {
        fetchArticle()
    }

    func fetchArticle() {
        let url = "https://qiita.com/api/v2/items"

        guard var urlComponents = URLComponents(string: url) else {
            return
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: "50"),
        ]

        let task = URLSession.shared.dataTask(with: urlComponents.url!) { [weak self] data, response, error in
            guard let jsonData = data else {
                return
            }

            do {
                let articles = try JSONDecoder().decode([QiitaStruct].self, from: jsonData)
                DispatchQueue.main.async {
                    self?.articles = articles
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

// SwiftUI ContentView
struct ContentView: View {
    @ObservedObject var viewModel = QiitaViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.articles, id: \.title) { article in
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.headline)
                    Text(article.user.name)
                        .font(.subheadline)
                }
            }
            .navigationBarTitle("QiitaAPI")
        }
    }
}

// Your QiitaStruct remains unchanged
struct QiitaStruct: Codable {
    var title: String
    var user: User
    struct User: Codable {
        var name: String
    }
}

// SwiftUI App Entry Point
@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

