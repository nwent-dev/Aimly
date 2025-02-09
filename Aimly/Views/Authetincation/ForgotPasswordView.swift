import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    @State private var newPass: String = ""
    @State private var isCode: Bool = false
    @State private var isNewPass: Bool = false
    @State private var code: [String] = Array(repeating: "", count: 5)
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(spacing: UIScreen.main.bounds.height * 0.05) {
                if isNewPass {
                    HStack {
                        Text("Enter new password")
                            .foregroundStyle(.secondText)
                            .font(.custom("Nunito-SemiBold", size: 14))
                        
                        Spacer()
                    }
                    
                    FieldView(title: "", name: $newPass)
                    
                    NavigationLink(destination: LogInView()) {
                        ButtonView(text: "Submit") {
                            print("Password changed")
                        }
                        .disabled(true)
                    }
                } else {
                    if isCode {
                        Text("Enter OTP code we've sent to your email")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondText)
                            .font(.custom("Nunito-SemiBold", size: 14))
                        
                        CodeInputView(code: $code)
                        
                        ButtonView(text: "Submit") {
                            print("OTP code entered")
                            isNewPass = true
                            isCode = false
                        }
                    } else {
                        Text("Enter your email below, we will send instruction to reset your password")
                            .foregroundStyle(.secondText)
                            .font(.custom("Nunito-SemiBold", size: 14))
                        
                        FieldView(title: "", name: $email)
                        
                        ButtonView(text: "Submit") {
                            print("email entered, sending code")
                            isCode = true
                        }
                    }
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.87)
        }
    }
}

struct CodeInputView: View {
    @Binding var code: [String]
    @FocusState private var focusedIndex: Int?

    var body: some View {
        HStack(spacing: 16) { // Увеличенный отступ между ячейками
            ForEach(0..<5, id: \.self) { index in
                TextField("", text: $code[index])
                    .frame(width: UIScreen.main.bounds.width * 0.1306666667 ,height: UIScreen.main.bounds.height * 0.05911330049)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                    )
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .focused($focusedIndex, equals: index)
                    .padding(.horizontal, 2.5) // Добавил небольшой горизонтальный отступ
                    .onChange(of: code[index]) { newValue in
                        if newValue.count > 1 {
                            code[index] = String(newValue.prefix(1)) // Оставляем только 1 символ
                        }
                        if !newValue.isEmpty, index < 4 {
                            focusedIndex = index + 1 // Переход на следующую ячейку
                        }
                    }
            }
        }
        .onAppear {
            focusedIndex = 0 // Фокус на первую ячейку при открытии
        }
    }
}

#Preview {
    ForgotPasswordView()
}
