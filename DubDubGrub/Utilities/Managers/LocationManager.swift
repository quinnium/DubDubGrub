//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by Quinn on 19/07/2022.
//

import CoreLocation

final class LocationManager: ObservableObject {
    
    @Published var locations: [DDGLocation] = []
    
    var selectedLocation: DDGLocation?
}
