import SwiftUI

struct YourGoalView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .font(.title)
                    }
                    
                    Text("Your Habit")
                        .font(.custom("Nunito-Bold", size: 28))
                    
                    Spacer()
                }
                .padding(.top)
                .padding(.leading)
                
                ScrollView {
                    yourGoals
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9,
                   height: UIScreen.main.bounds.height * 0.86)
            .background{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var yourGoals: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
            
            VStack {
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
            .padding(.horizontal)
        }
        .frame(maxHeight: UIScreen.main.bounds.height * 0.62)
    }
}

#Preview {
    YourGoalView()
}
