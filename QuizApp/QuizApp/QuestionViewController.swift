//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 04/04/2023.
//

import UIKit

public final class QuestionViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet public private(set) var headerLabel: UILabel!

    
    private var question: String = ""
    
    public convenience init(question: String) {
        self.init()
        self.question = question
    }
}
