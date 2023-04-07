//
//  GameTests.swift
//  QuizEngineTests
//
//  Created by Mohamed Ibrahim on 07/04/2023.
//

import XCTest
import QuizEngine

final class GameTests: XCTestCase {

    func test_startGame_answerOneOutOfTwoCorrectly_scores1() {
        let router = RouterSpy()
        startGame(questions: ["Q1","Q2"],router: router,correctAnswers: ["Q1": "A1","Q2": "A2"])
        
        XCTAssertEqual(router.routedResult?.score, 1)
    }

}

