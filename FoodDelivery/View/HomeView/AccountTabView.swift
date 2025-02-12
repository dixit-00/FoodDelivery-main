import SwiftUI

struct AccountTabView: View {
    @StateObject var mainVM = MainViewModel.shared
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        // Profile Section
                        HStack {
                            Image("u1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text("\(mainVM.txtUsername)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text("\(mainVM.txtEmail)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        
                        Divider()
                        
                        // Account Options List
                        VStack(spacing: 0) {
                            AccountOption(title: "Orders", icon: "bag", destination: OrdersView())
                            AccountOption(title: "My Details", icon: "person", destination:  UserDetailView())
                            AccountOption(title: "Delivery Address", icon: "location", destination: DeliveryAddressView(viewModel: MainViewModel.shared))
                            AccountOption(title: "Payment Methods", icon: "creditcard", destination: PaymentView())
                            AccountOption(title: "Promo Code", icon: "tag", destination: PromoView())
                            AccountOption(title: "Notifications", icon: "bell", destination: NotificationsView())
                            AccountOption(title: "Help", icon: "questionmark.circle", destination: HelpView())
                            AccountOption(title: "About", icon: "info.circle", destination: AboutView())
                        }
                        
                        Divider()
                        
                        LogOutButton(action: {
                            mainVM.logout() // Log out logic
                        })

                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainTabView: View {
    
    
    var body: some View {
        TabView {
            HomeTabView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            ExploreTabView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }

            CartTabView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }

            FavouriteTabView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourite")
                }

            AccountTabView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
        }
        .accentColor(.green)
    }
}

#Preview {
    MainTabView()
}

// Reusable Component for Account Options
struct AccountOption<Destination: View>: View {
    var title: String
    var icon: String
    var destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.black)
                    .font(.title2)
                
                Text(title)
                    .font(.title3)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            Divider()
        }
    }
}

// Reusable LogOut Button Component
struct LogOutButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "arrow.right.circle.fill")
                    .foregroundColor(.white)
                    .font(.title2)
                
                Text("Log Out")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green.opacity(0.9))
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

#Preview {
    AccountTabView()
}
