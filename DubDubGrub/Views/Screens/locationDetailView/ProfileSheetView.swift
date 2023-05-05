//
//  ProfileSheetView.swift
//  DubDubGrub
//
//  Created by Quinn on 20/08/2022.
//

import SwiftUI

// Alternative profile modal view for larger dyanmic type sizes
// We present this as a sheet instead of a small popup

struct ProfileSheetView: View {
    
    var profile: DDGProfile
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(uiImage: profile.avatarImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                    .accessibilityHidden(true)
                
                Text(profile.firstName + " " + profile.lastName)
                    .font(.title2)
                    .bold()
                    .minimumScaleFactor(0.9)

                Text(profile.companyName)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.9)
                    .foregroundColor(.secondary)
                    .accessibilityLabel(Text("Works at \(profile.companyName)"))

                Text(profile.bio)
                    .accessibilityLabel(Text("Bio, \(profile.bio)"))
            }
            .padding()
        }
        
    }
}

struct ProfileSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSheetView(profile: DDGProfile.init(record: MockData.profile))
            .environment(\.dynamicTypeSize, .accessibility5)
    }
}
