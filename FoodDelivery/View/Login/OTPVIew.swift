import SwiftUI

struct OTPVerificationView: View {
    @State private var otp: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?

    var body: some View {
        NavigationStack{
            ZStack {
                Image("bottom_bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.4), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .onTapGesture { hideKeyboard() } // Dismiss keyboard on tap
                
                VStack(spacing: 30) {
                    // Back Button
                    HStack {
                        NavigationLink{
                            SingInView()
                        }label: {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                        }
                        Spacer()
                    }
                    
                    // Title
                    VStack(spacing: 8) {
                        Text("Enter Verification Code")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("We've sent a 4-digit code to your phone.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .multilineTextAlignment(.center)
                    
                    // OTP Input Boxes
                    HStack(spacing: 15) {
                        ForEach(0..<4, id: \.self) { index in
                            TextField("", text: Binding(
                                get: { otp[index] },
                                set: { newValue in
                                    if newValue.count <= 1 {
                                        otp[index] = newValue
                                        
                                        // Move focus forward when typing
                                        if newValue.count == 1 && index < 3 {
                                            focusedIndex = index + 1
                                        }
                                        
                                        // Move focus backward when deleting
                                        if newValue.isEmpty && index > 0 {
                                            focusedIndex = index - 1
                                        }
                                    }
                                }
                            ))
                            .frame(width: 50, height: 50)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            .focused($focusedIndex, equals: index)
                            .onTapGesture { focusedIndex = index } // Ensures keyboard opens on tap
                        }
                    }
                    
                    // Resend Code
                    NavigationLink {
                        // Handle Resend Action
                    }label: {
                        Text("Resend Code")
                            .font(.body)
                            .foregroundColor(.green)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    // Submit Button
                    Button(action: {
                        verifyOTP()
                    }) {
                        Image(systemName: "arrow.right")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.green).shadow(radius: 5))
                    }
                    .padding(.bottom, 40)
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
            .onAppear { focusedIndex = 0 } // Focus first input on load
        }
    }

    // Function to Hide Keyboard
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    // Function to Verify OTP (Example Logic)
    private func verifyOTP() {
        let enteredOTP = otp.joined()
        print("Entered OTP: \(enteredOTP)")
        
        // Add API Call to Verify OTP Here
    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView()
    }
}
