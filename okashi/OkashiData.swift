//
//  OkashiData.swift
//  okashi
//
//  Created by 櫻井絵理香 on 2024/04/01.
//

import Foundation

//お菓子データ検索用クラス
class OkashiData: ObservableObject {
    //WebAPI検索用メソッド 第一引数:keyword 検索したいワード
    func searchOkashi(keyword: String) {
        print("searchOkashiメソッドで受け取った値：\(keyword)")
    }
}
