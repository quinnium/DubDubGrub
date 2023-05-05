//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by AQ on 15/07/2022.
//

import SwiftUI

extension View {
    
    func profileNameText() -> some View {
        self.modifier(ProfileNameText())
    }
    
    
    func embedInScrollView() -> some View {
        GeometryReader { geometry in
            ScrollView {
                self.frame(minHeight: geometry.size.height, maxHeight: .infinity)
            }
        }
    }    
}


