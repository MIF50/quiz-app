//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 07/04/2023.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController,factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question<String>, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(question: question, answerCallback: answerCallback)
        show(viewController)
    }
    
    func routeTo(result: Result<Question<String>, String>) {
        let viewController = factory.resultViewController(result: result)
        show(viewController)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
