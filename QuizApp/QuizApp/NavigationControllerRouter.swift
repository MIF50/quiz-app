//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 07/04/2023.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(question: String,answerCallback: @escaping (String) -> Void) -> UIViewController
}

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController,factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: String,answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(question: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func routeTo(result: Result<String, String>) {
        
    }
}