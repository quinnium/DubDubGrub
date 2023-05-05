//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Quinn on 19/07/2022.
//

import SwiftUI
import MapKit
import CloudKit

extension LocationMapView {
    
    @MainActor final class LocationMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

        @Published var checkedInProfiles = [CKRecord.ID: Int]()
        @Published var isShowingDetailView = false
        @Published var alertItem: AlertItem?
        @Published var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 37.331516,
                longitude: -121.891054),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01))
        
        
        let deviceLocationManager = CLLocationManager()
        
        
        override init() {
            super.init()
            deviceLocationManager.delegate = self
        }
        
        
        func requestAllowOnceLocationPermission() {
            deviceLocationManager.requestLocation()
        }
        
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let currentLocation = locations.last else { return }
            
            withAnimation {
                region = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            }
        }
        
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Did fail with Error! \(error.localizedDescription)")
        }
        
        
        func getLocations(for locationManager: LocationManager) {
            
            Task {
                do {
                    locationManager.locations = try await CloudKitManager.shared.getLocations()
                } catch {
                    self.alertItem = AlertContext.unableToGetLocations
                }
            }
            
            // OLD way of doing it (before async/await)
//            CloudKitManager.shared.getLocations { [self] result in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(let locations):
//                        locationManager.locations = locations
//                    case .failure(_):
//                        self.alertItem = AlertContext.unableToGetLocations
//                    }
//                }
//            }
        }
        
        
        func getCheckedInCount() {
            Task {
                do {
                    try await checkedInProfiles = CloudKitManager.shared.getCheckedInProfilesCount()
                } catch {
                    alertItem = AlertContext.checkedInCount
                }   
            }
        }
        
        
        @ViewBuilder func createLocationDetailView(for location: DDGLocation, in dynamicTypeSize: DynamicTypeSize) -> some View {
            if dynamicTypeSize >= .accessibility3 {
                LocationDetailView(viewModel: LocationDetailViewModel(location: location)).embedInScrollView()
            } else {
                LocationDetailView(viewModel: LocationDetailViewModel(location: location))
            }
        }
    }
}

