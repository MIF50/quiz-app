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
        let (sut, router) = makeSUT()
        
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        let (sut, router) = makeSUT(questions: ["Q2"])

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let (sut, router) = makeSUT(questions: ["Q1","Q2"])

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let (sut, router) = makeSUT(questions: ["Q1","Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        let (sut, router) = makeSUT(questions: ["Q1","Q2","Q3"])

        sut.start()
        router.answer("A1",at: 0)
        router.answer("A2",at: 1)

        XCTAssertEqual(router.routedQuestions, ["Q1","Q2","Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToAnotherQuestion() {
        let (sut, router) = makeSUT(questions: ["Q1"])

        sut.start()
        router.answer("A1",at: 0)

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestion_routesToResult() {
        let (sut, router) = makeSUT()
        
        sut.start()
        
        XCTAssertEqual(router.routedResult,[:])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_routesToResult() {
        let (sut, router) = makeSUT(questions: ["Q1"])

        sut.start()
        router.answer("A1",at: 0)

        XCTAssertEqual(router.routedResult, ["Q1":"A1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routesToResult(){
        let (sut, router) = makeSUT(questions: ["Q1","Q2"])

        sut.start()
        router.answer("A1",at: 0)
        router.answer("A2",at: 1)

        XCTAssertEqual(router.routedResult, ["Q1":"A1","Q2":"A2"])
    }

    
    //MARK: - Helper
    
    private func makeSUT(
        questions: [String] = [],
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: Flow,router: RouterSpy) {
        let router = RouterSpy()
        let sut = Flow(questions: questions,router: router)
        trackForMemoryLeaks(router,file: file,line: line)
        trackForMemoryLeaks(sut,file: file,line: line)
        return (sut,router)
    }
    
    private class RouterSpy: Router {
        var routedQuestions = [String]()
        var routedResult: [String: String] = [:]
        private var answers = [Router.AnswerCallback]()
        
        func routeTo(question: String,answerCallback: @escaping Router.AnswerCallback) {
            routedQuestions.append(question)
            answers.append(answerCallback)
        }
        
        func answer(_ answered: String,at index: Int = 0) {
            answers[index](answered)
        }
        
        func routeTo(result: [String: String]) {
            routedResult = result
        }
    }

}

