import SwiftUI

struct ExploreTabView: View {
    @StateObject var mainVM = MainViewModel.shared
    @State private var searchText = ""

    let categories = [
        Category(name: "Fresh Fruits & Vegetable", image: "frash_fruits", color: Color.green.opacity(0.1), borderColor: Color.green),
        Category(name: "Cooking Oil & Ghee", image: "cooking_oil", color: Color.orange.opacity(0.1), borderColor: Color.orange),
        Category(name: "Meat & Fish", image: "meat_fish", color: Color.red.opacity(0.1), borderColor: Color.red),
        Category(name: "Bakery & Snacks", image: "bakery_snacks", color: Color.purple.opacity(0.1), borderColor: Color.purple),
        Category(name: "Dairy & Eggs", image: "dairy_eggs", color: Color.yellow.opacity(0.1), borderColor: Color.yellow),
        Category(name: "Beverages", image: "beverages", color: Color.blue.opacity(0.1), borderColor: Color.blue)
    ]

    var body: some View {
        NavigationStack {
            ScrollView{
                VStack {
                    Text("Find Products")
                        .font(.system(size: 25, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search Store", text: $searchText)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.1)))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    .padding()
                    
                    // Grid of Categories
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(categories, id: \.name) { category in
                            CategoryCard(category: category)
                        }
                    }
                    .padding()
                }
                }
                .padding()
        }
    }
}

struct CategoryCard: View {
    let category: Category

    var body: some View {
        VStack {
            Image(category.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text(category.name)
                .font(.system(size: 16, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top, 8)
        }
        .frame(width: 160, height: 180)
        .background(category.color)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(category.borderColor, lineWidth: 1))
    }
}

struct Category {
    let name: String
    let image: String
    let color: Color
    let borderColor: Color
}

#Preview {
    ExploreTabView()
}
