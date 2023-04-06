//
//  UITableView+Ext.swift
//  QuizApp
//
//  Created by Mohamed Ibrahim on 06/04/2023.
//

import UIKit

extension UITableView {
    
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(.init(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(_ type: T.Type) -> T {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as! T
    }
}
