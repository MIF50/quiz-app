//
//  ResultsPreseterTests.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 09/04/2023.
//

import XCTest
import QuizEngine
@testable import QuizApp

final class ResultsPreseterTests: XCTestCase {

    func test_summary_withQuestionAndScoreOne_returnsSummary() {
        let answers = [Question.singleAnswer("Q1"): ["A1"],Question.multipleAnswer("Q2"): ["A2"]]
        let result = Result(answers: answers, score: 1)
        let sut = ResultsPresenter(result: result,correctAnswer: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withQuestion_isEmpty() {
        let answers = [Question<String>: [String]]()
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result,correctAnswer: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswers() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswer = [Question.singleAnswer("Q1"): ["A2"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result,correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count,1)
        XCTAssertEqual(sut.presentableAnswers.first?.question,"Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer,"A2")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer,"A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswers() {
        let answers = [Question.multipleAnswer("Q1"): ["A1","A4"]]
        let correctAnswer = [Question.multipleAnswer("Q1"): ["A2","A3"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result,correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count,1)
        XCTAssertEqual(sut.presentableAnswers.first?.question,"Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer,"A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer,"A1, A4")
    }
    
    func test_presentableAnswers_withRightSingleAnswer_mapsAnswers() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswer = [Question.singleAnswer("Q1"): ["A1"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result,correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count,1)
        XCTAssertEqual(sut.presentableAnswers.first?.question,"Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer,"A1")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer,nil)
    }
    
    func test_presentableAnswers_withRightMultipleAnswer_mapsAnswers() {
        let answers = [Question.multipleAnswer("Q1"): ["A2","A3"]]
        let correctAnswer = [Question.multipleAnswer("Q1"): ["A2","A3"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result,correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count,1)
        XCTAssertEqual(sut.presentableAnswers.first?.question,"Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer,"A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer,nil)
    }
}

