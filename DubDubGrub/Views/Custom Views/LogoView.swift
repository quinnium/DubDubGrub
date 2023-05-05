//
//  LogoView.swift
//  DubDubGrub
//
//  Created by AQ on 22/07/2022.
//

import SwiftUI

struct LogoView: View {
    
    let frameWidth: CGFloat
    
    var body: some View {
        Image(decorative: "ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(width: frameWidth)
            .allowsHitTesting(false)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(frameWidth: 250)
    }
}
