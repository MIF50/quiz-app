//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 04/04/2023.
//

import UIKit

public final class QuestionViewController: UIViewController {
    
    private let reuseIdentifier = "Cell"
    
    //MARK: - Outlets
    
    @IBOutlet public private(set) var headerLabel: UILabel!
    @IBOutlet public private(set) var tableView: UITableView!
    
    private var question = ""
    private var options = [String]()
    private var selection: (([String]) -> Void)? = nil
    
    public convenience init(
        question: String,
        options: [String],
        selection: @escaping ([String]) -> Void
    ) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = question
    }
}

extension QuestionViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        let model = options[indexPath.row]
        cell.textLabel?.text = model
        return cell
    }
    
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    }
}

extension QuestionViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
    }
    
    private func selectedOptions(in tableView: UITableView) -> [String] {
        guard let indexPaths = tableView.indexPathsForSelectedRows else {
            return []
        }
        
        return indexPaths.map { options[$0.row] }
    }
}
