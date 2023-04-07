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
        let naviagtionController = UINavigationController()
        let sut = NavigationControllerRouter(naviagtionController)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        
        XCTAssertEqual(naviagtionController.viewControllers.count, 1)
    }
    
    func test_routeToQuestionTwice_presentsQuestionControllerTwice() {
        let naviagtionController = UINavigationController()
        let sut = NavigationControllerRouter(naviagtionController)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        
        XCTAssertEqual(naviagtionController.viewControllers.count, 2)
    }
}

