//
//  Game.swift
//  QuizEngine
//
//  Created by Mohamed Ibrahim on 07/04/2023.
//

import Foundation

public func startGame<Question: Hashable,Answer,R: Router>(
    questions: [Question],
    router: R,
    correctAnswers: [Question: Answer]
) where R.Question == Question , R.Answer == Answer {
    
}
