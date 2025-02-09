import SwiftUI

struct ButtonView: View {
    
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Gradient(colors: [.gradient1, .gradient2]))
                
                Text(text)
                    .font(.custom("Nunito-ExtraBold", size: 14))
                    .foregroundStyle(.whiteBtn)
            }
            .frame(maxHeight: UIScreen.main.bounds.height * 0.06034482759)
        }
    }
}
