//
//  CategoryTableViewCell.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 21/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static let identifier = "CategoryCell"
    
    //MARK: - Outlets
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryColorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(category: Category) {
        categoryLabel?.text = category.name
        categoryColorView?.backgroundColor = category.color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel?.text = nil
        categoryColorView?.backgroundColor = nil
    }
    
}
