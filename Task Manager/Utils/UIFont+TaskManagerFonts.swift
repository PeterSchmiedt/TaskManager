//
//  UIFont+TaskManagerFonts.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 09/06/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit

extension UIFont {
    
    // Helper function to print all fonts
    static func printAllFonts() {
        let familyNames = UIFont.familyNames
        
        for family in familyNames {
            print("Family name " + family)
            let fontNames = UIFont.fontNames(forFamilyName: family)
            
            for font in fontNames {
                print("    Font name: " + font)
            }
        }
    }
    
    static func taskManagerFont(ofSize size: CGFloat, weight: Weight = .regular) -> UIFont {
        switch weight {
        case .bold:
            return UIFont(name: "OpenSans-Bold", size: size)!
        case .light:
            return UIFont(name: "OpenSans-Light", size: size)!
        case .regular:
            return UIFont(name: "OpenSans-Regular", size: size)!
        case .semibold:
            return UIFont(name: "OpenSans-SemiBold", size: size)!
        default:
            return UIFont(name: "OpenSans-Regular", size: size)!
        }
    }
    
    static func taskManagerItalicFont(ofSize size: CGFloat, weight: Weight = .regular) -> UIFont {
        switch weight {
        case .bold:
            return UIFont(name: "OpenSans-BoldItalic", size: size)!
        case .light:
            return UIFont(name: "OpenSans-LightItalic", size: size)!
        case .regular:
            return UIFont(name: "OpenSans-Italic", size: size)!
        case .semibold:
            return UIFont(name: "OpenSans-SemiBoldItalic", size: size)!
        default:
            return UIFont(name: "OpenSans-Italic", size: size)!
        }
    }
}
