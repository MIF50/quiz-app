//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 06/04/2023.
//

import UIKit

public struct PresentableAnswer {
    public let question: String
    public let isCorrect: Bool
    
    public init(question: String, isCorrect: Bool) {
        self.question = question
        self.isCorrect = isCorrect
    }
}

public class CorrectAnswerCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet private(set) public var questionLabel: UILabel!

    
}

public class WrongAnswerCell: UITableViewCell {
    
}

public final class ResultsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet public private(set) var headerLabel: UILabel!
    @IBOutlet public private(set) var tableView: UITableView!
    
    private var summary = ""
    private var answers = [PresentableAnswer]()
    
    public convenience init(summary: String,answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = summary
        tableView.register(.init(nibName: "CorrectAnswerCell", bundle: nibBundle), forCellReuseIdentifier: "CorrectAnswerCell")
    }

}

extension ResultsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.isCorrect {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectAnswerCell") as! CorrectAnswerCell
            cell.questionLabel.text = answer.question
            return cell
        }
        return WrongAnswerCell()
    }
}
