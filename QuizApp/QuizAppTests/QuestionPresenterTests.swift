//
//  QuestionPresenterTests.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 13/05/2023.
//

import XCTest
@testable import QuizApp

final class QuestionPresenterTests: XCTestCase {
    
    let question1 = Question.singleAnswer("Q1")
    let questions2 = Question.multipleAnswer("Q2")

    func test_title_forFirstQuestion_formatesTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1,questions2],question: question1)
        
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion_formatesTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1,questions2],question: questions2)
        
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forUnexistenQuestion_isEmpty() {
        let sut = QuestionPresenter(questions: [],question: question1)
        
        XCTAssertEqual(sut.title, "")
    }
}

