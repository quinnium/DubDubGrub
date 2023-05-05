//
//  OnboardView.swift
//  DubDubGrub
//
//  Created by AQ on 22/07/2022.
//

import SwiftUI

struct OnboardView: View {
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    XDismissButton()
                }
                .padding()
            }
            
            Spacer()
            
            LogoView(frameWidth: 250).padding(.bottom)
            
            VStack(alignment: .leading, spacing: 32) {
                OnboardInfoView(systemImageName: "building.2.crop.circle", title: "Restaurant Locations", descrption: "Find places to dine around the convention centre")
                OnboardInfoView(systemImageName: "checkmark.circle", title: "Check In", descrption: "Let other iOS Devs know where you are")
                OnboardInfoView(systemImageName: "person.2.circle", title: "Find Friends", descrption: "See where other iOS Devs are and join the party")
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
    }
}


struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView()
            .preferredColorScheme(.dark)
    }
}


fileprivate struct OnboardInfoView: View {
    
    let systemImageName: String
    let title: String
    let descrption: String
    
    var body: some View {
        HStack(spacing: 26) {
            Image(systemName: systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandPrimary)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .bold()
                Text(descrption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}
