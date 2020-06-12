//
//  SetGame.swift
//  Set Game
//
//  Created by Ivan on 11/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

struct SetGame {
  
  let maximumCardsFaceUp = 12
  private(set) var cards: Array<Card>
  
  init() {
    cards = Array<Card>()
    setUpCardGame()
  }
  
  private mutating func setUpCardGame() {
    for number in Card.Number.allCases {
      for color in Card.Color.allCases {
        for symbol in Card.Symbol.allCases {
          for shadding in Card.Shading.allCases {
            cards.append(Card(
              color: color,
              number: number,
              shading: shadding,
              symbol: symbol)
            )
          }
        }
      }
    }
    cards.shuffle()
  }
  
  
  struct Card: Identifiable {
    let id: String
    let color: Color
    let number: Number
    let shading: Shading
    let symbol: Symbol
    
    init(color: Color, number: Number, shading: Shading, symbol: Symbol) {
      self.id = UUID().uuidString
      self.color = color
      self.number = number
      self.shading = shading
      self.symbol = symbol
    }
    
    enum Color: CaseIterable {
      case red, green, purple
    }
    
    enum Number: Int, CaseIterable {
      case one = 1, two, three
    }
    
    enum Shading: CaseIterable {
      case solid, striped, open
    }
    
    enum Symbol: CaseIterable {
      case diamond, squiggle, oval
    }
  }
}
