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
    
    func test_routeToQuestion_presentsQuestionController() {
        let viewController = UIViewController()
        let factory = ViewControllerFactoryStub()
        factory.stub(question: "Q1",with: viewController)
        let naviagtionController = UINavigationController()
        let sut = NavigationControllerRouter(naviagtionController,factory: factory)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        
        XCTAssertEqual(naviagtionController.viewControllers.count, 1)
        XCTAssertEqual(naviagtionController.viewControllers.first, viewController)
    }
    
    func test_routeToSecondQuestion_presentsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        let factory = ViewControllerFactoryStub()
        factory.stub(question: "Q1",with: viewController)
        factory.stub(question: "Q2",with: secondViewController)

        let naviagtionController = UINavigationController()
        let sut = NavigationControllerRouter(naviagtionController,factory: factory)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })
        
        XCTAssertEqual(naviagtionController.viewControllers.count, 2)
        XCTAssertEqual(naviagtionController.viewControllers.first, viewController)
        XCTAssertEqual(naviagtionController.viewControllers.last, secondViewController)
    }
    
    // MARK: - Helpers
    
    private class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [String: UIViewController]()
        
        func stub(question: String, with viewControler: UIViewController) {
            stubbedQuestions[question] = viewControler
        }
        
        func questionViewController(
            question: String,
            answerCallback: @escaping (String) -> Void
        ) -> UIViewController {
            return stubbedQuestions[question]!
        }
    }
}

