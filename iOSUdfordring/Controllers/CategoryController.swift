//
//  QuizController.swift
//  iOSUdfordring
//
//  Created by dmu mac 26 on 09/10/2023.
//

import Foundation

class CategoryController: ObservableObject{
    @Published var categories: [Category] = []
    private var categoryCounts: [CategoryCount] = []
    
    init() {
        guard let categoriesURL = URL(string: "https://opentdb.com/api_category.php") else {return}
        fetchCategories(from: categoriesURL)
        
    }
    
    func getQuestionCount(categoryid : Int) -> Int {
        var questionCount = 0
        for c in categoryCounts {
            if c.category_id == categoryid {
                questionCount = c.category_question_count.total_question_count
            }
        }
        return questionCount
    }
    
    private func fetchCategories(from url: URL) {
        Task(priority: .low) {
            guard let rawCategoryData = await NetworkServices.getData(from: url) else {return}
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(Categories.self, from: rawCategoryData)
                Task.detached { @MainActor in
                    self.categories = result.trivia_categories
                    for c in self.categories {
                        guard let countURL = URL(string: "https://opentdb.com/api_count.php?category=\(c.id)") else {return}
                        self.fetchCategoryCount(from: countURL)
                    }                }
            } catch {
                fatalError("Konvertering fra JSON gik ad h til")
            }
        }
    }
    
    private func fetchCategoryCount(from url: URL) {
        Task(priority: .low) {
            guard let rawCategoryData = await NetworkServices.getData(from: url) else {return}
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(CategoryCount.self, from: rawCategoryData)
                Task.detached { @MainActor in
                    self.categoryCounts.append(result)
                }
            } catch {
                fatalError("Konvertering fra JSON gik ad h til")
            }
        }    }
}
