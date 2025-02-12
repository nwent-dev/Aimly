import SwiftUI
import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    @Published var showMenu: Bool = false
    @Published var showAddHabit: Bool = false
    @Published var habits: [HabitEntity] = []
    @Published var habitsByDate: [HabitEntity] = []
    
    @Published var selectedDate: Date = Date()
    @Published var goal: String = ""
    @Published var name: String = ""
    @Published var selectedPeriod: PeriodOption? = periods.first
    @Published var selectedHabitType: HabitType = .everyday
    
    init() {
        fetchHabits()
        getHabitsByDate(for: Date())
    }
    
    func addHabit() {
        let completedDays: [String : Bool] = [:]
        CoreDataService.shared.addHabit(title: name, goal: goal, period: Int16(selectedPeriod?.days ?? 7), habitType: selectedHabitType.rawValue, completedDays: completedDays)
        fetchHabits()
    }
    
    func fetchHabits() {
        habits = CoreDataService.shared.fetchHabits()
        print(habits)
    }
    
    func deleteHabit(_ habit: HabitEntity) {
        CoreDataService.shared.deleteHabit(habit)
        fetchHabits()
    }
    
    func getProgress(for habit: HabitEntity) -> Double {
        let completedDaysCount = habit.completedDays as? [String: Bool] ?? [:]
        return Double(getCountOfCompletedDays(for: habit)) / Double(habit.period)
    }
    
    func getCountOfCompletedDays(for habit: HabitEntity) -> Int {
        let completedDaysCount = habit.completedDays as? [String: Bool] ?? [:]
        return completedDaysCount.filter { $0.value }.count
    }
    
    func getHabitsByDate(for selectedDate: Date)  {
        let calendar = Calendar.current
        
        habitsByDate = habits.filter { habit in
            guard let createdAt = habit.createdAt else {return false}
            print("Created at - \(createdAt)")
            
            guard let endDate = calendar.date(byAdding: .day, value: Int(habit.period), to: createdAt) else {return false}
            print("End date - \(endDate)")
            
            return selectedDate >= createdAt && selectedDate <= endDate
        }
        print(habitsByDate)
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
