//
//  GameTests.swift
//  QuizEngineTests
//
//  Created by Mohamed Ibrahim on 07/04/2023.
//

import XCTest
import QuizEngine

final class GameTests: XCTestCase {
    
    let router = RouterSpy()
    var sut: SUT!

    override func setUp() {
        super.setUp()
        sut = startGame(
            questions: ["Q1","Q2"],
            router: router,
            correctAnswers: ["Q1": "A1","Q2": "A2"]
        )
    }
    
    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        router.answer("wrong",at: 0)
        router.answer("wrong",at: 1)
        
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
        router.answer("A1",at: 0)
        router.answer("wrong",at: 1)
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    func test_startGame_answerTwoOutOfTwoCorrectly_scoresTwo() {
        router.answer("A1",at: 0)
        router.answer("A2",at: 1)
        
        XCTAssertEqual(router.routedResult!.score, 2)
    }
    
    //MARK: - Helpers
    
    typealias SUT = Game<String,String,RouterSpy>
}

