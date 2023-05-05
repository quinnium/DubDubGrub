//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by Quinn on 08/07/2022.
//

import SwiftUI

struct LocationDetailView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                BannerImageView(image: viewModel.location.bannerImage)
                AddressHStack(address: viewModel.location.address)
                DescriptionView(text: viewModel.location.description)
                ActionButtonHStack(viewModel: viewModel)
                GridHeaderTextView(number: viewModel.checkedInProfiles.count)
                AvatarGridView(viewModel: viewModel)
                Spacer() 
            }
            
            if viewModel.isShowingProfileModal {
                FullScreenBlackTransparencyView()
                ProfileModalView(profile: viewModel.selectedProfile!, isShowingProfileModal: $viewModel.isShowingProfileModal)
            }
        }
        .task {
            viewModel.getCheckedInProfiles()
            viewModel.getCheckedInStatus()
        }
        .sheet(isPresented: $viewModel.isShowingProfileSheet) {
            NavigationView {
                ProfileSheetView(profile: viewModel.selectedProfile!)
                    .toolbar { Button("Dismiss") { viewModel.isShowingProfileSheet = false } }
            }
        }
        .alert(item: $viewModel.alertItem, content: { $0.alert })
        .navigationTitle(viewModel.location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationDetailView(viewModel: LocationDetailViewModel(location: DDGLocation.init(record: MockData.chipotle)))
        }
    }
}


fileprivate struct BannerImageView: View {
    
    var image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
            .accessibilityHidden(true)
    }
}


fileprivate struct AddressHStack: View {
    
    var address: String
    var body: some View {
        HStack {
            Label(address, systemImage: "mappin.and.ellipse")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.horizontal)
    }
}


fileprivate struct DescriptionView: View {
    
    var text: String
    var body: some View {
        Text(text)
            .padding(.horizontal)
            .fixedSize(horizontal: false, vertical: true)
            .minimumScaleFactor(0.75)
    }
}


fileprivate struct GridHeaderTextView: View {
    
    var number: Int
    var body: some View {
        Text("Who's Here?")
            .fontWeight(.bold)
            .font(.title2)
            .accessibilityAddTraits(.isHeader)
            .accessibilityLabel("Who's here? \(number) checked in")
            .accessibilityHint(Text("Bottom section is scrollable"))
    }
}


fileprivate struct ActionButtonHStack: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            
            Button {
                viewModel.getDirectionToLocation()
            } label: {
                LocationActionButton(color: .brandPrimary, imageName: "location.fill")
            }
            .accessibilityLabel(Text("Get directions"))
            
            Link(destination: URL(string: viewModel.location.websiteURL)!) {
                LocationActionButton(color: .brandPrimary, imageName: "network")
            }
            .accessibilityRemoveTraits(.isButton)
            .accessibilityLabel(Text("Go to website"))
            
            Button {
                viewModel.callLocation()
            } label: {
                LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
            }
            .accessibilityLabel(Text("Call location"))
            
            if let _ = CloudKitManager.shared.profileRecordID {
                Button {
                    viewModel.updateCheckedInStatus(to: viewModel.isCheckedIn ? .checkedOut : .checkedIn)
                } label: {
                    LocationActionButton(color: viewModel.buttonColor, imageName: viewModel.buttonImageTitle)
                }
                .accessibilityLabel(Text(viewModel.buttonA11yLabel))
                .disabled(viewModel.isLoading)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .background(Color(.secondarySystemBackground))
        .clipShape(Capsule())
    }
}


fileprivate struct LocationActionButton: View {
    
    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 22, height: 22)
        }
    }
}


fileprivate struct GridEmptyStateTextView: View {
    
    var body: some View {
        Text("Nobody's here 😢")
            .bold()
            .font(.title2)
            .foregroundColor(.secondary)
            .padding(.top, 50)
    }
}


fileprivate struct AvatarGridView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var body: some View {
        ZStack {
            if viewModel.checkedInProfiles.isEmpty {
                GridEmptyStateTextView()
            } else {
                ScrollView {
                    LazyVGrid(columns: viewModel.determineColumns(for: dynamicTypeSize)) {
                        ForEach(viewModel.checkedInProfiles) { profile in
                            FirstNameAVatarView(profile: profile)
                                .onTapGesture {
                                    withAnimation { viewModel.show(profile, in: dynamicTypeSize) }
                                }
                        }
                    }
                }
            }
            if viewModel.isLoading { LoadingView() }
        }
    }
}


fileprivate struct FirstNameAVatarView: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var profile: DDGProfile
    
    var body: some View {
        VStack {
            AvatarView(size: dynamicTypeSize >= .accessibility3 ? 100 : 64,
                       image: profile.avatarImage)
            Text(profile.firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(Text("\(profile.firstName) \(profile.lastName)"))
        .accessibilityHint(Text("Show's \(profile.firstName) profile popup"))
    }
}


fileprivate struct FullScreenBlackTransparencyView: View {
    
    var body: some View {
        Color(.black)
            .ignoresSafeArea()
            .opacity(0.9)
            .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.35)))
        // The below two lines commented out, S.Allen thinks due to swiftUI bug
        //                    .transition(.opacity)
        //                    .animation(.easeOut)
            .zIndex(1)
            .accessibilityHidden(true)
    }
}
