//
//  QuestionView.swift
//  iOSUdfordring
//
//  Created by dmu mac 26 on 09/10/2023.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var questionController: QuestionController
    @State private var didTap = false
    var body: some View {
        NavigationView {
            VStack {
                if let question = questionController.currentQuestion {
                    Text(question.question)
                    ForEach(question.answers, id: \.self) { answer in
                        Button {
                            self.didTap = true
                        } label: {
                            Text(answer)
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                        }.buttonStyle(.bordered).background(didTap ? question.checkAnswer(answer: answer) ? Color.green : Color.red : Color.white)
                    }
                    Button {
                        if didTap == true {
                            questionController.updateCurrentQuestion()
                            didTap = false
                        }
                    } label: {
                        Text("Next question")
                            .foregroundStyle(.orange)
                    }
                }
            }
        }
    }
}

#Preview {
    QuestionView().environmentObject(QuestionController(category: "Entertainment: Music", difficulty: Difficulty.Easy, categories: [Category(name: "Entertainment: Music", id: 12), Category(name: "Art", id: 25)]))
}
