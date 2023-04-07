//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Mohamed Ibrahim on 07/04/2023.
//

import Foundation
import QuizEngine

class RouterSpy: Router {
    
    var routedQuestions = [String]()
    var routedResult: Result<String,String>? = nil
    private var answers = [(String) -> Void]()
    
    func routeTo(question: String,answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        answers.append(answerCallback)
    }
    
    func answer(_ answered: String,at index: Int = 0) {
        answers[index](answered)
    }
    
    func routeTo(result: Result<String, String>) {
        routedResult = result
    }
}
