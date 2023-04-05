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
        XCTAssertNotNil(sut.tableView,"tableView")
    }
    
    func test_viewDidLoad_hasSummary() {
        let sut = makeSUT(summary: "a summary")
        
        XCTAssertEqual(sut.textHeader, "a summary")
    }
    
    func test_tableView_delegate_shouldBeConnected() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.tableView.dataSource,"dataSource")
    }
    
    func test_viewDidLoad_rendersAnswer() {
        XCTAssertEqual(makeSUT(answers: []).numberOfAnswers, 0)
        XCTAssertEqual(makeSUT(answers: [anyAnswer]).numberOfAnswers, 1)
        XCTAssertEqual(makeSUT(answers: [anyAnswer,anyAnswer]).numberOfAnswers, 2)
    }
    
    //MARK: - Helpers
    
    private func makeSUT(
        summary: String = "",
        answers: [String] = []
    ) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary,answers: answers)
        sut.loadViewIfNeeded()
        return sut
    }
    
    var anyAnswer: String {
        "any answer"
    }
}

private extension ResultsViewController {
    
    var textHeader: String? {
        headerLabel.text
    }
    
    var numberOfAnswers: Int {
        tableView.numberOfRows(inSection: answerSection)
    }
    
    private var answerSection: Int {
        0
    }
}

