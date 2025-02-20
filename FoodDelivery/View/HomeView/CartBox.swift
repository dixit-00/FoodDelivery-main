import SwiftUI

struct ProductCardView: View {
    var name: String
    var price: String
    var image: String

    @StateObject var mainVM = MainViewModel.shared
    
    var isLiked: Bool {
        mainVM.favourites.contains { $0.name == name && $0.price == price && $0.image == image }
    }
    
    var body: some View {
        VStack(spacing: 8) { // Reduced spacing
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 120) // Reduced height
                .clipShape(RoundedRectangle(cornerRadius: 12)) // Slightly smaller radius
                .shadow(radius: 8)

            Text(name)
                .font(.system(size: 16, weight: .bold)) // Smaller font
                .foregroundColor(.primary)
                .lineLimit(1)
                .padding(.horizontal, 5) // Reduced padding
            
            HStack {
                Text(price)
                    .font(.system(size: 14, weight: .semibold)) // Smaller price font
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: {
                    if isLiked {
                        mainVM.removeFromFavourites(product: Product(name: name, price: price, image: image))
                    } else {
                        mainVM.addToFavourites(product: Product(name: name, price: price, image: image))
                    }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.title3) // Smaller icon
                        .foregroundColor(isLiked ? .red : .gray)
                        .padding(6) // Reduced padding
                }
                
                Button(action: {
                    mainVM.addToCart(product: Product(name: name, price: price, image: image))
                }) {
                    Image(systemName: "plus")
                        .font(.title3) // Slightly smaller
                        .foregroundColor(.white)
                        .padding(8) // Reduced padding
                        .background(Circle().fill(Color.green))
                        .shadow(radius: 4) // Smaller shadow
                }
            }
            .padding(.horizontal, 5) // Reduced horizontal padding
        }
        .padding(.vertical, 8) // Reduced vertical padding
        .background(RoundedRectangle(cornerRadius: 16) // Slightly smaller corner radius
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 3)) // Reduced shadow
        .frame(width: 160) // Reduced width
        .padding(4) // Reduced outer padding
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(name: "Organic Bananas", price: "$4.99", image: "apple_red")
            .previewLayout(.sizeThatFits)
    }
}
