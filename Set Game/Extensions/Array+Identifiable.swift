//
//  Array+Index.swift
//  Memorize
//
//  Created by Ivan on 31/05/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
  func firstIndex(matching: Element) -> Int? {
    
    for index in 0..<self.count {
      if self[index].id == matching.id {
        return index
      }
    }
    return nil
  }
}

extension Array {
  var second: Element? {
    if self.count >= 2 {
      return self[1]
    }
    return nil
  }
}

extension Array {
  var third: Element? {
    if self.count >= 3 {
      return self[2]
    }
    return nil
  }
}
