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
    
    func test_viewDidLoad_withSingleSelection_configuresTableView() {
        let sut = makeSUT(options: ["A1","A2"],allowsMultipleSelection: false)
        
        XCTAssertFalse(sut.tableView.allowsMultipleSelection)
    }
    
    func test_viewDidLoad_withMultipleSelection_configuresTableView() {
        let sut = makeSUT(options: ["A1","A2"],allowsMultipleSelection: true)
        
        XCTAssertTrue(sut.tableView.allowsMultipleSelection)
    }
    
    func test_optionSelected_withSingleSelection_notifiesSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"],allowsMultipleSelection: false) { receivedAnswer = $0 }
        
        sut.simuateOptionSelect(at: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.simuateOptionSelect(at: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifySelection() {
        var selectionCallCount = 0
        let sut = makeSUT(options: ["A1","A2"],allowsMultipleSelection: false) { _ in selectionCallCount += 1 }
        
        sut.simuateOptionSelect(at: 0)
        XCTAssertEqual(selectionCallCount, 1)

        sut.simuateOptionDeselect(at: 0)
        XCTAssertEqual(selectionCallCount, 1)
    }
    
    func test_optionSelected_withEnabledMultipleSelection_notifiesSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"],allowsMultipleSelection: true) { receivedAnswer = $0 }
        
        sut.simuateOptionSelect(at: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.simuateOptionSelect(at: 1)
        XCTAssertEqual(receivedAnswer, ["A1","A2"])
    }
    
    func test_optionDeselected_withEnabledMultipleSelection_notifiesDelegate() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1","A2"],allowsMultipleSelection: true) { receivedAnswer = $0 }
        
        sut.simuateOptionSelect(at: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.simuateOptionDeselect(at: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    //MARK: - Helpers
    
    private func makeSUT(
        question: String = "",
        options: [String] = [],
        allowsMultipleSelection: Bool = false,
        selection: @escaping ([String]) -> Void = { _ in }
    ) -> QuestionViewController {
        let sut = QuestionViewController(
            question: question,
            options: options,
            selection: selection,
            allowsMultipleSelection: allowsMultipleSelection
        )
        sut.loadViewIfNeeded()
        return sut
    }

}

private extension QuestionViewController {
    
    var textHeaderLabel: String? {
        headerLabel.text
    }
    
    func simuateOptionSelect(at row: Int) {
        tableView.select(at: row,section: optionsSection)
    }
    
    func simuateOptionDeselect(at row: Int) {
        tableView.deselect(at: row,section: optionsSection)
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
