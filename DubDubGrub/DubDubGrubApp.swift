//
//  DubDubGrubApp.swift
//  DubDubGrub
//
//  Created by AQ on 08/07/2022.
//
// added for a commit
// added after first mac commit, but before change (with readme) was pulled from origin

import SwiftUI

@main
struct DubDubGrubApp: App {
    
    let locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(locationManager)
        }
    }
}
