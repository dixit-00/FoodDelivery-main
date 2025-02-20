import SwiftUI

struct VerticalCartBox: View {
    var name: String
    var price: String
    var image: String
    var onRemove: () -> Void  // Closure to handle removal action

    var body: some View {
        ZStack(alignment: .topLeading) { // Use ZStack to overlay the cross button
            VStack(spacing: 8) {
                // Product Image with rounded corners and shadow
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)  // Reduced image size to fit within the frame
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .padding(.trailing)

                // Product Name with a more stylish font
                Text(name)
                    .font(.system(size: 10, weight: .bold)) // Smaller font size to fit within frame
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .padding(.horizontal, 5)

                // Price and Add Button
                Spacer() // Allow the content to stretch and push the add button to the bottom
                HStack {
                    Text(price)
                        .font(.system(size: 10, weight: .semibold)) // Adjust price font size
                        .foregroundColor(.primary)

                    Spacer()

                    // Add Button
                    Button(action: {
                        // Handle add to cart action
                    }) {
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Circle().fill(Color.green))
                            .shadow(radius: 3)
                    }
                }
                .padding(.horizontal, 5)
            }
            .padding(.vertical, 2) // Reduced vertical padding to fit within the frame
            .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 3))
            .frame(width: 350, height: 60) // Fixed frame size of 350x60
            .padding(5)

            // Cross Button at the top-left corner
            Button(action: {
                onRemove() // Call the removal action
            }) {
                Image(systemName: "xmark")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(5)
                    .background(Circle().fill(Color.white.opacity(0.8)))
                    .shadow(radius: 3)
            }
            .offset(x: 323, y: -20) // Adjust the position of the cross button
        }
    }
}

struct VerticalCartBox_Previews: PreviewProvider {
    static var previews: some View {
        VerticalCartBox(name: "Organic Bananas", price: "$4.99", image: "banana", onRemove: {
            print("Item removed") // Example removal action
        })
        .previewLayout(.sizeThatFits)
    }
}
