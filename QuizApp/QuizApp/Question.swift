//
//  Question.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 08/04/2023.
//

import Foundation

enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    var hashValue: Int {
        switch self {
        case let .singleAnswer(a):
            return a.hashValue
        case let .multipleAnswer(a):
            return a.hashValue
        }
    }
    
    func hash(into hasher: inout Hasher) {}
    
    static func == (lsh: Question<T>,rsh: Question<T>) -> Bool {
        switch (lsh,rsh) {
        case let (.singleAnswer(a),.singleAnswer(b)):
            return a == b
            
        case let (.multipleAnswer(a),.multipleAnswer(b)):
            return a == b
            
        default:
            return false
        }
    }
}
