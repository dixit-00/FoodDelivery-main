
import SwiftUI

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var txtUsername: String = ""
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    @Published var userImage: String = "u1"
    @Published var favourites: [Product] = []
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var isUserLogin: Bool = false
    @Published var userObj: UserModel = UserModel(dict: [:])
    
       @Published var selectedZone: String = "Select Zone"
       @Published var selectedArea: String = ""
    
    private let profileImages = ["u1", "u2.png", "u3", "u4", "u5"]

    init() {
        
        
        if( Utils.UDValueBool(key: Globs.userLogin) ) {
            // User Login
            self.setUserData(uDict: Utils.UDValue(key: Globs.userPayload) as? NSDictionary ?? [:] )
        }else{
            // User Not Login
        }
        
   
    }
    
    func setRandomProfileImage() {
            self.userImage = profileImages.randomElement() ?? "u1" // Default to "u1" if empty
        }
    func logout(){
        Utils.UDSET(data: false, key: Globs.userLogin)
        isUserLogin = false
    }

    
    //MARK: ServiceCall
    func serviceCallLogin(){
        
        
        if(!txtEmail.isValidEmail) {
            self.errorMessage = "please enter valid email address"
            self.showError = true
            return
        }
        
        if(txtPassword.isEmpty) {
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
        }
        
        ServiceCall.post(parameter: ["email": txtEmail, "password": txtPassword, "dervice_token":"" ], path: Globs.SV_LOGIN) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    
                    
                    self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
                    
                    
                }else{
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }

    }
    
    func serviceCallSignUp(){
        
        if(txtUsername.isEmpty) {
            self.errorMessage = "please enter valid username"
            self.showError = true
            return
        }
        setRandomProfileImage()
        
        if(!txtEmail.isValidEmail) {
            self.errorMessage = "please enter valid email address"
            self.showError = true
            return
        }
        
        if(txtPassword.isEmpty) {
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
        }
        
        ServiceCall.post(parameter: [ "username": txtUsername , "email": txtEmail, "password": txtPassword, "dervice_token":"" ], path: Globs.SV_SIGN_UP) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
                }else{
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }

    }
    func addToFavourites(product: Product) {
           favourites.append(product)
       }

       func removeFromFavourites(product: Product) {
           favourites.removeAll { $0.id == product.id }
       }
    
    func setUserData(uDict: NSDictionary) {
        Utils.UDSET(data: uDict, key: Globs.userPayload)
        Utils.UDSET(data: true, key: Globs.userLogin)
        self.userObj = UserModel(dict: uDict)
        self.isUserLogin = true
        
        self.txtUsername = uDict["username"] as? String ?? ""
        self.txtEmail = uDict["email"] as? String ?? ""  // Make sure email is set
        self.txtPassword = ""
        self.isShowPassword = false
        self.setRandomProfileImage()
    }
    
   

}
