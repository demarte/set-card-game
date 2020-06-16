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
  private(set) var score: Int

  private var choosenCards: Array<Card> {
    gamePile.compactMap { $0.isSelected ? $0 : nil }
  }
  
  init() {
    deck = []
    discardPile = []
    gamePile = []
    score = 0
    setUpCardGame()
  }

  var mismatch: Bool {
    choosenCards.count == maximumChoosenCardsPerRound
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
              symbol: symbol))
          }
        }
      }
    }
    //    deck.shuffle()
  }
  
  private mutating func deselectAll() {
    for index in gamePile.indices {
      gamePile[index].isSelected = false
    }
  }
  
  mutating func choose(card: Card) {
    if let cardIndex = gamePile.firstIndex(matching: card) {
      if choosenCards.count < maximumChoosenCardsPerRound {
        gamePile[cardIndex].isSelected.toggle()
        
        if choosenCards.count == maximumChoosenCardsPerRound {
          
          if let firstIndex = gamePile.firstIndex(matching: choosenCards.first!),
            let secondIndex = gamePile.firstIndex(matching: choosenCards.second!),
            let thirdIndex = gamePile.firstIndex(matching: choosenCards.third!) {
            if compareFeatures(first: choosenCards.first, second: choosenCards.second, third: choosenCards.third) {
              score += 2
              discardPile.append(contentsOf: choosenCards)
              gamePile.remove(atOffsets: IndexSet(arrayLiteral: firstIndex, secondIndex, thirdIndex))
              draw(amount: 3)
            } else {
              score -= 1
            }
          }
        }
      } else {
        deselectAll()
        gamePile[cardIndex].isSelected = true
      }
    }
  }
  
  mutating func draw(amount: Int) {
    if !deck.isEmpty {
      let range = deck.count - amount..<deck.count
      gamePile.append(contentsOf: deck.suffix(amount))
      deck.removeSubrange(range)
      for index in gamePile.indices {
        gamePile[index].isFaceUp = true
      }
    }
  }
  
  private func compareFeatures(first: Card?, second: Card?, third: Card?) -> Bool {
    guard let first = first, let second = second, let third = third else { return false }
    
    return Card.compare(first: first.color.rawValue, second: second.color.rawValue, third: third.color.rawValue) &&
      Card.compare(first: first.number.rawValue, second: second.number.rawValue, third: third.number.rawValue) &&
      Card.compare(first: first.shading.rawValue, second: second.shading.rawValue, third: third.shading.rawValue) &&
      Card.compare(first: first.symbol.rawValue, second: second.symbol.rawValue, third: third.symbol.rawValue)
  }
  
  // MARK: - Bonus Time -

  
  private(set) var bonusTimeLimit: TimeInterval = 60
  
  private var pastRoundTime: TimeInterval = 0
  
  private var lastRoundTime: Date?
  
  private var roundTime: TimeInterval {
    if let lastRoundTime = self.lastRoundTime {
      return pastRoundTime + Date().timeIntervalSince(lastRoundTime)
    } else {
      return pastRoundTime
    }
  }
  
  var hasEarnedBonus: Bool {
    bonusTimeLimit - roundTime > 0
  }
  
  private mutating func startUsingBonusTime() {
    if lastRoundTime == nil {
      lastRoundTime = Date()
    }
  }
  
  private mutating func stopUsingBonusTime() {
    pastRoundTime = roundTime
    self.lastRoundTime = nil
  }
  
  
  // MARK: - Constants -
  
  private let maximumCardsFaceUp = 12
  private let maximumChoosenCardsPerRound = 3
  private let numberOfNewCardsPlaced = 3
}
