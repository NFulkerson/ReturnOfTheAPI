//
//  UIButton+Extension.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/30/18.
//  Copyright © 2018 Nathan. All rights reserved.


import UIKit

extension UIButton {
    // This code comes primarily from a StackOverflow solution to positioning button labels
    // and images
    func centerVertically(padding: CGFloat = 6.0) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else { return }
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageSize.width,
            bottom: -(imageSize.height + padding),
            right: 0.0
        )
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedStringKey.font: font])
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(titleSize.height + padding),
            left: 0.0,
            bottom: 0.0,
            right: -titleSize.width
        )
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        self.contentEdgeInsets = UIEdgeInsets(
            top: edgeOffset,
            left: 0.0,
            bottom: edgeOffset,
            right: 0.0
        )
    }
}
