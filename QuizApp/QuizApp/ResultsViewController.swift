//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 06/04/2023.
//

import UIKit

public class CorrectAnswerCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet private(set) public var questionLabel: UILabel!
    @IBOutlet private(set) public var answerLabel: UILabel!
    
}

public class WrongAnswerCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet private(set) public var questionLabel: UILabel!
    @IBOutlet private(set) public var correctAnswerLabel: UILabel!
    @IBOutlet private(set) public var wrongAnswerLabel: UILabel!
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
        tableView.register(CorrectAnswerCell.self)
        tableView.register(WrongAnswerCell.self)
    }

}

extension ResultsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.isCorrect {
            return correctAnswerCell(for: answer)
        }
        return wrongAnswerCell(for: answer)
    }
    
    private func correctAnswerCell(for answer: PresentableAnswer) -> CorrectAnswerCell {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
    private func wrongAnswerCell(for answer: PresentableAnswer) -> WrongAnswerCell {
        let cell = tableView.dequeueReusableCell(WrongAnswerCell.self)
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }
}
