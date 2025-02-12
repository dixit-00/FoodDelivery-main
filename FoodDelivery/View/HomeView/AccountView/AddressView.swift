import SwiftUI

struct DeliveryAddressView: View {
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var city: String = ""
    @State private var zipCode: String = ""
    @State private var phoneNumber: String = ""
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Delivery Information")) {
                    TextField("Full Name", text: $name)
                        .padding()
                    
                    TextField("Address", text: $address)
                        .padding()
                    
                    TextField("City", text: $city)
                        .padding()
                    
                    TextField("Zip Code", text: $zipCode)
                        .keyboardType(.numberPad)
                        .padding()
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .padding()
                }
                
                Section(header: Text("Select Zone and Area")) {
                    Picker("Select Zone", selection: $viewModel.selectedZone) {
                        Text("Select Zone").tag("Select Zone")
                        Text("Zone 1").tag("Zone 1")
                        Text("Zone 2").tag("Zone 2")
                        Text("Zone 3").tag("Zone 3")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    
                    if viewModel.selectedZone != "Select Zone" {
                        TextField("Area", text: $viewModel.selectedArea)
                            .padding()
                    }
                }
                
                Section {
                    Button(action: {
                        // Action for submitting the delivery address
                        print("Address submitted: \(name), \(address), \(city), \(zipCode), \(phoneNumber), \(viewModel.selectedZone), \(viewModel.selectedArea)")
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Delivery Address")
        }
    }
}

struct DeliveryAddressView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryAddressView(viewModel: MainViewModel.shared)
    }
}
