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
    private var answers = [String]()
    
    public convenience init(summary: String,answers: [String]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = summary
    }

}

extension ResultsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}