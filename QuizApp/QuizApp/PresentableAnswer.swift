//
//  PresentableAnswer.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 06/04/2023.
//

import Foundation

public struct PresentableAnswer {
    public let question: String
    public let answer: String
    public let wrongAnswer: String?
    
    public init(question: String, answer: String, wrongAnswer: String?) {
        self.question = question
        self.answer = answer
        self.wrongAnswer = wrongAnswer
    }
    
    var isCorrect: Bool {
        wrongAnswer == nil
    }
}
