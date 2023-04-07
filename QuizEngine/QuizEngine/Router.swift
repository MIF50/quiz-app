//
//  Router.swift
//  QuizEngine
//
//  Created by Mohamed Ibrahim on 07/04/2023.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question,answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}
