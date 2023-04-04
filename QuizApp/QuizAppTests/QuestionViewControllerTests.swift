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
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.headerLabel, "headerLabel")
    }
    
    func test_viewDidLoad_hasHeaderText() {
        let sut = QuestionViewController(question: "Q1")
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.textHeaderLabel, "Q1")
    }
}

private extension QuestionViewController {
    
    var textHeaderLabel: String? {
        headerLabel.text
    }
}

