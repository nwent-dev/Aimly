import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    @State private var progress: Double = 5.0 / 7.0 // Например, 5 из 7
    
    @State var habits: [HabitMock] = [
        HabitMock(title: "Meditating", yourGoal: "Sleep before 11 pm", isDone: true, period: 7, habitType: "Everyday", daysIsDone: 5),
        HabitMock(title: "Read philosophy", yourGoal: "Finish 5 philosophy books", isDone: true, period: 7, habitType: "Everyday", daysIsDone: 5),
        HabitMock(title: "Journaling", yourGoal: "Finish read the Hobbits", isDone: false, period: 7, habitType: "Everyday", daysIsDone: 5)
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
                    if !viewModel.habits.isEmpty {
                        // MARK: - Habits
                        yourHabits
                        
                        // MARK: - Goals
                        yourGoals
                            .padding(.bottom, UIScreen.main.bounds.width * 0.15)
                    }
                }
                .background {
                    Color.background
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
            
            if viewModel.showAddHabit {
                addHabit
            }
            
            Button {
                viewModel.showAddHabit = true
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white.opacity(0.8))
                    .background {
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.gradient1, .primaryy]), startPoint: .bottomLeading, endPoint: .topTrailing))
                    }
            }
            .frame(width: UIScreen.main.bounds.width * 0.15)
            .position(x: UIScreen.main.bounds.width * 0.85, y: UIScreen.main.bounds.height * 0.85)
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
                
                ForEach(0..<min(3, viewModel.habits.count), id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(
                                ((viewModel.habits[index].completedDays as? [String: Bool])?[viewModel.stringFromDate(Date())] == true) ? Color.greengo : Color.background
                            )
                        
                        HStack {
                            Text(viewModel.habits[index].name ?? "no name")
                                .font(.custom("Nunito-Semibold", size: 16))
                            
                            Spacer()
                            Button {
                                viewModel.completeDay(for: viewModel.habits[index])
                            } label: {
                                let completedDays = viewModel.habits[index].completedDays as? [String: Bool] ?? [:]
                                
                                Image(completedDays[viewModel.stringFromDate(Date())] == true ? "checkboxDone" : "checkbox")
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
                                    viewModel.deleteHabit(viewModel.habits[index])
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
                
                ForEach(0..<min(3, viewModel.habits.count), id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.background)
                        
                        VStack {
                            HStack {
                                Text(viewModel.habits[index].goal ?? "")
                                    .font(.custom("Nunito-Bold", size: 16))
                                
                                Spacer()
                                
                                Menu {
                                    Button {
                                        
                                    } label: {
                                        Text("Edit")
                                            .foregroundStyle(Color.secondary)
                                    }
                                    
                                    Button {
                                        viewModel.deleteHabit(viewModel.habits[index])
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
                            
                            CustomProgressBar(progress: viewModel.getProgress(for: viewModel.habits[index]))
                            
                            HStack {
                                Text("\(viewModel.getCountOfCompletedDays(for: viewModel.habits[index])) from \(viewModel.habits[index].period) days target")
                                    .font(.custom("Nunito-Medium", size: 14))
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text(viewModel.habits[index].habitType ?? "")
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
    
    var addHabit: some View {
        ZStack {
            Color.white.opacity(0.5)
            
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white)
                    .shadow(radius: 100)
                
                VStack(spacing: UIScreen.main.bounds.width * 0.05) {
                    HStack {
                        Text("Create New Habit Goal")
                            .font(.custom("Nunito-Bold", size: 18))
                        
                        Spacer()
                        
                        Button {
                            viewModel.showAddHabit = false
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.black)
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                    
                    Divider()
                        .foregroundStyle(.secondText)
                    
                    FieldView(title: "Your Goal", name: $viewModel.goal)
                    
                    FieldView(title: "Habit Name", name: $viewModel.name)
                    
                    HStack {
                        Text("Period")
                            .font(.custom("Nunito-SemiBold", size: 14))
                        
                        Spacer()
                        
                        Picker("Выберите период", selection: $viewModel.selectedPeriod) {
                            ForEach(periods) { period in
                                Text("\(period.title) (\(period.days) Days)")
                                    .font(.custom("Nunito-SemiBold", size: 16))
                                    .tag(period)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                    }
                    
                    HStack {
                        Text("Habit Type")
                            .font(.custom("Nunito-SemiBold", size: 14))
                        
                        Spacer()
                        
                        Picker("Выберите тип привычки", selection: $viewModel.selectedHabitType) {
                            ForEach(HabitType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                                    .font(.custom("Nunito-SemiBold", size: 16))
                                    .tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle()) // Стиль выпадающего меню
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                    }
                    
                    ButtonView(text: "Create New") {
                        viewModel.addHabit()
                        viewModel.showAddHabit = false
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width * 0.89,
                   height: UIScreen.main.bounds.height * 0.6)
        }
    }
    
    func formattedCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: Date())
    }
}

struct HabitMock: Codable, Hashable, Identifiable {
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
