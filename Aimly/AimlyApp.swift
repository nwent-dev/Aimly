import SwiftUI

@main
struct AimlyApp: App {
    let coreDataService: CoreDataService = CoreDataService.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, coreDataService.context)
        }
    }
}
