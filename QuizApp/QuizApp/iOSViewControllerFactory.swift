//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 08/04/2023.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    func questionViewController(question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
        QuestionViewController()
    }
    
    func resultViewController(result: Result<Question<String>, String>) -> UIViewController {
        UIViewController()
    }
}
