//
//  WebView.swift
//  MemriTask
//
//  Created by ashokdy on 15/09/2021.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    let imageURL: String
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: imageURL) else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(imageURL: "https://memri.io/assets/images/memri_components.svg")
    }
}
#endif
