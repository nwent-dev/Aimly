import SwiftUI

struct HomeView: View {
    
    @State private var showMenu: Bool = false
    @State private var progress: Double = 5.0 / 7.0 // Например, 5 из 7
    @State var habits: [Habit] = [
        Habit(title: "Meditating", yourGoal: "Sleep before 11 pm", isDone: true, period: 7, habitType: "Everyday", daysIsDone: 5),
        Habit(title: "Read philosophy", yourGoal: "Finish 5 philosophy books", isDone: true, period: 7, habitType: "Everyday", daysIsDone: 5),
        Habit(title: "Journaling", yourGoal: "Finish read the Hobbits", isDone: false, period: 7, habitType: "Everyday", daysIsDone: 5)
    ]
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text(formattedCurrentDate())
                        .font(.custom("Nunito-Bold", size: 16))
                    Spacer()
                }
                .padding(.top)
                HStack(spacing: 0) {
                    Text("Hello, ")
                        .font(.custom("Nunito-Semibold", size: 28))
                    Text("Susy!")
                        .foregroundStyle(.myOrange)
                        .font(.custom("Nunito-Bold", size: 28))
                    
                    Spacer()
                }
                
                ScrollView {
                    VStack(spacing: UIScreen.main.bounds.height * 0.12){
                        // MARK: - Habits
                        yourHabits
                        
                        // MARK: - Goals
                        yourGoals
                    }
                    .padding(.bottom, UIScreen.main.bounds.width * 0.15)
                }
                .background {
                    Color.background
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
    }
    
    var yourHabits: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
            
            VStack {
                HStack {
                    Text("Today Habit")
                        .font(.custom("Nunito-Bold", size: 21))
                    
                    Spacer()
                    
                    Text("See all")
                        .font(.custom("Nunito-Bold", size: 14))
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.gradient1, .gradient2]), startPoint: .bottomLeading, endPoint: .topTrailing))
                }
                .padding(.top)
                
                ForEach(0..<habits.count) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(habits[index].isDone ? Color.greengo : Color.background)
                        
                        HStack {
                            Text(habits[index].title)
                                .font(.custom("Nunito-Semibold", size: 16))
                            
                            Spacer()
                            Button {
                                habits[index].isDone.toggle()
                            } label: {
                                Image(habits[index].isDone ? "checkboxDone" : "checkbox")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.08)
                            }
                            
                            Menu {
                                Button {
                                    
                                } label: {
                                    Text("Edit")
                                        .foregroundStyle(Color.secondary)
                                }
                                
                                Button {
                                    
                                } label: {
                                    Text("Delete")
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .scaledToFit()
                                    .rotationEffect(.degrees(90))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.04, height: UIScreen.main.bounds.width * 0.04)
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.07142857143)
                    .padding(.top)
                }
                
                Spacer()
            }
            .padding()
        }
        .frame(height: UIScreen.main.bounds.height * 0.407044335)
    }
    
    var yourGoals: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
            
            VStack {
                HStack {
                    Text("Your Goals")
                        .font(.custom("Nunito-Bold", size: 21))
                    
                    Spacer()
                    
                    Text("See all")
                        .font(.custom("Nunito-Bold", size: 14))
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.gradient1, .gradient2]), startPoint: .bottomLeading, endPoint: .topTrailing))
                }
                .padding(.top)
                
                ForEach(0..<habits.count) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.background)
                        
                        VStack {
                            HStack {
                                Text(habits[index].yourGoal)
                                    .font(.custom("Nunito-Bold", size: 16))
                                
                                Spacer()
                                
                                Menu {
                                    Button {
                                        
                                    } label: {
                                        Text("Edit")
                                            .foregroundStyle(Color.secondary)
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        Text("Delete")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .resizable()
                                        .scaledToFit()
                                        .rotationEffect(.degrees(90))
                                        .foregroundStyle(.black)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.04, height: UIScreen.main.bounds.width * 0.04)
                            }
                            
                            CustomProgressBar(progress: progress)
                            
                            HStack {
                                Text("\(habits[index].daysIsDone) from \(habits[index].period) days target")
                                    .font(.custom("Nunito-Medium", size: 14))
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text(habits[index].habitType)
                                    .font(.custom("Nunito-Medium", size: 14))
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.gradient1, .gradient2]), startPoint: .bottomLeading, endPoint: .topTrailing))
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.1428571429)
                    .padding(.top)
                }
                
                Spacer()
            }
            .padding()
        }
        .frame(height: UIScreen.main.bounds.height * 0.447044335)
    }
    
    func formattedCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: Date())
    }
}

struct Habit: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var title: String
    var yourGoal: String
    var isDone: Bool
    var period: Int
    var habitType: String
    var daysIsDone: Int
}

#Preview {
    HomeView()
}
