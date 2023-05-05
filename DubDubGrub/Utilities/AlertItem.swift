//
//  AlertItem.swift
//  DubDubGrub
//
//  Created by Quinn on 18/07/2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    
    let id = UUID()
    let title: Text
    let message: Text
    let button: Alert.Button
    
    var alert: Alert {
        Alert(title: title, message: message, dismissButton: button)
    }
}


struct AlertContext {
    
    // MARK: - MapView errors
    static let unableToGetLocations             = AlertItem(title: Text("Location errors"),
                                                message: Text("Unable to retrieve locations at this time.\nPlease try again."),
                                                button: .default(Text("OK")))
    
    static let locationRestricted               = AlertItem(title: Text("Location Restricted"),
                                                message: Text("Your location is restricted. This may be due to parental controls"),
                                                button: .default(Text("OK")))
    
    static let locationDenied                   = AlertItem(title: Text("Location Denied"),
                                                message: Text("Dub Dub Grub does not have permission to access your location. To change that, go to your phone's Settings > Dub Dub Grub > Location"),
                                                button: .default(Text("OK")))
    
    static let locationDisabled                 = AlertItem(title: Text("Location Disabled"),
                                                message: Text("Your phone's location services are disabled. To change that go to your phone's Settings > Privacy > Location Services"),
                                                button: .default(Text("OK")))
    
    static let checkedInCount                   = AlertItem(title: Text("Server Error"),
                                                message: Text("Unable to gett he number of people checked into each location. Please check your internet connection and try again"),
                                                button: .default(Text("OK")))
    
    //MARK: - Profileview Errors
    static let invalidProfile                   = AlertItem(title: Text("Invalid Profile"),
                                                message: Text("All fields are required as well as a profile photo. Your bio must be less than 100 characters.\nPlease try again"),
                                                button: .default(Text("OK")))
    
    static let noUserRecord                     = AlertItem(title: Text("No User Record"),
                                                message: Text("You must log into iCloud on your phone in order to utilise Dub Dub Grub's profile.\nPlease log in on your phone's settings screen"),
                                                button: .default(Text("OK")))
    
    static let createProfileSuccess             = AlertItem(title: Text("Profile created successfully"),
                                                message: Text("Your profile has successfully been created"),
                                                button: .default(Text("OK")))

    static let createProfileFailure             = AlertItem(title: Text("Failed to create profile"),
                                                message: Text("Unable to create profile at this time. \nPlease try again later or contact customer support if this persists"),
                                                button: .default(Text("OK")))

    static let unableToGetProfile               = AlertItem(title: Text("Unable to retrieve profile"),
                                                message: Text("Unable to retrieve your profile at this time. Please check your internet connection and try again later or contact customer support if this persists"),
                                                button: .default(Text("OK")))

    static let updateProfileSuccess             = AlertItem(title: Text("Profile Update Success!"),
                                                message: Text("Your Dub Dub Grub prfile was updated successfully."),
                                                button: .default(Text("OK")))

    static let updateProfileFailure             = AlertItem(title: Text("Profile Update Failed"),
                                                message: Text("We were unable to udpate your profile at this time.\nPlease try again later."),
                                                button: .default(Text("OK")))
    
    // MARK: LocationListView Errors
    static let unableToGetAllCheckedInProfiles  = AlertItem(title: Text("Server error"),
                                                message: Text("Unable to get all checked in Profiles at this time.\nPlease try again."),
                                                button: .default(Text("OK")))

    // MARK: LocationDetailView Errors
    static let invalidPhoneNumber               = AlertItem(title: Text("Invalid Phone Number"),
                                                message: Text("The phone number for the location is invalid.\nPlease check the number."),
                                                button: .default(Text("OK")))
    
    static let unabletoGetCheckedInStatus       = AlertItem(title: Text("Server error"),
                                                message: Text("Unable to get checked in status of the current user.\nPlease try again."),
                                                button: .default(Text("OK")))

    static let unabletoCheckInOrOut             = AlertItem(title: Text("Server error"),
                                                message: Text("We are unable to check in or out at this time.\nPlease try again."),
                                                button: .default(Text("OK")))

    static let unableToGetCheckedInProfiles    = AlertItem(title: Text("Server error"),
                                                message: Text("Unable to get users checked into this location at this time.\nPlease try again."),
                                                button: .default(Text("OK")))

}
