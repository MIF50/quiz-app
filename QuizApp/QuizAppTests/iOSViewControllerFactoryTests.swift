//
//  iOSViewControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 08/04/2023.
//

import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTests: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")

    
    func test_questionViewController_singleAnswer_createsControllerWithTitle() {
        let sut = makeSUT(question: singleAnswerQuestion, options: [])
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion,multipleAnswerQuestion], question: singleAnswerQuestion)
        let controller = makeQuestionController(sut: sut, question: singleAnswerQuestion)
        
        XCTAssertEqual(controller.title,presenter.title)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        let options = ["A1"]
        let sut = makeSUT(question: singleAnswerQuestion, options: options)
        
        let controller = makeQuestionController(sut: sut, question: singleAnswerQuestion)
        
        XCTAssertEqual(controller.question,"Q1")
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        let options = ["A1"]
        let sut = makeSUT(question: singleAnswerQuestion, options: options)
        
        let controller = makeQuestionController(sut: sut, question: singleAnswerQuestion)
        
        XCTAssertEqual(controller.options,options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        let options = ["A1"]
        let sut = makeSUT(question: singleAnswerQuestion, options: options)
        
        let controller = makeQuestionController(sut: sut, question: singleAnswerQuestion)
        
        XCTAssertEqual(controller.tableView.allowsMultipleSelection, false)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithTitle() {
        let sut = makeSUT(question: multipleAnswerQuestion, options: [])
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion,multipleAnswerQuestion], question: multipleAnswerQuestion)
        let controller = makeQuestionController(sut: sut, question: multipleAnswerQuestion)
        
        XCTAssertEqual(controller.title,presenter.title)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {
        let options = ["A1"]
        let sut = makeSUT(question: multipleAnswerQuestion, options: options)
        
        let controller = makeQuestionController(sut: sut, question: multipleAnswerQuestion)
        
        XCTAssertEqual(controller.question,"Q2")
    }
    
    func test_questionViewController_mutlipleAnswer_createsControllerWithOptions() {
        let options = ["A1"]
        let sut = makeSUT(question: multipleAnswerQuestion, options: options)
        
        let controller = makeQuestionController(sut: sut, question: multipleAnswerQuestion)
        
        XCTAssertEqual(controller.options,options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithMultipleSelection() {
        let options = ["A1"]
        let sut = makeSUT(question: multipleAnswerQuestion, options: options)
        
        let controller = makeQuestionController(sut: sut, question: multipleAnswerQuestion)
        
        XCTAssertEqual(controller.tableView.allowsMultipleSelection, true)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        question: Question<String>,
        options: [String]
    ) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleAnswerQuestion,multipleAnswerQuestion],options: [question: options])
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
