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

        //Taskは非同期処理を実行できる
        Task {
            await searchOkashi(keyword: keyword)
        }
    }

        //非同期処理でお菓子データを取得
        private func search(keyword: String) async {
            print("searchメソッドで受け取った値\(keyword)")
        }

}
