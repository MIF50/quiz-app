//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 08/04/2023.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    
    private let options: [Question<String>: [String]]
    
    init(options: [Question<String> : [String]]) {
        self.options = options
    }
    
    func questionViewController(question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = options[question] else {
            fatalError("Couldn't options for question \(question)")
        }
        
        switch question {
        case let .singleAnswer(value):
            return QuestionViewController(question: value, options: options) { _ in }
        default:
            return UIViewController()
        }
    }
    
    func resultViewController(result: Result<Question<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}