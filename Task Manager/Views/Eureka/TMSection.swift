//
//  TMSection.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 13/06/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class TMSection: Section {
    
    var tmHeaderString: String? {
        didSet {
            let view = header?.viewForSection(self, type: .header)
            view?.setNeedsLayout()
            //view?.backgroundColor = UIColor(named: "TMGrey")
        }
    }
    
    override init(_ header: String, _ initializer: (Section) -> Void = { _ in }) {
        tmHeaderString = header
        
        super.init(header, initializer)
        
        var tmHeader = HeaderFooterView<UITableViewHeaderFooterView>(.class)
        tmHeader.height = { UITableViewAutomaticDimension } //UITableViewAutomaticDimension
        //tmHeader.height = { CGFloat(70) }
        tmHeader.onSetupView = { view, section in
            view.textLabel?.text = self.tmHeaderString
            view.textLabel?.textColor = UIColor(named: "TMYellow")
            view.textLabel?.font = UIFont.taskManagerFont(ofSize: 15, weight: .semibold)
            
            //view.detailTextLabel?.textColor = UIColor(named: "TMYellow")
            
            //view.backgroundColor = UIColor(named: "TMGrey")
            //view.backgroundView?.backgroundColor = UIColor(named: "TMGrey")
            view.contentView.backgroundColor = UIColor(named: "TMGrey")
            
        }
        
        self.header = tmHeader
    }
    
    required init<S>(_ elements: S) where S : Sequence, S.Element == BaseRow {
        super.init(elements)
        
    }
    
    required init() {
        super.init()
    }
    
}
