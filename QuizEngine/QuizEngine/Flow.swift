//
//  Flow.swift
//  QuizEngine
//
//  Created by Mohamed Ibrahim on 03/04/2023.
//

import Foundation

public protocol Router {}

public class Flow {
    
    private let router: Router
    
    public init(router: Router) {
        self.router = router
    }
    
    public func start() {
        
    }
}
