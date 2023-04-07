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
        
        XCTAssertEqual(router.routedResult?.answers,[:])
    }
    
    func test_start_withOneQuestion_doesNotRouteToResult() {
        let (sut, router) = makeSUT(questions: ["A1"])
        
        sut.start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotRouteToResult(){
        let (sut, router) = makeSUT(questions: ["Q1","Q2"])

        sut.start()
        router.answer("A1",at: 0)

        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routesToResult(){
        let (sut, router) = makeSUT(questions: ["Q1","Q2"])

        sut.start()
        router.answer("A1",at: 0)
        router.answer("A2",at: 1)

        XCTAssertEqual(router.routedResult?.answers, ["Q1":"A1","Q2":"A2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scoresWithRightAnswers(){
        var receivedAnswers: [String: String] = [:]
        let (sut, router) = makeSUT(questions: ["Q1","Q2"],scoring: { answers in
            receivedAnswers = answers
            return 10
        })

        sut.start()
        router.answer("A1",at: 0)
        router.answer("A2",at: 1)

        XCTAssertEqual(router.routedResult?.score, 10)
        XCTAssertEqual(receivedAnswers, ["Q1":"A1","Q2":"A2"])
    }

    
    //MARK: - Helper
    
    private typealias SUT = Flow<String,String,RouterSpy>
    
    private func makeSUT(
        questions: [String] = [],
        scoring: @escaping ([String: String]) -> Int = { _ in 0 },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: SUT,router: RouterSpy) {
        let router = RouterSpy()
        let sut = Flow(questions: questions,router: router,scoring: scoring)
        trackForMemoryLeaks(router,file: file,line: line)
        trackForMemoryLeaks(sut,file: file,line: line)
        return (sut,router)
    }
    
    private class RouterSpy: Router {
        
        
        var routedQuestions = [String]()
        var routedResult: Result<String,String>? = nil
        private var answers = [(String) -> Void]()
        
        func routeTo(question: String,answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            answers.append(answerCallback)
        }
        
        func answer(_ answered: String,at index: Int = 0) {
            answers[index](answered)
        }
        
        func routeTo(result: Result<String, String>) {
            routedResult = result
        }
    }

}

