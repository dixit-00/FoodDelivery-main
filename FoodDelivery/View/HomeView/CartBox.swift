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
        VStack(spacing: 12) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 10)
            
            Text(name)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(1)
                .padding(.horizontal)
            
            HStack {
                Text(price)
                    .font(.system(size: 16, weight: .semibold))
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
                        .font(.title2)
                        .foregroundColor(isLiked ? .red : .gray)
                        .padding(8)
                }
                
                Button(action: {
                    mainVM.addToCart(product: Product(name: name, price: price, image: image))
                }) {
                    Image(systemName: "plus")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Circle().fill(Color.green))
                        .shadow(radius: 5)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4))
        .frame(width: 180)
        .padding(5)
    }
}


struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(name: "Organic Bananas", price: "$4.99", image: "placeholder_image")
            .previewLayout(.sizeThatFits)
    }
}
