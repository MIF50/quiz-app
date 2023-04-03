//
//  Flow.swift
//  QuizEngine
//
//  Created by Mohamed Ibrahim on 03/04/2023.
//

import Foundation

public protocol Router {
    func routeTo(question: String,answerCallback: @escaping ((String) -> Void))
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
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let self else { return }
                
                let firstIndexQuestoin = questions.firstIndex(of: firstQuestion)!
                let nextQuestion = questions[firstIndexQuestoin + 1]
                router.routeTo(question: nextQuestion) { _ in }
            }
        }
    }
}
