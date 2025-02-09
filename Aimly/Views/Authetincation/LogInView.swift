import SwiftUI

struct LogInView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var isRemembered: Bool = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(spacing: UIScreen.main.bounds.height * 0.04) {
                HStack(alignment: .bottom) {
                    Text("Log In")
                        .font(.custom("Nunito-Bold", size: 44))
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        
                        NavigationLink {
                            SignUpView()
                        } label: {
                            HStack {
                                Text("Sign Up")
                                if #available(iOS 16.0, *) {
                                    Image(systemName: "chevron.right")
                                        .fontWeight(.bold)
                                } else {
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .font(.custom("Nunito-ExtraBold", size: 14))
                            .foregroundStyle(.myOrange)
                            .padding(.bottom)
                        }
                    }
                }

                .padding(.top, UIScreen.main.bounds.height * 0.06)
                .frame(maxHeight: UIScreen.main.bounds.height * 0.1)
                
                FieldView(title: "Email", name: $email)
                FieldView(title: "Password", name: $password)
                
                HStack {
                    
                    Toggle("Remember me", isOn: $isRemembered)
                        .font(.custom("Nunito-Regular", size: 14))
                        .toggleStyle(.button)
                    
                    Spacer()
                    
                    NavigationLink {
                        ForgotPasswordView()
                    } label: {
                        Text("Forgot password?")
                            .foregroundStyle(.myOrange)
                            .font(.custom("Nunito-SemiBold", size: 14))
                    }
                }
                
                ButtonView(text: "Log In") {
                    print("Log In")
                }
                
                Spacer()
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.87)
        }
    }
}

#Preview {
    LogInView()
}
