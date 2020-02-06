//
//  String+Extension.swift
//  BlackBeans
//
//  Created by Ricardo Gehrke on 02/02/20.
//  Copyright © 2020 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

extension String {
  
  static var empty = ""
  
  var isNumber: Bool {
      return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
  }
  
  mutating func removeLastCharacter() -> Self {
    return String(dropLast())
  }
  
  mutating func removeNonNumbers() -> Self {
    return components(separatedBy:CharacterSet.decimalDigits.inverted)
      .joined()
  }
}
