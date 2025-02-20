//
//  Addcart.swift
//  FoodDelivery
//
//  Created by student on 19/02/25.
//
import SwiftUI

struct AddToCartButtonView: View {
    var body: some View {
        HStack {
            // Add to Cart Button with Icon
            Button(action: {
                print("Added to Cart")
            }) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                    Text("Add to Cart")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.leading, 20)
            }

            Spacer()

            // Open Cart Button with Arrow
            Button(action: {
                print("Open Cart")
            }) {
                HStack {
                    Text("Open Cart")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .padding(.trailing, 20)
            }
        }
        .frame(height: 50)
        .background(RoundedRectangle(cornerRadius: 24).fill(Color.green))
        .padding(.horizontal)
    }
}

struct AddToCartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddToCartButtonView()
            .previewLayout(.sizeThatFits)
    }
}
