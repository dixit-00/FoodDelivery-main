import SwiftUI

struct FavouriteTabView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var mainVM = MainViewModel.shared  // Use mainVM as the state object

    var body: some View {
        NavigationView {
            VStack {
                // Display list of favourite products
                List(mainVM.favourites, id: \.id) { product in
                    HStack {
                        Image(product.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        VStack(alignment: .leading) {
                            Text(product.name)
                                .font(.headline)
                            Text(product.price)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        // Cross Button to remove the liked product
                        Button(action: {
                                                    mainVM.toggleFavourite(product: product)
                                                }) {
                                                    Image(systemName: "xmark.circle.fill")
                                                        .foregroundColor(.red)
                                                        .font(.title)
                                                }

                    }
                    .padding()
                }
                .navigationTitle("Favourite Products")
                .navigationBarItems(trailing: EditButton()) // Optional: for editing the list
            }
        }
    }
}

struct FavouriteTabView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteTabView()
            .environmentObject(MainViewModel.shared)  // Providing the shared ViewModel in the preview
    }
}
