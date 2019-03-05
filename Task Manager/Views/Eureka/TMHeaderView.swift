//
//  TMHeader.swift
//  Task Manager

import UIKit

class TMHeaderView: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var sectionLabel: UILabel!
    
    //MARK: - Public Interface
    func setupCell(header: String) {
        sectionLabel.text = header
        sectionLabel.font = UIFont.taskManagerFont(ofSize: 17, weight: .semibold)
    }
    
    //MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.sectionLabel.text = nil
    }

}
