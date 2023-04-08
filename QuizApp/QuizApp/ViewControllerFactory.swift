//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 08/04/2023.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(question: Question<String>,answerCallback: @escaping (String) -> Void) -> UIViewController
    func resultViewController(result: Result<Question<String>, String>) -> UIViewController
}
