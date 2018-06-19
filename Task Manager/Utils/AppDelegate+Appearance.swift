//
//  AppDelegate+Appearance.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 09/06/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit
import Eureka

extension AppDelegate {
    func setUpAppearance() {
        UINavigationBar.appearance().tintColor = UIColor(named: "TMGrey")
        UINavigationBar.appearance().backgroundColor = UIColor(named: "TMYellow")
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "TMGrey")!, .font: UIFont.taskManagerFont(ofSize: 17, weight: .semibold)]
        
        UIBarButtonItem.appearance().tintColor = UIColor(named: "TMGrey")
        for state: UIControlState in [.normal, .disabled, .highlighted, .selected] {
            UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.taskManagerFont(ofSize: 17, weight: .semibold), .foregroundColor: UIColor(named: "TMGrey")!], for: state)
        }
        
        
        
        //MARK: - Form General Customization
        //General Customization - CheckRow
        CheckRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.textColor = UIColor(named: "TMGrey")
            cell.textLabel?.font = UIFont.taskManagerFont(ofSize: 17)
            
            cell.tintColor = UIColor(named: "TMGrey")
            
            //cell.backgroundColor = UIColor(named: "TMGrey")
        }
        
        //General Customization - TextRow
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.textColor = UIColor(named: "TMGrey")
            
            cell.textField.textColor = UIColor(named: "TMGrey")
            cell.textField.tintColor = UIColor(named: "TMGrey40")
            
            //Placeholder color setup in Local Customization
            
            //cell.backgroundColor = UIColor(named: "TMGrey")
        }
        
        //General Customization - TextAreaRow
        TextAreaRow.defaultCellUpdate = { cell, row in
            cell.textView.textColor = UIColor(named: "TMGrey")
            cell.textView.tintColor = UIColor(named: "TMGrey40")
            cell.textView.backgroundColor = UIColor.clear
            
            cell.placeholderLabel?.textColor = UIColor(named: "TMGrey40")
            
            //cell.backgroundColor = UIColor(named: "TMGrey")
        }
        
        //General Customization - DateRow
        DateTimeRow.defaultRowInitializer = { row in
            row.minimumDate = Date()
        }
        DateTimeRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.textColor = UIColor(named: "TMGrey")
            cell.detailTextLabel?.textColor = UIColor(named: "TMGrey40")
            
            cell.datePicker.tintColor = UIColor(named: "TMYellow40")
            cell.datePicker.setValue(UIColor(named: "TMYellow"), forKey: "textColor")
            cell.datePicker.backgroundColor = UIColor(named: "TMGrey")
            
            
            //cell.backgroundColor = UIColor(named: "TMGrey")
        }
        
        //General Customization - SwitchRow
        SwitchRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.textColor = row.isDisabled ? UIColor(named: "TMGrey40") : UIColor(named: "TMGrey")
            
            cell.switchControl.tintColor = UIColor(named: "TMGrey40")
            cell.switchControl.onTintColor = UIColor(named: "TMGrey40")
            cell.switchControl.thumbTintColor = UIColor(named: "TMYellow")
            
            //cell.backgroundColor = UIColor(named: "TMGrey")
        }
        
        //General Customization - PushRow
        PushRow<Category>.defaultCellUpdate = { cell, row in
            cell.textLabel?.textColor = UIColor(named: "TMGrey")
            cell.detailTextLabel?.textColor = UIColor(named: "TMGrey40")
            
            //cell.backgroundColor = UIColor(named: "TMGrey")
        }
    }
}
