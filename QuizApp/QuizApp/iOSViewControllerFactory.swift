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
        
        return questionViewController(for: question, options: options, answerCallback: answerCallback)
    }
    
    private func questionViewController(
        for question: Question<String>,
        options: [String],
        answerCallback: @escaping ([String]) -> Void
    ) -> QuestionViewController{
        switch question {
        case let .singleAnswer(value):
            let controller = QuestionViewController(question: value, options: options,selection: answerCallback)
            controller.title = "Question #1"
            return controller
        case let .multipleAnswer(value):
            let viewController = QuestionViewController(question: value, options: options,selection: answerCallback)
            viewController.loadViewIfNeeded()
            viewController.tableView.allowsMultipleSelection = true
            return viewController
        }
    }
    
    func resultViewController(result: Result<Question<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}
