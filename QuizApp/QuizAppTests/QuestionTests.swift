//
//  QuestionTests.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 08/04/2023.
//

import XCTest
@testable import QuizApp

final class QuestionTests: XCTestCase {

    func test_hashValue_singleAnswer_returnsTypeHash() {
        let type = "any string"
        
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_hashValue_multipleAnswer_returnsTypeHash() {
        let type = "any string"
        
        let sut = Question.multipleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_equal_isEqual() {
        XCTAssertEqual(Question.singleAnswer("any string"), Question.singleAnswer("any string"))
        XCTAssertEqual(Question.multipleAnswer("any string"), Question.multipleAnswer("any string"))
    }
    
    func test_notEqual_isNotEqual() {
        XCTAssertNotEqual(Question.singleAnswer("any string"), Question.singleAnswer("anthor string"))
        XCTAssertNotEqual(Question.multipleAnswer("any string"), Question.multipleAnswer("anthor string"))
        XCTAssertNotEqual(Question.singleAnswer("any string"), Question.multipleAnswer("any string"))
    }
}

