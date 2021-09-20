//
//  UIImageExtension.swift
//  exercise2films
//
//  Created by David on 20/9/21.
//

import UIKit

extension UIImage {
    
    func resizeImage(width: CGFloat) -> UIImage? {
        let width: CGFloat = width
        let height: CGFloat = (width * self.size.height) / self.size.width
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        let newImage = renderer.image { _ in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        
        return newImage
    }
}
