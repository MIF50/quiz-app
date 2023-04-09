//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 09/04/2023.
//

import Foundation
import QuizEngine

struct ResultsPresenter {
    
    private let result: Result<Question<String>,[String]>
    private let correctAnswer: [Question<String>: [String]]
    
    init(
        result: Result<Question<String>, [String]>,
        correctAnswer: [Question<String>: [String]]
    ) {
        self.result = result
        self.correctAnswer = correctAnswer
    }
    
    var summary: String {
        "You got \(result.score)/\(result.answers.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        result.answers.map { question,userAnswer in
            guard let correctAnswer = correctAnswer[question] else {
                fatalError("Couldn't find correct answer for question \(question)")
            }
            return presentableAnswer(question, userAnswer, correctAnswer)
        }
    }
    
    private func presentableAnswer(
        _ question: Question<String>,
        _ userAnswer: [String],
        _ correctAnswer: [String]
    ) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(
                question: value,
                answer: formattedAnswer(correctAnswer),
                wrongAnswer: formattedWrongAnswer(userAnswer, correctAnswer)
            )
        }
    }
    
    private func formattedAnswer(_ answer: [String]) -> String {
        answer.joined(separator: ", ")
    }
    
    private func formattedWrongAnswer(
        _ userAnswer: [String],
        _ correctAnswer: [String]
    ) -> String? {
        correctAnswer == userAnswer ? nil : formattedAnswer(userAnswer)
    }
    
}

