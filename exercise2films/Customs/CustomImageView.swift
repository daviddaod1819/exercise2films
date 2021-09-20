//
//  CustomImageView.swift
//  exercise2films
//
//  Created by David on 15/9/21.
//

import UIKit

class CustomImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 20.0
    }
}

