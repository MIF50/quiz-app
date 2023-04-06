//
//  WrongAnswerCell.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 06/04/2023.
//

import UIKit

public class WrongAnswerCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet private(set) public var questionLabel: UILabel!
    @IBOutlet private(set) public var correctAnswerLabel: UILabel!
    @IBOutlet private(set) public var wrongAnswerLabel: UILabel!
}
