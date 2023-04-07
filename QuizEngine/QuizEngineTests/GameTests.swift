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
    var game: Game<String,String,RouterSpy>!
    
    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        game = startGame(
            questions: ["Q1","Q2"],
            router: router,
            correctAnswers: ["Q1": "A1","Q2": "A2"]
        )
        
        router.answer("wrong",at: 0)
        router.answer("wrong",at: 1)
        
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
        game = startGame(
            questions: ["Q1","Q2"],
            router: router,
            correctAnswers: ["Q1": "A1","Q2": "A2"]
        )
        
        router.answer("A1",at: 0)
        router.answer("wrong",at: 1)
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
 
}

