import SwiftUI

struct ProductDetailView: View {
    @State private var quantity: Int = 1
    @State private var isLiked: Bool = false
    var product: Product // Accept product as input
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var mainVM = MainViewModel.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Product Image
                Image(product.image) // Use the passed product's image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .padding()

                HStack {
                    Text(product.name) // Use the passed product's name
                        .font(.title)
                        .fontWeight(.bold)

                    Spacer()

                    Button(action: {
                        isLiked.toggle()
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .red : .gray)
                            .font(.title2)
                    }
                }
                .padding(.horizontal)

                Text("1kg, Price") // You can customize based on your need
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                // Quantity Selector & Price
                HStack {
                    Stepper(value: $quantity, in: 1...20) {
                        Text("Quantity: \(quantity)")
                    }

                    Spacer()

                    Text(product.price) // Show the passed product's price
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding()

                Divider()

                // Product Details
                VStack(alignment: .leading, spacing: 10) {
                    Text("Product Detail")
                        .font(.headline)

                    Text("Description of \(product.name)") // You can customize the description
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding()

                Divider()

                // Nutrition Info
                HStack {
                    Text("Nutritions")
                        .font(.headline)
                    Spacer()
                    Text("100gr")
                        .foregroundColor(.gray)
                }
                .padding()

                Divider()

                // Review
                HStack {
                    Text("Review")
                        .font(.headline)
                    Spacer()
                    HStack(spacing: 5) {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.orange)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(product.name) // Set the navigation bar title to product name
        .navigationBarBackButtonHidden(false)
        .navigationBarItems(trailing: Button(action: {}) {
            Image(systemName: "square.and.arrow.up")
        })
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: {}) {
                    Text("Add To Basket")
                        .foregroundColor(.white)
                        .frame(width: 300, height: 30)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(14)
                }
            }
        }
    }
}


struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(name: "Organic Bananas", price: "$4.99", image: "banana"))
    }
}
