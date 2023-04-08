//
//  NavigationControllerRouterTests.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 07/04/2023.
//

import XCTest
import UIKit
import QuizEngine
@testable import QuizApp

final class NavigationControllerRouterTests: XCTestCase {
    
    func test_routeToQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        let navigationController = NonAnimationNavigationController()
        let (sut, factory) = makeSUT(naviagtionController: navigationController)
        factory.stub(question: Question.singleAnswer("Q1"),with: viewController)
        factory.stub(question: Question.singleAnswer("Q2"),with: secondViewController)
        
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToSecondQuestion_presentsQuestionControllerWithRightCallback() {
        let (sut, factory) = makeSUT()
        
        var firedCallback = false
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in
            firedCallback = true
        })
        factory.answer(Question.singleAnswer("Q1"),answer: "anything")
        
        XCTAssertEqual(firedCallback, true)
    }
    
    func test_routesToResults_showsResultViewController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        let navigationController = NonAnimationNavigationController()
        let (sut, factory) = makeSUT(naviagtionController: navigationController)
        let firstResult = Result(answers: [Question.singleAnswer("Q1"): "A1"], score: 10)
        let secondResult = Result(answers: [Question.singleAnswer("Q2"): "A2"], score: 20)

        factory.stub(result: firstResult,with: viewController)
        factory.stub(result: secondResult,with: secondViewController)
        
        sut.routeTo(result: firstResult)
        sut.routeTo(result: secondResult)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        naviagtionController: UINavigationController = UINavigationController()
    ) -> (sut: NavigationControllerRouter,factory: ViewControllerFactoryStub) {
        let factory = ViewControllerFactoryStub()
        let sut = NavigationControllerRouter(naviagtionController,factory: factory)
        return (sut, factory)
    }
    
    private class NonAnimationNavigationController: UINavigationController {
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    private class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResults = [Result<Question<String>, String> : UIViewController]()
        private var answerCallback = [Question<String>: ((String) -> Void)]()
        
        func stub(question: Question<String>, with viewControler: UIViewController) {
            stubbedQuestions[question] = viewControler
        }
        
        func stub(result: Result<Question<String>, String>, with viewControler: UIViewController) {
            stubbedResults[result] = viewControler
        }
        
        func questionViewController(
            question: Question<String>,
            answerCallback: @escaping (String) -> Void
        ) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func resultViewController(result: Result<Question<String>, String>) -> UIViewController {
            return stubbedResults[result] ?? UIViewController()
        }
        
        func answer(_ question: Question<String>,answer: String) {
            answerCallback[question]?(answer)
        }
    }
}


extension Result: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
    
    public static func == (lhs: QuizEngine.Result<Question, Answer>, rhs: QuizEngine.Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}

