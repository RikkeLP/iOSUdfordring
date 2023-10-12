//
//  QuestionModel.swift
//  iOSUdfordring
//
//  Created by dmu mac 26 on 09/10/2023.
//

import Foundation

struct Questions: Decodable {
    let response_code: Int
    let results: [Question]
}

struct Question: Decodable, Identifiable, Equatable {
    let id = UUID().uuidString
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
    
    var answers: [String] {
        let randomInt = Int.random(in: 0..<incorrect_answers.count)
        var answers = incorrect_answers
        answers.insert(correct_answer, at: randomInt)
        return answers
    }
    
    func checkAnswer(answer: String) -> Bool {
        answer == correct_answer ? true : false
    }
}
