import SwiftUI

struct SignUpView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack(spacing: UIScreen.main.bounds.height * 0.04) {
                    HStack(alignment: .bottom) {
                        Text("Sign Up")
                            .font(.custom("Nunito-Bold", size: 44))
                        
                        Spacer()
                        
                        VStack {
                            Spacer()
                            
                            NavigationLink {
                                LogInView()
                            } label: {
                                HStack {
                                    Text("Log in")
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
                    
                    FieldView(title: "Name", name: $name)
                    FieldView(title: "Email", name: $email)
                    FieldView(title: "Password", name: $password)
                    FieldView(title: "Password Confirmation", name: $passwordConfirmation)
                    
                    ButtonView(text: "Sign Up") {
                        print("Sign Up")
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.87)
            }
        }
    }
}

#Preview {
    SignUpView()
}
