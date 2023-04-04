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
        
        XCTAssertNotNil(sut.headerLabel, "headerLabel")
        XCTAssertNotNil(sut.tableView,"tableView")
    }
    
    func test_viewDidLoad_hasHeaderText() {
        let sut = makeSUT(question: "Q1")
        
        XCTAssertEqual(sut.textHeaderLabel, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersZeroOptions() {
        let sut = makeSUT(options: [])
        
        XCTAssertEqual(sut.numberOfOptions, 0)
    }
    
    func test_tableView_delegate_shouldBeConnected() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.tableView.dataSource,"dataSource")
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOption() {
        let sut = makeSUT(options: ["A1"])
        
        XCTAssertEqual(sut.numberOfOptions, 1)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOptionText() {
        let sut = makeSUT(options: ["A1"])
        
        let cell = sut.optionView(at: 0)
        
        XCTAssertEqual(cell?.textLabel?.text,"A1")
    }
    
    //MARK: - Helpers
    
    private func makeSUT(question: String = "",options: [String] = []) -> QuestionViewController {
        let sut = QuestionViewController(question: question,options: options)
        sut.loadViewIfNeeded()
        return sut
    }

}

private extension QuestionViewController {
    
    var textHeaderLabel: String? {
        headerLabel.text
    }
    
    func optionView(at row: Int) -> UITableViewCell? {
        let index = IndexPath(row: row, section: optionsSection)
        return tableView.dataSource?.tableView(tableView, cellForRowAt: index)
    }
    
    var numberOfOptions: Int {
        tableView.numberOfRows(inSection: optionsSection)
    }
    
    private var optionsSection: Int {
        0
    }
}

