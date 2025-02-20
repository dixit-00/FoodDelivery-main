import SwiftUI

struct CartTabView: View {
    @StateObject var mainVM = MainViewModel.shared
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
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
                    
                    HStack {
                        Button(action: {
                            mainVM.removeFromCart(product: product)
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                        }
                        
                        Text("\(product.quantity)")
                            .font(.headline)
                            .padding(.horizontal, 8)
                        
                        Button(action: {
                            mainVM.addToCart(product: product)
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.trailing, 10)
                }
            }
        }
    }
}

struct CartTabView_Previews: PreviewProvider {
    static var previews: some View {
        CartTabView()
    }
}
