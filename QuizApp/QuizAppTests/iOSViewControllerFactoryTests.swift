//
//  iOSViewControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 08/04/2023.
//

import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTests: XCTestCase {

    func test_questionViewController_createsController() {
        let sut = iOSViewControllerFactory()
        
        let controller = sut.questionViewController(question: Question.singleAnswer("Q1"),answerCallback: { _ in }) as? QuestionViewController

        XCTAssertNotNil(controller)
    }
}
