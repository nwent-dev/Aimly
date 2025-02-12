import SwiftUI

struct YourHabitsView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                HabitCalendarView(viewModel: viewModel) // Горизонтальный календарь
                
                ScrollView {
                    yourHabits
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                                .foregroundStyle(.black)
                                .font(.title2)
                            
                            Text("Your Habit")
                                .font(.custom("Nunito-Bold", size: 21))
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchHabits()
                viewModel.getHabitsByDate(for: Date())
            }
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
                }
                .padding(.top)
                
                ForEach(viewModel.habitsByDate.indices, id: \.self) { index in
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
        .frame(maxHeight: UIScreen.main.bounds.height * 0.407044335)
    }

    /// Форматирует выбранную дату
    func formattedSelectedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter.string(from: viewModel.selectedDate)
    }
}

#Preview {
    YourHabitsView()
}
