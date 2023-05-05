//
//  CustomModifiers.swift
//  DubDubGrub
//
//  Created by AQ on 15/07/2022.
//

import SwiftUI

struct ProfileNameText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
            .disableAutocorrection(true)
    }
}
