//
//  QuestionController.swift
//  iOSUdfordring
//
//  Created by dmu mac 26 on 09/10/2023.
//

import Foundation

class QuestionController: ObservableObject{
    @Published var questions: [Question] = []
    @Published var currentQuestion: Question?
    private var url: URL?
    
    init(category: String, difficulty: Difficulty, categories: [Category]) {
        for c in categories {
            if c.name == category {
                guard let questionsUrl = URL(string: "https://opentdb.com/api.php?amount=10&category=\(c.id)&difficulty=\(difficulty.rawValue)") else {return}
                url = questionsUrl
                if let url {
                    fetchQuestions(from: url)
                }
            }
        }
    }
    
    func updateCurrentQuestion() {
        if let currentQuestion {
            let index = questions.firstIndex(of: currentQuestion)
            if let index {
                if index == questions.count-1 {
                    if let url {
                        fetchQuestions(from: url)
                    }
                } else {
                    self.currentQuestion = questions[index+1]
                }
            }
        }
    }
    
    private func fetchQuestions(from url: URL) {
        Task(priority: .low) {
            guard let rawQuestionData = await NetworkServices.getData(from: url) else {return}
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(Questions.self, from: rawQuestionData)
                Task.detached { @MainActor in
                    if result.response_code == 0 {
                        self.questions = result.results
                        self.currentQuestion = self.questions[0]
                    }
                }
            } catch {
                fatalError("Konvertering fra JSON gik ad h til")
            }
        }
    }
}
