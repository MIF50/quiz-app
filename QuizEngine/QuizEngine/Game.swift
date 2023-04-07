//
//  Game.swift
//  QuizEngine
//
//  Created by Mohamed Ibrahim on 07/04/2023.
//

import Foundation

public class Game<Question: Hashable,Answer,R: Router> where R.Question == Question, R.Answer == Answer {
    
    let flow: Flow<Question,Answer,R>
    
    init(flow: Flow<Question,Answer,R>) {
        self.flow = flow
    }
}

public func startGame<Question: Hashable,Answer: Equatable,R: Router>(
    questions: [Question],
    router: R,
    correctAnswers: [Question: Answer]
) -> Game<Question,Answer,R> where R.Question == Question , R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: { scoring($0, correctAnswer: correctAnswers )})
    flow.start()
    return Game(flow: flow)
}

private func scoring<Question : Hashable,Answer: Equatable>(
    _ answers: [Question: Answer],
    correctAnswer: [Question: Answer]
) -> Int {
    answers.reduce(0) { score, tuple in
        score + ( correctAnswer[tuple.key] == tuple.value ? 1 : 0 )
    }
}
