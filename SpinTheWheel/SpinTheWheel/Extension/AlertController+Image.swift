//
//  AlertController+Image.swift
//  SpinTheWheel
//
//  Created by Chhavi Mahajan on 12/07/22.
//

import UIKit

extension UIAlertController
{
    func addImage(image: UIImage)
    {
        let maxSize = CGSize(width: 45, height: 50)
        let imgSize = image.size
        
        var ratio: CGFloat
        if imgSize.width > imgSize.height
        {
            ratio = maxSize.width/maxSize.height
        }
        else
        {
            ratio = maxSize.height/maxSize.width
        }
        
        let scaledSize = CGSize(width: imgSize.width*ratio, height: imgSize.height*ratio)
        
        var resizedImg = image.imageWithSize(scaledSize)
        
        if(imgSize.height>imgSize.width)
        {
            // to set image centered
            
            let left = (maxSize.width - resizedImg.size.width)/2
            resizedImg = resizedImg.withAlignmentRectInsets(UIEdgeInsets.init(top: 0, left: -left, bottom: 0, right: 0))
        }
        
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(resizedImg.withRenderingMode(.alwaysOriginal), forKeyPath: "image")
        
        self.addAction(imgAction)
    }
}
