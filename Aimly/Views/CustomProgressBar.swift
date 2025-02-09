import SwiftUI

struct CustomProgressBar: View {
    var progress: Double // Значение от 0.0 до 1.0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.2)) // Фон

                RoundedRectangle(cornerRadius: 5)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.orange, Color.red]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(width: geometry.size.width * CGFloat(progress)) // Длина в зависимости от прогресса
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.01600985222)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
