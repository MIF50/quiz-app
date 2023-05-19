//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 04/04/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = makeResultsViewController()
        
        window?.makeKeyAndVisible()
    }
    
    private func makeQuestionViewController() -> QuestionViewController {
        let vc = QuestionViewController(question: "A Question?", options: ["Option 1","Option 2","Option 3"], selection: {
            print($0)
        },allowsMultipleSelection: true)
        vc.loadViewIfNeeded()
        return vc
    }
    
    private func makeResultsViewController() -> ResultsViewController {
        let answers = [
            PresentableAnswer(question: "Question 1?", answer: "correct", wrongAnswer: nil),
            PresentableAnswer(question: "Question 2?", answer: "unknow", wrongAnswer: "wrong")
        ]
        let vc = ResultsViewController(summary: "You got 1/2", answers: answers)
        vc.loadViewIfNeeded()
        vc.tableView.allowsMultipleSelection = true
        return vc
    }
}

