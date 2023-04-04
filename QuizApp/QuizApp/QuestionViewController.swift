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
    @IBOutlet public private(set) var tableView: UITableView!

    
    private var question: String = ""
    private var options = [String]()
    
    public convenience init(question: String,options: [String]) {
        self.init()
        self.question = question
        self.options = options
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = question
    }
}
