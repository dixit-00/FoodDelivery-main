import SwiftUI

class MainViewModel: ObservableObject {
    static let shared = MainViewModel()
    
    @Published var txtUsername = ""
    @Published var txtEmail = ""
    @Published var txtPassword = ""
    @Published var isShowPassword = false
    @Published var userImage = "u1"
    @Published var favourites: [Product] = []
    @Published var cart: [Product] = []
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var isUserLogin = false
    @Published var userObj = UserModel(dict: [:])
    
    @Published var selectedZone = "Select Zone"
    @Published var selectedArea = ""
    
    private let profileImages = ["u1", "u2", "u3", "u4", "u5"]
    
    init() {
        if Utils.UDValueBool(key: Globs.userLogin) {
            setUserData(uDict: Utils.UDValue(key: Globs.userPayload) as? NSDictionary ?? [:])
        }
    }
    
    func setRandomProfileImage() {
        userImage = profileImages.randomElement() ?? "u1"
    }
    
    func logout() {
        Utils.UDSET(data: false, key: Globs.userLogin)
        isUserLogin = false
    }
    
    func addToFavourites(product: Product) {
        if !favourites.contains(where: { $0.id == product.id }) {
            favourites.append(product)
        }
    }
    
    func removeFromFavourites(product: Product) {
        favourites.removeAll { $0.id == product.id }
    }
    
    func serviceCallLogin() {
        guard txtEmail.isValidEmail else {
            showError(message: "Please enter a valid email address")
            return
        }
        
        guard !txtPassword.isEmpty else {
            showError(message: "Please enter a valid password")
            return
        }
        
        ServiceCall.post(parameter: ["email": txtEmail, "password": txtPassword, "device_token": ""], path: Globs.SV_LOGIN) { responseObj in
            if let response = responseObj as? NSDictionary, response[KKey.status] as? String == "1" {
                self.setUserData(uDict: response[KKey.payload] as? NSDictionary ?? [:])
            } else {
                self.showError(message: responseObj?[KKey.message] as? String ?? "Login failed")
            }
        } failure: { error in
            self.showError(message: error?.localizedDescription ?? "Login failed")
        }
    }
   
    func addToCart(product: Product) {
        if let index = cart.firstIndex(where: { $0.id == product.id }) {
            cart[index].quantity += 1
        } else {
            var newProduct = product
            newProduct.quantity = 1
            cart.append(newProduct)
        }
    }
    
    func removeFromCart(product: Product) {
        if let index = cart.firstIndex(where: { $0.id == product.id }) {
            if cart[index].quantity > 1 {
                cart[index].quantity -= 1
            } else {
                cart.remove(at: index)
            }
        }
    }

    func serviceCallSignUp() {
        guard !txtUsername.isEmpty else {
            showError(message: "Please enter a valid username")
            return
        }
        
        guard txtEmail.isValidEmail else {
            showError(message: "Please enter a valid email address")
            return
        }
        
        guard !txtPassword.isEmpty else {
            showError(message: "Please enter a valid password")
            return
        }
        
        setRandomProfileImage()
        
        ServiceCall.post(parameter: ["username": txtUsername, "email": txtEmail, "password": txtPassword, "device_token": ""], path: Globs.SV_SIGN_UP) { responseObj in
            if let response = responseObj as? NSDictionary, response[KKey.status] as? String == "1" {
                self.setUserData(uDict: response[KKey.payload] as? NSDictionary ?? [:])
            } else {
                self.showError(message: responseObj?[KKey.message] as? String ?? "Signup failed")
            }
        } failure: { error in
            self.showError(message: error?.localizedDescription ?? "Signup failed")
        }
    }
    
    func toggleFavourite(product: Product) {
        if let index = favourites.firstIndex(where: { $0.id == product.id }) {
                favourites.remove(at: index) // Remove if already liked
            } else {
                favourites.append(product) // Add if not liked
            }
        }
    
    func setUserData(uDict: NSDictionary) {
        Utils.UDSET(data: uDict, key: Globs.userPayload)
        Utils.UDSET(data: true, key: Globs.userLogin)
        userObj = UserModel(dict: uDict)
        isUserLogin = true
        txtUsername = uDict["username"] as? String ?? ""
        txtEmail = uDict["email"] as? String ?? ""
        txtPassword = ""
        isShowPassword = false
        setRandomProfileImage()
    }
    
    private func showError(message: String) {
        errorMessage = message
        showError = true
    }
}

