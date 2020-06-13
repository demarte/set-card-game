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
  
  func nextIndex(of element: Element) -> Int? {
    if let index = self.firstIndex(matching: element) {
      let afterIndex = self.index(after: index)
      if afterIndex < self.count {
        return afterIndex
      }
    }
    return nil
  }
}
