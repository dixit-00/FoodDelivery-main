import SwiftUI
import CountryPicker

struct SingInView: View {
    
    @State var txtMobile: String = ""
    @State var isShowPicker: Bool = false
    @State var countryObj: Country?
    @State var isValidNumber: Bool = false

    var body: some View {
        ZStack {
            
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenWidth)
            
            VStack {
                Image("sign_in_top")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenWidth)
                Spacer()
            }
            
            ScrollView {
                VStack {
                    Text("Get your groceries \nwith nectar")
                        .font(.customfont(.semibold, fontSize: 26))
                        .foregroundColor(.primaryText)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 350)
                        .padding(.trailing, 130)
                        .padding(.bottom, 20)
                    
                    HStack {
                        Button {
                            isShowPicker = true
                        } label: {
                            if let countryObj = countryObj {
                                Text("\(countryObj.isoCode.getFlag())")
                                    .font(.customfont(.medium, fontSize: 35))
                                    .padding(.leading, 25)
                                
                                Text("+\(countryObj.phoneCode)")
                                    .font(.customfont(.medium, fontSize: 18))
                                    .foregroundColor(.primaryText)
                            }
                        }
                        
                        Divider()
                            .frame(width: 10)
                        
                        TextField("Enter Mobile", text: $txtMobile)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.trailing, 18)
                            .keyboardType(.numberPad)
                            .onChange(of: txtMobile) { newValue in
                                // Validate if the phone number is complete (e.g., 10 digits)
                                isValidNumber = newValue.count == 10
                            }
                        
                        NavigationLink {
                            OTPVerificationView()
                        } label: {
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(isValidNumber ? .green : .gray) // Disable when number is incomplete
                                .padding(.trailing, 30)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        .disabled(!isValidNumber) // Disable the button when the number is incomplete
                    }
                    Divider()
                        .frame(width: 350)
                        .padding(.bottom, 15)
                    
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Continue with SignIn")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .background(Color(hex: "5383EC"))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Continue with SignUp")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .background(Color.primaryApp)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    
                    Divider()
                        .frame(width: 350)
                    
                    VStack {
                        Text("or connect with social media")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.textTitle)
                            .multilineTextAlignment(.center)
                            .padding(.top, 30)
                            .padding(.bottom, 15)
                        
                        HStack {
                            Image("google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(.trailing, 5)
                            Image("facebook")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(.trailing, 5)
                            Image("apple_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    }
                }
                .padding(.top, 50)
            }
            .onAppear {
                self.countryObj = Country(phoneCode: "91", isoCode: "IN")
            }
        }
        .sheet(isPresented: $isShowPicker, content: {
            CountryPickerUI(country: $countryObj)
        })
        .navigationTitle("")
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationView {
        SingInView()
    }
}
