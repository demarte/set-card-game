//
//  SetGame.swift
//  Set Game
//
//  Created by Ivan on 11/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

struct SetGame {
  
  private(set) var deck: Array<Card>
  private(set) var discardPile: Array<Card>
  private(set) var gamePile: Array<Card>
  
  init() {
    deck = []
    discardPile = []
    gamePile = []
    setUpCardGame()
  }
  
  private var choosenCards: Array<Card> {
    gamePile.compactMap { $0.isSelected ? $0 : nil }
  }
  
  private mutating func setUpCardGame() {
    for number in Card.Number.allCases {
      for color in Card.Color.allCases {
        for symbol in Card.Symbol.allCases {
          for shadding in Card.Shading.allCases {
            deck.append(Card(
              color: color,
              number: number,
              shading: shadding,
              symbol: symbol)
            )
          }
        }
      }
    }
    deck.shuffle()
  }
  
  private mutating func deselectAll() {
    for index in gamePile.indices {
      gamePile[index].isSelected = false
    }
  }
  
  mutating func choose(card: Card) {
    if let cardIndex = gamePile.firstIndex(matching: card) {
      if choosenCards.count == maximumChoosenCardsPerRound {
        deselectAll()
      }
      gamePile[cardIndex].isSelected.toggle()
    }
  }
  
  mutating func dealThreeCards() {
    if choosenCards.count == maximumChoosenCardsPerRound {
      
      if let firstIndex = deck.firstIndex(matching: choosenCards.first!),
        let secondIndex = deck.firstIndex(matching: choosenCards.second!),
        let thirdIndex = deck.firstIndex(matching: choosenCards.third!) {
        
        if compareCards(first: choosenCards.first, second: choosenCards.second, third: choosenCards.third) {
          discardPile.append(deck.remove(at: firstIndex))
          discardPile.append(deck.remove(at: secondIndex))
          discardPile.append(deck.remove(at: thirdIndex))
        }
      }
    } else {
      placeMoreCards()
    }
  }
  
  private mutating func placeMoreCards() {
    for _ in 0..<numberOfNewCardsPlaced {
      if deck.count > 0 {
        gamePile.append(deck.removeFirst())
      }
    }
  }
  
  private func compareCards(first: Card?, second: Card?, third: Card?) -> Bool {
    guard let first = first, let second = second, let third = third else { return false }
    
    return Card.compare(first: first.color.rawValue, second: second.color.rawValue, third: third.color.rawValue) &&
      Card.compare(first: first.number.rawValue, second: second.number.rawValue, third: third.number.rawValue) &&
      Card.compare(first: first.shading.rawValue, second: second.shading.rawValue, third: third.shading.rawValue) &&
      Card.compare(first: first.symbol.rawValue, second: second.symbol.rawValue, third: third.symbol.rawValue)
  }
  
  mutating func placeCards() {
    gamePile = deck.suffix(maximumCardsFaceUp)
//    gamePile = deck
  }
  
  // MARK: - Constants -
  
  private let maximumCardsFaceUp = 12
  private let maximumChoosenCardsPerRound = 3
  private let numberOfNewCardsPlaced = 3
}
