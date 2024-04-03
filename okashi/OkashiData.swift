
import Foundation

class GithubUserViewModel {

    //JSON Decodeのための構造体
    struct User: Codable {
        let total_count: Int
        let incomplete_results: Bool
        let items: [Item]

        struct Item: Codable {
            let login: String
            let id: Int
            let node_id: String
            let avatar_url: URL
            let gravatar_id: String?
            let url: URL
            let html_url: URL
            let followers_url: URL
            let subscriptions_url: URL
            let organizations_url: URL
            let repos_url: URL
            let received_events_url: URL
            let type: String
            let score: Double
        }
    }

    //デフォルメでGETメソッドになってる,//Postにしたいときは別
    func searchGithubUser(query: String, completion: @escaping ([User.Item]) -> Void){
        guard let url = URL(string: "https://api.github.com/search/users?q=" + query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //ここにデータ受信後の処理を書く
            guard let data = data else { return }
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(user.items)
                }
            } catch {
                print("JSON Decode Error: \(error)")
            }  
        }
        task.resume()
    }
}
