//
//  NavigationControllerRouterTests.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 07/04/2023.
//

import XCTest
import UIKit
@testable import QuizApp

final class NavigationControllerRouterTests: XCTestCase {
    
    func test_routeToQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        let navigationController = UINavigationController()
        let (sut, factory) = makeSUT(naviagtionController: navigationController)
        factory.stub(question: "Q1",with: viewController)
        factory.stub(question: "Q2",with: secondViewController)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToSecondQuestion_presentsQuestionControllerWithRightCallback() {
        let (sut, factory) = makeSUT()
        
        var firedCallback = false
        sut.routeTo(question: "Q1", answerCallback: { _ in
            firedCallback = true
        })
        factory.answer("Q1",answer: "anything")
        
        XCTAssertEqual(firedCallback, true)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        naviagtionController: UINavigationController = UINavigationController()
    ) -> (sut: NavigationControllerRouter,factory: ViewControllerFactoryStub) {
        let factory = ViewControllerFactoryStub()
        let sut = NavigationControllerRouter(naviagtionController,factory: factory)
        return (sut, factory)
    }

    
    private class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [String: UIViewController]()
        private var answerCallback = [String: ((String) -> Void)]()
        
        func stub(question: String, with viewControler: UIViewController) {
            stubbedQuestions[question] = viewControler
        }
        
        func questionViewController(
            question: String,
            answerCallback: @escaping (String) -> Void
        ) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func answer(_ question: String,answer: String) {
            answerCallback[question]?(answer)
        }
    }
}

