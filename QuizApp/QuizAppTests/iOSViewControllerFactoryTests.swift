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
        let options = ["A1"]
        let question = Question.singleAnswer("Q1")
        let sut = iOSViewControllerFactory(options: [question: options])
        
        let controller = sut.questionViewController(question: Question.singleAnswer("Q1"),answerCallback: { _ in }) as? QuestionViewController

        XCTAssertNotNil(controller)
    }
    
    func test_questionViewController_createsControllerWithOptions() {
        let options = ["A1"]
        let question = Question.singleAnswer("Q1")
        let sut = iOSViewControllerFactory(options: [question: options])
        
        let controller = sut.questionViewController(question: Question.singleAnswer("Q1"),answerCallback: { _ in }) as? QuestionViewController

        XCTAssertEqual(controller?.options,options)
    }
}
