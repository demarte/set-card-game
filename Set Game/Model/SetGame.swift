//
//  SetGame.swift
//  Set Game
//
//  Created by Ivan on 11/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

struct SetGame {
  
  private(set) var cards: Array<Card>
  
  init() {
    cards = Array<Card>()
    setUpCardGame()
  }
  
  private var choosenCards: Array<Card> {
    cards.compactMap { $0.isSelected ? $0 : nil }
  }
  
  private func compareFeatures() {
    
  }
  
  private mutating func verifyMatch() {
    var isMatched = false
    for card in choosenCards {
      if let nextIndex = choosenCards.nextIndex(of: card) {
        let nextCard = choosenCards[nextIndex]
        
        if (card.color == nextCard.color &&
          card.symbol == nextCard.symbol &&
          card.shading == nextCard.shading &&
          card.number == nextCard.number) ||
          (card.color != nextCard.color &&
            card.symbol != nextCard.symbol &&
            card.shading != nextCard.shading &&
            card.number != nextCard.number) {
          isMatched = true
        } else {
          isMatched = false
        }
      }
    }
    for card in choosenCards {
      if let index = cards.firstIndex(matching: card) {
        cards[index].isMatched = isMatched
      }
    }
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
  
  mutating func choose(card: Card) {
    if let cardIndex = cards.firstIndex(matching: card),
      choosenCards.count < maximumChoosenCardsPerRound {
      cards[cardIndex].isSelected.toggle()
      if choosenCards.count == maximumChoosenCardsPerRound {
        verifyMatch()
      }
    }
  }
  
  func placeCards() -> Array<Card> {
    cards.suffix(maximumCardsFaceUp)
  }
  
  // MARK: - Constants -
  
  private let maximumCardsFaceUp = 12
  private let maximumChoosenCardsPerRound = 3
  
  // MARK: - Card Struct -
  
  struct Card: Identifiable, Equatable {
    let id: String
    let color: Color
    let number: Number
    let shading: Shading
    let symbol: Symbol
    var isMatched: Bool
    var isSelected: Bool
    
    init(color: Color, number: Number, shading: Shading, symbol: Symbol) {
      self.id = UUID().uuidString
      self.color = color
      self.number = number
      self.shading = shading
      self.symbol = symbol
      self.isMatched = false
      self.isSelected = false
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
