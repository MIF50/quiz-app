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
        let sut = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.headerLabel, "headerLabel")
        XCTAssertNotNil(sut.tableView,"tableView")
    }
    
    func test_viewDidLoad_hasHeaderText() {
        let sut = makeSUT(question: "Q1")
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.textHeaderLabel, "Q1")
    }
    
    //MARK: - Helpers
    
    private func makeSUT(question: String = "",options: [String] = []) -> QuestionViewController {
        let sut = QuestionViewController(question: question,options: options)
        return sut
    }

}

private extension QuestionViewController {
    
    var textHeaderLabel: String? {
        headerLabel.text
    }
}

