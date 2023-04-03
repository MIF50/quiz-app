//
//  FlowTests.swift
//  QuizEngineTests
//
//  Created by Mohamed Ibrahim on 03/04/2023.
//

import XCTest
import QuizEngine

final class FlowTests: XCTestCase {

    func test_start_withNoQuestion_doesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: [],router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
//    func test_start_withOneQuestion_routesToQuestion() {
//        let router = RouterSpy()
//        let sut = Flow(questions: ["Q1"],router: router)
//        
//        sut.start()
//        
//        XCTAssertEqual(router.routedQuestionCount, 1)
//    }
    
    //MARK: - Helper
    
    private class RouterSpy: Router {
        var routedQuestionCount = 0
    }

}

