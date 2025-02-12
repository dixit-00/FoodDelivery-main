import SwiftUI

struct SelectLocationView: View {
    @StateObject var mainVM = MainViewModel.shared
    
    let zones = ["Rajasthan", "Gujarat", "Mumbai", "Delhi"]
    let areas = ["Residential", "Commercial", "Industrial", "Other"]
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var navigateToNextPage = false
    @State private var isLoggedOut = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("bottom_bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                
                VStack(spacing: 20) {
                    HStack {
                        Button(action: {
                            mode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.top, 50)
                    
                    Image("illustration")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.bottom, 100)
                    
                    Text("Select Your Location")
                        .font(.customfont(.semibold, fontSize: 26))
                        .fontWeight(.bold)
                    
                    Text("Switch on your location to stay in tune with what’s happening in your area")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Your Zone")
                            .font(.headline)
                        
                        Menu {
                            ForEach(zones, id: \.self) { zone in
                                Button(zone) {
                                    mainVM.selectedZone = zone // Automatically saves the selection to UserDefaults
                                }
                            }
                        } label: {
                            HStack {
                                Text(mainVM.selectedZone)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(height: 30)
                            .cornerRadius(8)
                        }
                        Divider()
                        
                        Text("Your Area")
                            .font(.headline)
                        
                        Menu {
                            ForEach(areas, id: \.self) { area in
                                Button(area) {
                                    mainVM.selectedArea = area // Automatically saves the selection to UserDefaults
                                }
                            }
                        } label: {
                            HStack {
                                Text(mainVM.selectedArea.isEmpty ? "Types of your area" : mainVM.selectedArea)
                                    .foregroundColor(mainVM.selectedArea.isEmpty ? .gray : .black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(height: 30)
                            .cornerRadius(8)
                        }
                        Divider()
                    }
                    .padding(.horizontal, 30)
                    
                    Button(action: {
                        navigateToNextPage = true
                    }) {
                        Text("Submit")
                            .font(.customfont(.bold, fontSize: 27))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 30)
                    
                    NavigationLink(destination: HomeScreen(), isActive: $navigateToNextPage) {
                        EmptyView()
                    }
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationView{
        SelectLocationView()
    }
}
