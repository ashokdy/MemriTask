//
//  ContentView.swift
//  MemriTask
//
//  Created by ashokdy on 14/09/2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        LoadingView(isShowing: viewModel.$isLoading) {
            NavigationView {
                ScrollView {
                    VStack {
                        ForEach(viewModel.datamodel, id: \.self) { model in
                            getView(dataModel: model)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .onAppear() {
                    viewModel.getData()
                }
                .alert(isPresented: $viewModel.showError) {
                    Alert(
                        title: Text("Alert!"),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("Ok"))
                    )
                }
                .navigationTitle("Feed")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    func getView(dataModel: DataResponse) -> some View {
        Group {
            switch dataModel.type {
            case .image:
                pngImageView(dataModel: dataModel, imageURL: dataModel.url ?? "")
            case .text:
                Text(dataModel.data?.stringValue ?? "")
                    .font(dataModel.font?.actual())
                    .frame(
                        width: dataModel.width.actual(),
                        height: dataModel.height.actual(),
                        alignment: dataModel.alignment?.actual() ?? .center
                    )
            case .row:
                HStack {
                    ForEach(dataModel.data?.arrayValue ?? [], id: \.self) { imageURL in
                        imageView(dataModel: dataModel, imageURL: imageURL)
                    }
                }
                .frame(maxWidth: .infinity, alignment: dataModel.alignment?.actual() ?? .center)
            case .column:
                VStack {
                    ForEach(dataModel.data?.arrayValue ?? [], id: \.self) { imageURL in
                        imageView(dataModel: dataModel, imageURL: imageURL)
                    }
                }
                .frame(maxWidth: .infinity, alignment: dataModel.alignment?.actual() ?? .center)
            case .stack:
                ZStack {
                    ForEach(dataModel.data?.arrayValue ?? [], id: \.self) { imageURL in
                        imageView(dataModel: dataModel, imageURL: imageURL)
                    }
                }
                .frame(alignment: dataModel.alignment?.actual() ?? .center)
            }
        }
    }
    
    func imageView(dataModel: DataResponse, imageURL: String) -> some View {
        Group {
            if imageURL.contains(".svg") {
                svgImageView(dataModel: dataModel, imageURL: imageURL)
            } else {
                pngImageView(dataModel: dataModel, imageURL: imageURL)
            }
        }
    }
    
    func pngImageView(dataModel: DataResponse, imageURL: String) -> some View {
        ImageView(
            withURL: imageURL,
            width: dataModel.width.actual() ?? 100,
            height: dataModel.width.actual() ?? 100
        )
    }
    
    func svgImageView(dataModel: DataResponse, imageURL: String) -> some View {
        VStack {
            SVGImageView(
                withURL: imageURL,
                width: dataModel.width.actual() ?? 100,
                height: dataModel.width.actual() ?? 100
            )
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
