//
//  CategoryModel.swift
//  iOSUdfordring
//
//  Created by dmu mac 26 on 09/10/2023.
//

import Foundation

struct Categories: Decodable {
    let trivia_categories: [Category]
}


struct Category: Decodable, Identifiable {
    let name: String
    let id: Int

}

enum Difficulty: String {
    case Easy = "easy",
         Medium = "medium",
         Hard = "hard"
}

struct CategoryCount: Decodable {
    let category_id: Int
    let category_question_count: QuestionCount
}

struct QuestionCount: Decodable {
    let total_question_count: Int
}

