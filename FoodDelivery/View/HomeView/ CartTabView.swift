//
//   CartTabView.swift
//  FoodDelivery
//
//  Created by student on 08/02/25.
//

import SwiftUI

struct CartTabView: View {
    @StateObject var mainVM = MainViewModel.shared
    
    var body: some View {
        VStack {
            Text("Your Cart")
                .font(.largeTitle)
                .padding()
            
            List(mainVM.cart) { product in
                HStack {
                    Image(product.image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.headline)
                        Text(product.price)
                            .font(.subheadline)
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    CartTabView()
}
