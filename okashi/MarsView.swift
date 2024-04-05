//
//  MarsView.swift
//  okashi
//
//  Created by 櫻井絵理香 on 2024/04/04.
//

import SwiftUI

struct MarsPhotoView: View {
    @StateObject private var viewModel = MarsController()
    @State var selectedDate: Date = Date()
    var body: some View {
        VStack {
            Spacer()
            DatePicker("Date", selection: $selectedDate,displayedComponents: .date)
                .fixedSize()
                .padding()
            Button {
                let formattedDate = viewModel.format(date: selectedDate)
                print(selectedDate)
                viewModel.getMarsPhotos(date: formattedDate)
            } label: {
                Text("画像を探す")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
            .frame(width: 160,height: 70)
            .background(.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            List(viewModel.imageURLs, id: \.self) { url in
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: url)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 300,height: 300)
                    Spacer()
                }

            }
            .onAppear {
                // ViewModelを通じてデータを取得
                viewModel.getMarsPhotos(date: "2020-6-3")
            }
        }
    }

}
