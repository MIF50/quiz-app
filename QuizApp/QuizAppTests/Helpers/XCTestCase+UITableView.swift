//
//  XCTestCase+UITableView.swift
//  QuizAppTests
//
//  Created by Mohamed Ibrahim on 06/04/2023.
//

import UIKit

extension UITableView {
    
    func cell(at row: Int, section: Int = 0) -> UITableViewCell? {
        let index = IndexPath(row: row, section: section)
        return dataSource?.tableView(self, cellForRowAt: index)
    }
    
    func select(at row: Int,section: Int = 0) {
        let index = IndexPath(row: row, section: section)
        selectRow(at: index, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: index)
    }
    
    func deselect(at row: Int,section: Int = 0) {
        let index = IndexPath(row: row, section: section)
        deselectRow(at: index, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: index)
    }
}
