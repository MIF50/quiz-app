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
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.singleAnswer("Q2")

    func test_summary_withQuestionAndScoreOne_returnsSummary() {
        let answers = [singleAnswerQuestion: ["A1"],multipleAnswerQuestion: ["A2"]]
        let result = Result(answers: answers, score: 1)
        let orderQuestions = [singleAnswerQuestion,multipleAnswerQuestion]
        
        let sut = ResultsPresenter(result: result,questions: orderQuestions,correctAnswer: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withQuestion_isEmpty() {
        let answers = [Question<String>: [String]]()
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result,questions: [],correctAnswer: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswers() {
        let answers = [singleAnswerQuestion: ["A1"]]
        let correctAnswer = [singleAnswerQuestion: ["A2"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result,questions: [singleAnswerQuestion],correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count,1)
        XCTAssertEqual(sut.presentableAnswers.first?.question,"Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer,"A2")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer,"A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswers() {
        let answers = [multipleAnswerQuestion: ["A1","A4"]]
        let correctAnswer = [multipleAnswerQuestion: ["A2","A3"]]
        let result = Result(answers: answers, score: 0)
        let sut = ResultsPresenter(result: result,questions: [multipleAnswerQuestion],correctAnswer: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.count,1)
        XCTAssertEqual(sut.presentableAnswers.first?.question,"Q2")
        XCTAssertEqual(sut.presentableAnswers.first?.answer,"A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer,"A1, A4")
    }
    
    func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswers() {
        let answers = [multipleAnswerQuestion: ["A2","A3"],singleAnswerQuestion: ["A2"]]
        let correctAnswer = [multipleAnswerQuestion: ["A2","A3"],singleAnswerQuestion: ["A2"]]
        let orderedQuestions = [singleAnswerQuestion,multipleAnswerQuestion]
        let result = Result(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result,questions: orderedQuestions,correctAnswer: correctAnswer)

        XCTAssertEqual(sut.presentableAnswers.count,2)
        XCTAssertEqual(sut.presentableAnswers.first?.question,"Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer,"A2")
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)

        XCTAssertEqual(sut.presentableAnswers.last?.question,"Q2")
        XCTAssertEqual(sut.presentableAnswers.last?.answer,"A2, A3")
        XCTAssertNil(sut.presentableAnswers.last?.wrongAnswer)
    }
}

