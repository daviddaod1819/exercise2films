//
//  CategoryCollectionViewCell.swift
//  exercise2films
//
//  Created by David on 15/9/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoryStackView.layer.cornerRadius = 20.0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
