//
//  AppDelegate+Appearance.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 09/06/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit

extension AppDelegate {
    func setUpAppearance() {
        UINavigationBar.appearance().tintColor = UIColor(named: "TMGrey")
        UINavigationBar.appearance().backgroundColor = UIColor(named: "TMYellow")
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "TMGrey")!, .font: UIFont.taskManagerFont(ofSize: 17, weight: .semibold)]
        
        UIBarButtonItem.appearance().tintColor = UIColor(named: "TMGrey")
        for state: UIControlState in [.normal, .disabled, .highlighted, .selected] {
            UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.taskManagerFont(ofSize: 17, weight: .semibold), .foregroundColor: UIColor(named: "TMGrey")!], for: state)
        }
    }
}
