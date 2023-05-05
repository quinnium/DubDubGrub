//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by AQ on 15/07/2022.
//

import SwiftUI

struct LocationCell: View {
    
    var location: DDGLocation
    var profiles: [DDGProfile]
    
    var body: some View {
        HStack {
            Image(uiImage: location.squareImage)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .frame(width: 200, alignment: .leading)
                
                if profiles.isEmpty {
                    Text("Nobody's checked in")
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding(.top, 2)
                        .frame(width: 200, alignment: .leading)
                } else {
                    HStack {
                        ForEach(profiles.indices, id: \.self) { index in
                            if index <= 3 || (index == 4 && profiles.count == 5){
                                AvatarView(size: 35, image: profiles[index].avatarImage)
                            }
                            else if index == 4 && profiles.count > 5 {
                                AdditionalProfilesView(number: min(profiles.count - 4, 99))
                            }
                        }
                    }
                }
            }
            .padding(.leading)
        }
    }
}


struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location: DDGLocation(record: MockData.location), profiles: [])
    }
}


fileprivate struct AdditionalProfilesView: View {
    
    let number: Int
    
    var body: some View {
        ZStack {
            Text("+\(number)")
                .font(.system(size: 14, weight: .semibold))
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .background(Color.brandPrimary)
                .clipShape(Circle())
        }
        .frame(width: 35, height: 35)
        
    }
}
