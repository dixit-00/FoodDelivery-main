import SwiftUI

struct HomeScreen: View {
    @StateObject var mainVM = MainViewModel.shared

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

            // Favourite Tab
            FavouriteTabView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourite")
                }

            // Account Tab
            AccountTabView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
        }
        .accentColor(.green)
    }
}


struct HomeTabView: View {
    @StateObject var mainVM = MainViewModel.shared
    @State private var searchText = ""

    // Sample Product List
    let products = [
        Product(name: "Organic Bananas", price: "$4.99", image: "banana"),
        Product(name: "Red Apple", price: "$3.99", image: "apple_red"),
        Product(name: "Ginger", price: "$2.49", image: "ginger"),
        Product(name: "Bell Pepper Red", price: "$2.99", image: "bell_pepper_red"),
        Product(name: "Pulses", price: "Variety", image: "pulses"),
        Product(name: "Beef Bone", price: "$5.99", image: "beef_bone"),
        Product(name: "Broiler Chicken", price: "$6.99", image: "broiler_chicken")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) { // Increased spacing between sections

                // Location and Search
                VStack/*(alignment: .leading, spacing: 10)*/ {
                    Image("color_logo")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .multilineTextAlignment(.center)
                    // Displaying selected location from MainViewModel
                    NavigationLink {
                        SelectLocationView()
                    }label:{
    
                            Text("\(mainVM.selectedZone), \(mainVM.selectedArea.isEmpty ? "Select Area" : mainVM.selectedArea)")
                                .font(.title3)
                                .foregroundColor(.black)
                                .frame(width: 300, height:50)
                        
                            
                    }


                    HStack{ // Enhanced Search Bar
                        Image("search")
                            .resizable()
                            .frame(width: 30, height:30)

                        TextField("Search Store", text: $searchText)
                            
                    }.padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(gradient: Gradient(colors: [.white, Color.gray.opacity(0.2)]), startPoint: .leading, endPoint: .trailing))
                        )
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        .shadow(color: .gray.opacity(0.1), radius: 5)
                        .padding()
                }

                // Scrollable Images Section
                ScrollView(.horizontal, showsIndicators: false) { // Horizontal scroll view
                    HStack {
                        Image("images")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 140)
                            .cornerRadius(10)

                        Image("9576_Portrait_010334_1_442_carousel")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 140)
                        Image("banner_top")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 370, height: 140)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20) // Padding below the images section

                // Fresh Vegetables Section
                VStack(alignment: .leading) {
                    Text("Fresh Vegetables")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(products, id: \.id) { product in
                                ProductCardView(name: product.name, price: product.price, image: product.image)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 20)

                // Best Selling Section
                VStack(alignment: .leading) {
                    Text("Best Selling")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.orange)
                        .padding(.bottom, 8)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(products, id: \.id) { product in
                                ProductCardView(name: product.name, price: product.price, image: product.image)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 20)

                // Groceries Section
                VStack(alignment: .leading) {
                    Text("Groceries")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 8)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(products, id: \.id) { product in
                                ProductCardView(name: product.name, price: product.price, image: product.image)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 20) // Padding for the top section
        }
        .navigationTitle("Home")
        .background(LinearGradient(gradient: Gradient(colors: [.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
    }
}

// Product Model
struct Product: Identifiable {
    var id = UUID()
    var name: String
    var price: String
    var image: String
}

// Product Card View


// Preview
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
