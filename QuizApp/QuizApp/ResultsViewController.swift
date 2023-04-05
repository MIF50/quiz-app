//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 06/04/2023.
//

import UIKit

public final class ResultsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet public private(set) var headerLabel: UILabel!
    @IBOutlet public private(set) var tableView: UITableView!
    
    private var summary = ""
    
    public convenience init(summary: String) {
        self.init()
        self.summary = summary
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = summary
    }

}
