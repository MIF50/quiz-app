//
//  Flow.swift
//  QuizEngine
//
//  Created by Mohamed Ibrahim on 03/04/2023.
//

import Foundation

public protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String,answerCallback: @escaping AnswerCallback)
}

public class Flow {
    
    private let questions: [String]
    private let router: Router
    
    public init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    public func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion,answerCallback: routeNext(firstQuestion))
        }
    }
    
    private func routeNext(_ question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let self else { return }
            
            if let currentQuestionIndex = questions.firstIndex(of: question) {
                if currentQuestionIndex + 1 < questions.count {
                    let nextQuestion = questions[currentQuestionIndex + 1]
                    router.routeTo(question: nextQuestion,answerCallback: routeNext(nextQuestion))
                }
            }
        }
    }
}
