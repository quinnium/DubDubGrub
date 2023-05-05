//
//  AvatarView.swift
//  DubDubGrub
//
//  Created by AQ on 15/07/2022.
//

import SwiftUI

struct AvatarView: View {
    
    var size: CGFloat
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}


struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(size: 90, image: PlaceholderImage.avatar)
    }
}
