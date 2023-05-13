//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 13/05/2023.
//

import Foundation

struct QuestionPresenter {
    private let questions: [Question<String>]
    private let question: Question<String>
    
    init(questions: [Question<String>], question: Question<String>) {
        self.questions = questions
        self.question = question
    }
    
    var title: String {
        guard let index = questions.firstIndex(of: question) else { return "" }
        return "Question #\(index + 1)"
    }
}
