//
//  CategoryCell.swift
//  Task Manager

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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = categoryColorView.backgroundColor
        super.setSelected(selected, animated: animated)
        
        if selected {
            categoryColorView.backgroundColor = color
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = categoryColorView.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            categoryColorView.backgroundColor = color
        }
    }
    
    //MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryNameLabel?.text = nil
        categoryColorView?.backgroundColor = nil
    }
}
