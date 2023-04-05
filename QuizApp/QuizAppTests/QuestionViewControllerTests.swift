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
    
    func test_tableView_delegate_shouldBeConnected() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.tableView.dataSource,"dataSource")
        XCTAssertNotNil(sut.tableView.delegate,"delegate")
    }
    
    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT(options: []).numberOfOptions, 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).numberOfOptions, 1)
        XCTAssertEqual(makeSUT(options: ["A1","A2"]).numberOfOptions, 2)
    }
    
    func test_viewDidLoad_rendersOptionsText() {
        let sut = makeSUT(options: ["A1","A2"])
        
        let title0 = sut.title(at: 0)
        XCTAssertEqual(title0,"A1")
        
        let title1 = sut.title(at: 1)
        XCTAssertEqual(title1,"A2")
    }
    
    func test_optionSelected_notifiesSelection() {
        var receivedAnswer = ""
        let sut = makeSUT(options: ["A1","A2"]) { answer in
            receivedAnswer = answer
        }
        
        sut.simuateOptionSelection(at: 0)
        XCTAssertEqual(receivedAnswer, "A1")
        
        sut.simuateOptionSelection(at: 1)
        XCTAssertEqual(receivedAnswer, "A2")
    }
    
    //MARK: - Helpers
    
    private func makeSUT(
        question: String = "",
        options: [String] = [],
        selection: @escaping (String) -> Void = { _ in }
    ) -> QuestionViewController {
        let sut = QuestionViewController(question: question,options: options,selection: selection)
        sut.loadViewIfNeeded()
        return sut
    }

}

private extension QuestionViewController {
    
    var textHeaderLabel: String? {
        headerLabel.text
    }
    
    func simuateOptionSelection(at row: Int) {
        tableView.didSelect(at: row,section: optionsSection)
    }
    
    func optionView(at row: Int) -> UITableViewCell? {
        tableView.cell(at: row,section: optionsSection)
    }
    
    func title(at row: Int) -> String? {
        optionView(at: row)?.textLabel?.text
    }
    
    var numberOfOptions: Int {
        tableView.numberOfRows(inSection: optionsSection)
    }
    
    private var optionsSection: Int {
        0
    }
}

private extension UITableView {
    
    func cell(at row: Int, section: Int = 0) -> UITableViewCell? {
        let index = IndexPath(row: row, section: section)
        return dataSource?.tableView(self, cellForRowAt: index)
    }
    
    func didSelect(at row: Int,section: Int = 0) {
        let index = IndexPath(row: row, section: section)
        delegate?.tableView?(self, didSelectRowAt: index)
    }
}

