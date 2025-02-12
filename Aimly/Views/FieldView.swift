import SwiftUI

struct FieldView: View {
    
    let title: String
    @Binding var name: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.mainText)
                
                Spacer()
            }
            TextField("", text: $name)
                .frame(height: UIScreen.main.bounds.height * 0.05172413793)
                .textFieldStyle(.plain)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.stroke, lineWidth: 2)
                }
                .background(Color.white)
        }
        
    }
    
}
