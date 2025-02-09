import SwiftUI

struct MainView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag(1)
            
            ProgressView()
                .tag(2)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(tabSelection: $selectedTab)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainView()
}
