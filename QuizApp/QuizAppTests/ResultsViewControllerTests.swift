//
//  ResultsViewControllerTests.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 06/04/2023.
//

import XCTest
import QuizApp

final class ResultsViewControllerTests: XCTestCase {

    func test_outlets_shouldBeConnected() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.headerLabel,"headerLabel")
    }
    
    func test_viewDidLoad_hasSummary() {
        let sut = makeSUT(summary: "a summary")
        
        XCTAssertEqual(sut.textHeader, "a summary")
    }
    
    //MARK: - Helpers
    
    private func makeSUT(summary: String = "") -> ResultsViewController {
        let sut = ResultsViewController(summary: summary)
        sut.loadViewIfNeeded()
        return sut
    }

}

private extension ResultsViewController {
    
    var textHeader: String? {
        headerLabel.text
    }
}

