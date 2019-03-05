//
//  TMSection.swift
//  Task Manager

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
