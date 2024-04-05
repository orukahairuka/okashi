//
//  NasaController.swift
//  okashi
//
//  Created by 櫻井絵理香 on 2024/04/05.
//

import SwiftUI
import Alamofire

class MarsController: ObservableObject {
    @Published var imageURLs: [String] = []

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

    func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }


}
