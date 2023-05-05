//
//  AppTabView.swift
//  DubDubGrub
//
//  Created by AQ on 08/07/2022.
//

import SwiftUI

struct AppTabView: View {
    
    @StateObject private var viewModel = appTabViewModel()
    
    var body: some View {
        
        TabView {
            
            LocationMapView()
                .tabItem { Label("Map", systemImage: "map") }
            
            LocationListView()
                .tabItem { Label("List", systemImage: "building") }
            
            NavigationView {
                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person") .foregroundColor(.none) }
        }
        .task {
            try? await CloudKitManager.shared.getUserRecord()
            viewModel.checkIfHasSeenOnboard()
        }
        .sheet(isPresented: $viewModel.isShowingOnboardView) {
            OnboardView()
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
