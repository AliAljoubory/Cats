//
//  UIView.swift
//  Cats
//
//  Created by Ali Aljoubory on 25/12/2020.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
