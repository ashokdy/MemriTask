//
//  SVGImageView.swift
//  MemriTask
//
//  Created by ashokdy on 14/09/2021.
//

import SwiftUI

struct SVGImageView: View {
    var imageURL: String
    var height: CGFloat
    var width: CGFloat
    
    init(withURL url: String, width: CGFloat, height: CGFloat) {
        self.imageURL = url
        self.height = height
        self.width = width
    }
    
    var body: some View {
        WebView(imageURL: imageURL)
            .frame(width: width, height: height)
    }
}

#if DEBUG
struct SVGImageView_Previews: PreviewProvider {
    static var previews: some View {
        SVGImageView(withURL: "https://memri.io/assets/images/memri_01.png", width: 100, height: 100)
    }
}
#endif
