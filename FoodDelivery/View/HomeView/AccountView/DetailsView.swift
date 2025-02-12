import SwiftUI

struct UserDetailView: View {
    @State private var isEditing: Bool = false
    @State private var userAge: String = "25"
    @StateObject var mainViewModel = MainViewModel.shared
    
    var body: some View {
        VStack(spacing: 25) {
            // Display profile image
            Image(mainViewModel.userImage) // Dynamically load profile image
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.top, 30)
            
            Text("My Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text("Update your details below")
                .foregroundColor(.gray)
                .font(.subheadline)
            
            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    Text("Name")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(mainViewModel.txtUsername)")
                        .font(.body)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Age")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    TextField("Enter Age", text: $userAge)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .disabled(!isEditing) // Disable if not editing
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Email")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(mainViewModel.txtEmail)")
                        .font(.body)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                
                // Password Field
                HStack {
                    Text("Password")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    if mainViewModel.isShowPassword {
                        TextField("Enter Password", text: $mainViewModel.txtPassword)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .disabled(!isEditing) // Disable if not editing
                    } else {
                        SecureField("Enter Password", text: $mainViewModel.txtPassword)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .disabled(!isEditing) // Disable if not editing
                    }
                }
                .padding(.horizontal)
                
                // Toggle Password Visibility
                HStack {
                    Spacer()
                    Button(action: {
                        mainViewModel.isShowPassword.toggle()
                    }) {
                        Text(mainViewModel.isShowPassword ? "Hide Password" : "Show Password")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 20)
            
            Button(action: {
                isEditing.toggle()
                if !isEditing {
                    // Call service when saved
                    mainViewModel.serviceCallLogin() // or serviceCallSignUp()
                }
            }) {
                Text(isEditing ? "Save" : "Edit Details")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isEditing ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            HStack {
                Text("Already have an account?")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("Sign in")
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        // Handle sign-in action here
                    }
            }
            .padding(.bottom, 20)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(.systemGray6)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView()
    }
}
