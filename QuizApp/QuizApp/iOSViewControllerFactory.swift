//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 08/04/2023.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    
    private let questions: [Question<String>]
    private let options: [Question<String>: [String]]
    
    init(questions: [Question<String>],options: [Question<String> : [String]]) {
        self.questions = questions
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
            return questionController(
                for: question,
                value: value,
                options: options,
                answerCallback: answerCallback,
                allowsMultipleSelection: false
            )
        case let .multipleAnswer(value):
            return questionController(
                for: question,
                value: value,
                options: options,
                answerCallback: answerCallback,
                allowsMultipleSelection: true
            )
        }
    }
    
    private func questionController(
        for question: Question<String>,
        value: String,
        options: [String],
        answerCallback: @escaping ([String]) -> Void,
        allowsMultipleSelection: Bool
    ) -> QuestionViewController {
        let presenter = QuestionPresenter(questions: questions,question: question)
        let controller = QuestionViewController(
            question: value,
            options: options,
            selection: answerCallback,
            allowsMultipleSelection: allowsMultipleSelection
        )
        controller.title = presenter.title
        return controller
    }
    
    func resultViewController(result: Result<Question<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}
