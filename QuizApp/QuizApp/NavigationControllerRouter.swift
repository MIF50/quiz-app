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
    
    func routeTo(question: Question<String>, answerCallback: @escaping ([String]) -> Void) {
        switch question {
        case .singleAnswer:
            let viewController = factory.questionViewController(question: question, answerCallback: answerCallback)
            show(viewController)
        case .multipleAnswer:
            let button = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
            let buttonController = SubmitButtonController(button, answerCallback)
            let viewController = factory.questionViewController(question: question, answerCallback: { selection in
                buttonController.update(selection)
            })
            viewController.navigationItem.rightBarButtonItem = button
            show(viewController)
        }
    
    }
    
    func routeTo(result: Result<Question<String>, [String]>) {
        let viewController = factory.resultViewController(result: result)
        show(viewController)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}

private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callback: (([String]) -> Void)
    private var model: [String] = []
    
    init(_ button: UIBarButtonItem, _ callback: @escaping ([String]) -> Void) {
        self.button = button
        self.callback = callback
        super.init()
        self.setup()
    }
    
    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
        updateButtonState()
    }
    
    func update(_ model: [String]) {
        self.model = model
        updateButtonState()
    }
    
    @objc private func fireCallback() {
        callback(model)
    }
    
    private func updateButtonState() {
        button.isEnabled = model.count > 0
    }
}
