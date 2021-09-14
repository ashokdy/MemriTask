//
//  ImageView.swift
//  MemriTask
//
//  Created by ashokdy on 14/09/2021.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image: UIImage = UIImage()
    var height: CGFloat
    var width: CGFloat
    
    init(withURL url: String, width: CGFloat, height: CGFloat) {
        imageLoader = ImageLoader(urlString:url)
        self.height = height
        self.width = width
    }
    
    var body: some View {
        
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: height, height: width)
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}

#if DEBUG
struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "https://memri.io/assets/images/memri_01.png", width: 100, height: 100)
    }
}
#endif
