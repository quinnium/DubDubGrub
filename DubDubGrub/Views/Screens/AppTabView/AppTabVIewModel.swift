//
//  AppTabVIewModel.swift
//  DubDubGrub
//
//  Created by AQ on 12/08/2022.
//

import MapKit
import SwiftUI

extension AppTabView {

    final class appTabViewModel: ObservableObject {
        
        @Published var isShowingOnboardView = false
        @AppStorage("hasSeenOnboardView") var hasSeenOnboardView = false {
            didSet {
                isShowingOnboardView = hasSeenOnboardView
            }
        }
        
        let kHasSeenOnboardView = "hasSeenOnboardView"
        
        
        func checkIfHasSeenOnboard() {
            if hasSeenOnboardView == false {
                hasSeenOnboardView = true
            }
        }
    }
}
