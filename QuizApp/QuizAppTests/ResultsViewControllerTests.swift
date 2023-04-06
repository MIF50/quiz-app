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
    
    func test_viewDidLoad_withCorrectAnswer_configureCell() {
        let answer = makeAnswer(question: "Q1",answer: "A1",isCorrect: true)
        let sut = makeSUT(answers: [answer])
        
        let cell = sut.correctAnswerView(at: 0)
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionText,"Q1","questionText")
        XCTAssertEqual(cell?.answerText,"A1","answerText")
    }
    
    func test_viewDidLoad_withWrongAnswer_configureCell() {
        let answer = makeAnswer(question: "Q1",answer: "A1",wrongAnswer: "wrong",isCorrect: false)
        let sut = makeSUT(answers: [answer])
        
        let cell = sut.wrongAnswerView(at: 0)
        
        XCTAssertNotNil(cell,"WrongAnswerCell is nil")
        XCTAssertEqual(cell?.questionText,"Q1","questionText")
        XCTAssertEqual(cell?.correctAnswerText,"A1","correctAnswerText")
        XCTAssertEqual(cell?.wrongAnswerText, "wrong")
    }
    
    //MARK: - Helpers
    
    private func makeSUT(
        summary: String = "",
        answers: [PresentableAnswer] = []
    ) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary,answers: answers)
        sut.loadViewIfNeeded()
        return sut
    }
    
    var anyAnswer: PresentableAnswer {
        .init(question: "",answer: "",wrongAnswer: nil,isCorrect: false)
    }
    
    private func makeAnswer(
        question: String = "",
        answer: String = "",
        wrongAnswer: String? = nil,
        isCorrect: Bool
    ) -> PresentableAnswer {
        .init(question: question, answer: answer,wrongAnswer: wrongAnswer,isCorrect: isCorrect)
    }
}

private extension CorrectAnswerCell {
    
    var questionText: String? {
        questionLabel.text
    }
    
    var answerText: String? {
        answerLabel.text
    }
}

private extension WrongAnswerCell {
    
    var questionText: String? {
        questionLabel.text
    }
    
    var correctAnswerText: String? {
        correctAnswerLabel.text
    }
    
    var wrongAnswerText: String? {
        wrongAnswerLabel.text
    }
}

private extension ResultsViewController {
    
    var textHeader: String? {
        headerLabel.text
    }
    
    func wrongAnswerView(at row: Int) -> WrongAnswerCell? {
        return tableView.cell(at: 0,section: answerSection) as? WrongAnswerCell
    }
    
    func correctAnswerView(at row: Int) -> CorrectAnswerCell? {
        return tableView.cell(at: 0,section: answerSection) as? CorrectAnswerCell
    }
    
    var numberOfAnswers: Int {
        tableView.numberOfRows(inSection: answerSection)
    }
    
    private var answerSection: Int {
        0
    }
}
