//
//  CategoryCell.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 21/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit
import CoreData

class CategoryCell: UITableViewCell {
    static let identifier = "CategoryCell"
    
    //MARK: - Outlets
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryColorView: UIView!
    
    
    //MARK: - Public Interface
    func setupCell(category: Category) {
        categoryNameLabel?.text = category.name
        categoryColorView?.backgroundColor = category.color
    }
    //MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryNameLabel?.text = nil
        categoryColorView?.backgroundColor = nil
    }
}
