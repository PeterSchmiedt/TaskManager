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
    
    override init(_ header: String, _ initializer: (Section) -> Void = { _ in }) {
        super.init(header, initializer)
        
        var tmHeader = HeaderFooterView<TMHeaderView>(.nibFile(name: "TMHeaderView", bundle: nil))
        tmHeader.height = {30}
        
        tmHeader.onSetupView = { view, _ in
            //view.backgroundColor = UIColor(named: "TMGrey60")
            view.setupCell(header: header)
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
