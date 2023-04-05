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
    
    //MARK: - Helpers
    
    private func makeSUT() -> ResultsViewController {
        let sut = ResultsViewController()
        sut.loadViewIfNeeded()
        return sut
    }

}

