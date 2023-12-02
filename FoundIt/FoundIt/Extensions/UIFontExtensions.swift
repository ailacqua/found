//
//  UIFontExtensions.swift
//  FoundIt
//
//  Created by Alexander Ilacqua on 12/1/23.
//

import Foundation
import UIKit

extension UIFont {

    var rounded: UIFont {
        guard let desc = self.fontDescriptor.withDesign(.rounded) else { return self }
        return UIFont(descriptor: desc, size: self.pointSize)
    }

}
