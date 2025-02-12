import SwiftUI
import Foundation

class HomeViewModel: ObservableObject {
    @Published var showMenu: Bool = false
    @Published var showAddHabit: Bool = false
    @Published var habits: [HabitEntity] = []
    
    @Published var goal: String = ""
    @Published var name: String = ""
    @Published var selectedPeriod: PeriodOption? = periods.first
    @Published var selectedHabitType: HabitType = .everyday
    
    init() {
        fetchHabits()
    }
    
    func addHabit() {
        let completedDays: [String : Bool] = [:]
        CoreDataService.shared.addHabit(title: name, goal: goal, period: Int16(selectedPeriod?.days ?? 7), habitType: selectedHabitType.rawValue, completedDays: completedDays)
        fetchHabits()
    }
    
    func fetchHabits() {
        habits = CoreDataService.shared.fetchHabits()
    }
    
    func deleteHabit(_ habit: HabitEntity) {
        CoreDataService.shared.deleteHabit(habit)
        fetchHabits()
    }
    
    func completeDay(for habit: HabitEntity) {
        let today = stringFromDate(Date()) // Получаем текущую дату в виде строки

        // Приводим completedDays к [String: Bool], если возможно
        var updatedCompletedDays = (habit.completedDays as? [String: Bool]) ?? [:]

        // Переключаем значение (true ↔ false)
        updatedCompletedDays[today] = !(updatedCompletedDays[today] ?? false)

        // Обновляем значение в Core Data
        CoreDataService.shared.updateHabit(habit, title: habit.name ?? "", goal: habit.goal ?? "", period: habit.period, habitType: habit.habitType ?? "Everyday", completedDays: updatedCompletedDays)
        
        // Обновляем список привычек в ViewModel
        fetchHabits()
    }
    
    func stringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Задайте нужный формат
        return formatter.string(from: date)
    }

    func dateFromString(_ string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string)
    }
}
