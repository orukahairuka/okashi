
import Foundation
import Alamofire
import SwiftUI



struct Welcome: Codable {
    let photos: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, sol: Int
    let camera: PhotoCamera
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

// MARK: - PhotoCamera
struct PhotoCamera: Codable {
    let id: Int
    let name: String
    let roverID: Int
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

// MARK: - Rover
struct Rover: Codable {
    let id: Int
    let name, landingDate, launchDate, status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let cameras: [CameraElement]

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}

// MARK: - CameraElement
struct CameraElement: Codable {
    let name, fullName: String

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}

struct ContentView: View {
    // 画像のURLを保持するための状態変数
    @State private var imageURLs: [String] = []

    func getMarsPhotos(date: String){
        AF.request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(date)&api_key=M0ZZGM04AWECAV49ev2u58UDXyRnZVJHuDE5ONg3").response { response in
            do {
                let decoder = JSONDecoder()
                if let data = response.data {
                    let welcome = try decoder.decode(Welcome.self, from: data)
                    // `photos`配列から画像URLを抽出して更新する
                    self.imageURLs = welcome.photos.map { $0.imgSrc }
                }
            } catch {
                print(error.localizedDescription)
            }
        }

    }

    var body: some View {
        // 画像をリスト表示する
        List(imageURLs, id: \.self) { url in
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
        }
        .onAppear {
            getMarsPhotos(date: "2020-6-3")
        }
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

