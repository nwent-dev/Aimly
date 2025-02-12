import CoreData
import Foundation

class CoreDataService {
    static let shared = CoreDataService()
    
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "Aimly") // Имя должно совпадать с файлом .xcdatamodeld
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Ошибка загрузки Core Data: \(error), \(error.userInfo)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Сохранение контекста
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Ошибка сохранения Core Data: \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func addHabit(title: String, goal: String, period: Int16, habitType: String, completedDays: [String : Bool]) {
        let newHabit = HabitEntity(context: context)
        newHabit.id = UUID()
        newHabit.name = title
        newHabit.goal = title
        newHabit.period = period
        newHabit.habitType = habitType
        newHabit.createdAt = Date()
        newHabit.completedDays = completedDays as NSObject
        
        saveContext()
    }
    
    func updateHabit(_ habit: HabitEntity, title: String, goal: String, period: Int16, habitType: String, completedDays: [String : Bool]) {
        habit.name = title
        habit.goal = goal
        habit.period = period
        habit.habitType = habitType
        habit.completedDays = completedDays as NSObject
        
        saveContext()
    }
    
    func fetchHabits() -> [HabitEntity] {
        let request: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \HabitEntity.createdAt, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Ошибка извлечения данных: \(error)")
            return []
        }
    }
    
    func deleteHabit(_ habit: HabitEntity) {
        context.delete(habit)
        saveContext()
    }
}
