import SwiftUI

struct ProductCardView: View {
    var name: String
    var price: String
    var image: String
    @State private var isLiked: Bool = false  // State for managing like button state

    var body: some View {
        VStack(spacing: 12) {
            // Product Image with rounded corners and shadow
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 10)

            // Product Name with a more stylish font
            Text(name)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(1)
                .padding(.horizontal)

            // Price and Add Button with Like Button
            HStack {
                Text(price)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                // Like Button
                Button(action: {
                    isLiked.toggle() // Toggle the like status
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(isLiked ? .red : .gray)
                        .padding(8)
                        .background()
                       
                }

                // Add Button
                Button(action: {
                    // Handle add to cart action
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
