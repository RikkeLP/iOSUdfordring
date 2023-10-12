//
//  ContentView.swift
//  iOSUdfordring
//
//  Created by dmu mac 26 on 09/10/2023.
//

import SwiftUI

struct StartQuizView: View {
    @EnvironmentObject var quizController: CategoryController
    
    @State private var difficulty = Difficulty.Easy
    @State private var choosenCategory = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose your quiz").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Form {
                    Section("Trivial categories") {
                        Menu {
                            ForEach(quizController.categories, id: \.self.id) { category in
                                Button("\(category.name) (\(quizController.getQuestionCount(categoryid: category.id)) questions)" ) {
                                    self.choosenCategory = category.name
                                }
                            }
                        } label: {
                            VStack(spacing: 5){
                                HStack{
                                    Text(choosenCategory.isEmpty ? "Choose category" : choosenCategory)
                                        .foregroundColor(choosenCategory.isEmpty ? .gray : .black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color.orange)
                                        .font(Font.system(size: 20, weight: .bold))
                                }
                                .padding(.horizontal)
                                Rectangle()
                                    .fill(Color.orange)
                                    .frame(height: 2)
                            }
                        }
                    }
                    Section("Difficulties") {
                        Picker("Choose difficulty", selection: $difficulty) {
                            Text("Easy").tag(Difficulty.Easy)
                            Text("Medium").tag(Difficulty.Medium)
                            Text(Difficulty.Hard.rawValue).tag(Difficulty.Hard)
                        }
                        NavigationLink {
                            QuestionView().environmentObject(QuestionController(category: choosenCategory, difficulty: difficulty, categories: quizController.categories))
                        } label: {
                            Text("Play quiz")
                                .foregroundStyle(Color.orange)
                        }
                    }
                }
            }.background(Color(.orange))
        }
    }
}

#Preview {
    StartQuizView().environmentObject(CategoryController())
}
