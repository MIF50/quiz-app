//
//  QuestionViewControllerTests.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 04/04/2023.
//

import XCTest
import QuizApp

final class QuestionViewControllerTests: XCTestCase {
    
    func test_outlets_shouldBeConnected() {
        let sut = QuestionViewController(question: "")
        sut.loadView()
        
        XCTAssertNotNil(sut.headerLabel, "headerLabel")
    }

}

