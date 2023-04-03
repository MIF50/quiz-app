//
//  Flow.swift
//  QuizEngine
//
//  Created by Mohamed Ibrahim on 03/04/2023.
//

import Foundation

public protocol Router {}

public class Flow {
    
    private let questions: [String]
    private let router: Router
    
    public init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    public func start() {
        
    }
}
