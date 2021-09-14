//
//  String+Extensions.swift
//  MemriTask
//
//  Created by ashokdy on 15/09/2021.
//

import CoreGraphics

extension String {
    func actual() -> CGFloat? {
        guard let doubleValue = Double(self.replacingOccurrences(of: "em", with: "")) else { return 0 }
        return CGFloat(doubleValue)
    }
}
