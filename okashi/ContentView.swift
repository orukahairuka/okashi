//
//  ContentView.swift
//  okashi
//
//  Created by 櫻井絵理香 on 2024/04/01.
//

import SwiftUI

struct ContentView: View {
    //OkashiDataを参照する状態変数
    @StateObject var okashiDataList = OkashiData()
    //入力された文字列を保持する状態変数
    @State var inputText = ""
    var body: some View {
        VStack {
            TextField("キーワード", text: $inputText,prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    okashiDataList.searchOkashi(keyword: inputText)
                }
                .submitLabel(.search)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
