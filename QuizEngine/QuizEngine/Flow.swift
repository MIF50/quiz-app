//
//  Flow.swift
//  QuizEngine
//
//  Created by Mohamed Ibrahim on 03/04/2023.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question,answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}

public struct Result<Question: Hashable,Answer> {
    public let answers: [Question: Answer]
    public let score: Int
    
    public init(answers: [Question : Answer],score: Int) {
        self.answers = answers
        self.score = score
    }
}

public class Flow<Question,Answer,R: Router> where R.Question == Question, R.Answer == Answer {
    
    private var answers: [Question: Answer] = [:]
    
    private let questions: [Question]
    private let router: R
    private let scoring: ([Question: Answer]) -> Int
    
    public init(
        questions: [Question],
        router: R,
        scoring: @escaping ([Question: Answer]) -> Int
    ){
        self.questions = questions
        self.router = router
            self.scoring = scoring
    }
    
    public func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion,answerCallback: nextCallback(firstQuestion))
        } else {
            router.routeTo(result: result())
        }
    }
    
    private func nextCallback(_ question: Question) -> (Answer) -> Void {
        return { [weak self] answer in
            self?.routeNext(question, answer)
        }
    }
    
    private func routeNext(_ question: Question ,_ answer: Answer) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            answers[question] = answer
            
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion,answerCallback: nextCallback(nextQuestion))
            } else {
                router.routeTo(result: result())
            }
        }
    }
    
    private func result() -> Result<Question,Answer> {
        Result(answers: answers,score: scoring([:]))
    }
}
