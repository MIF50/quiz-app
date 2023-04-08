//
//  iOSViewControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 08/04/2023.
//

import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTests: XCTestCase {
    
    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        let options = ["A1"]
        let question = Question.singleAnswer("Q1")
        let sut = makeSUT(question: question, options: options)
        
        let controller = makeQuestionController(sut: sut, question: question)
        
        XCTAssertEqual(controller.question,"Q1")
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        let options = ["A1"]
        let question = Question.singleAnswer("Q1")
        let sut = makeSUT(question: question, options: options)
        
        let controller = makeQuestionController(sut: sut, question: question)
        
        XCTAssertEqual(controller.options,options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        let options = ["A1"]
        let question = Question.singleAnswer("Q1")
        let sut = makeSUT(question: question, options: options)
        
        let controller = makeQuestionController(sut: sut, question: question)
        
        XCTAssertEqual(controller.tableView.allowsMultipleSelection, false)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {
        let options = ["A1"]
        let question = Question.multipleAnswer("Q1")
        let sut = makeSUT(question: question, options: options)
        
        let controller = makeQuestionController(sut: sut, question: question)
        
        XCTAssertEqual(controller.question,"Q1")
    }
    
    func test_questionViewController_mutlipleAnswer_createsControllerWithOptions() {
        let options = ["A1"]
        let question = Question.multipleAnswer("Q1")
        let sut = makeSUT(question: question, options: options)
        
        let controller = makeQuestionController(sut: sut, question: question)
        
        XCTAssertEqual(controller.options,options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithMultipleSelection() {
        let options = ["A1"]
        let question = Question.multipleAnswer("Q1")
        let sut = makeSUT(question: question, options: options)
        
        let controller = makeQuestionController(sut: sut, question: question)
        
        XCTAssertEqual(controller.tableView.allowsMultipleSelection, true)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        question: Question<String>,
        options: [String]
    ) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: [question: options])
    }
    
    private func makeQuestionController(
        sut: iOSViewControllerFactory,
        question: Question<String>
    ) -> QuestionViewController {
        let controller = sut.questionViewController(question: question,answerCallback: { _ in }) as! QuestionViewController
        controller.loadViewIfNeeded()
        return controller
    }
}
