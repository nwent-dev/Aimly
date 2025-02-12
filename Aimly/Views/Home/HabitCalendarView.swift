import SwiftUI
import Foundation

struct HabitCalendarView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(lastSevenDays(), id: \.self) { date in
                    VStack {
                        Text(dateString(date, format: "d"))
                            .font(.custom("Nunito-Bold", size: 21, relativeTo: .title3))
                            .foregroundColor(isSelected(date) ? .myOrange : .black)
                        
                        Text(dateString(date, format: "MMM"))
                            .font(.custom("Nunito-Medium", size: 14, relativeTo: .headline))
                            .foregroundColor(isSelected(date) ? .myOrange : .gray)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.16, height: UIScreen.main.bounds.height * 0.08)
                    .background(isSelected(date) ? Color.calendarFill : Color.white)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected(date) ? Color.calendarStroke : .black.opacity(0.14), lineWidth: 1.5)
                    }
                    .onTapGesture {
                        viewModel.selectedDate = date
                        viewModel.getHabitsByDate(for: date)
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.08)
            .padding(.horizontal)
            .padding(.vertical, 2)
        }
    }
    
    /// Получает последние 7 дней, включая сегодня
    func lastSevenDays() -> [Date] {
        let calendar = Calendar.current
        return (0..<31).reversed().compactMap {
            calendar.date(byAdding: .day, value: -$0, to: Date())
        }.reversed() // Отображаем от старого к новому
    }
    
    /// Форматирование даты
    func dateString(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    /// Проверка, является ли дата выбранной
    func isSelected(_ date: Date) -> Bool {
        Calendar.current.isDate(viewModel.selectedDate, inSameDayAs: date)
    }
}

//#Preview {
//    HabitCalendarView(viewModel: HomeViewModel())
//}

struct HabitCalendarView_Previews : PreviewProvider {
    static var previews: some View {
        HabitCalendarView(viewModel: HomeViewModel())
            .previewLayout(.sizeThatFits)
    }
}
