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
    
    func questionViewController(question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
        QuestionViewController(question: "", options: options[question]!) { _ in }
    }
    
    func resultViewController(result: Result<Question<String>, String>) -> UIViewController {
        UIViewController()
    }
}
