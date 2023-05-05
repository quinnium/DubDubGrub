//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by AQ on 08/07/2022.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct LocationMapView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationMapViewModel()
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations, annotationContent: { eachLocation in
                
                MapAnnotation(coordinate: eachLocation.location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.75)) {
                    DDGAnnotation(location: eachLocation,
                                  number: viewModel.checkedInProfiles[eachLocation.id, default: 0])
                    .onTapGesture {
                        locationManager.selectedLocation = eachLocation
                        viewModel.isShowingDetailView = true
                    }
                }
            })
            .accentColor(.grubRed)
            .ignoresSafeArea(.container, edges: .top)
            
            LogoView(frameWidth: 125)
                .shadow(radius: 10)
            

            
        }
        .sheet(isPresented: $viewModel.isShowingDetailView) {
            NavigationView {
                //Force unwrapping on the line below is potentially risky,  but S.A. decided to do this anyway
                viewModel.createLocationDetailView(for: locationManager.selectedLocation!, in: dynamicTypeSize)
                    .toolbar { Button("Dismiss") { viewModel.isShowingDetailView = false } }
            }
        }
        .overlay(alignment: .bottomLeading, content: {
            LocationButton(.currentLocation) {
                viewModel.requestAllowOnceLocationPermission()
            }
            .foregroundColor(.white)
            .symbolVariant(.fill)
            .tint(.grubRed)
            .labelStyle(.iconOnly)
            .clipShape(Circle())
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 0))
        })
        
        .alert(item: $viewModel.alertItem, content: { $0.alert })
        .task {
            if locationManager.locations.isEmpty { viewModel.getLocations(for: locationManager) }
            viewModel.getCheckedInCount()
        }
    }
}


struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
            .environmentObject(LocationManager())
    }
}



