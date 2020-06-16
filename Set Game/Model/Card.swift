//
//  Card.swift
//  Set Game
//
//  Created by Ivan on 13/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

struct Card: Identifiable, Equatable, FeatureComparable {
  typealias Feature = Int
  
  let id: String
  let color: Color
  let number: Number
  let shading: Shading
  let symbol: Symbol
  var isSelected: Bool
  var isFaceUp: Bool

  init(color: Color, number: Number, shading: Shading, symbol: Symbol) {
    self.id = UUID().uuidString
    self.color = color
    self.number = number
    self.shading = shading
    self.symbol = symbol
    self.isSelected = false
    self.isFaceUp = false
  }
  
  enum Color: Int, CaseIterable {
    case red, green, purple
  }
  
  enum Number: Int, CaseIterable {
    case one = 1, two, three
  }
  
  enum Shading: Int, CaseIterable {
    case solid, striped, open
  }
  
  enum Symbol: Int, CaseIterable {
    case diamond, squiggle, oval
  }
}
