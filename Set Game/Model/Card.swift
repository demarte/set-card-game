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
  var isFaceUp: Bool
  var misMatch: Bool
  var isSelected: Bool {
    didSet {
      if isSelected {
        startUsingBonusTime()
      } else {
        stopUsingBonusTime()
      }
    }
  }

  init(color: Color, number: Number, shading: Shading, symbol: Symbol) {
    self.id = UUID().uuidString
    self.color = color
    self.number = number
    self.shading = shading
    self.symbol = symbol
    self.isSelected = false
    self.isFaceUp = false
    self.misMatch = false
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

  // MARK: - Bonus Time -

  // this could give matching bonus points
  // if the user matches the card
  // before a certain amount of time passes during which the card is face up

  // can be zero with means "no bonus available" for this card
  var bonusTimeLimit: TimeInterval = 10

  // the last time this card was turned face up (and still face up)
  var lastTimeFaceUp: Date?
  // the accumulated time this card has been face up in the past
  // (i.e. not including the current time it's been face up if it is currently so)
  var pastFaceUpTime: TimeInterval = 0

  // how long this card has ever been face up
  private var faceUpTime: TimeInterval {
    if let lastFaceUpDate = self.lastTimeFaceUp {
      return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
    } else {
      return pastFaceUpTime
    }
  }

  // how much time left before the bonus opportunity runs out
  var bonusTimeRemaining: TimeInterval {
    max(0, bonusTimeLimit - faceUpTime)
  }

  // percentage of bonus time remaining
  var bonusRemaining: Double {
    (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
  }

  // whether the card was matched during the bonus time period
  var hasEarnedBonus: Bool {
   bonusTimeRemaining > 0
  }

  // whether we are currently face up, unmatched and have not yet used up the bonus window
  var isConsumingBonusTime: Bool {
    isSelected && bonusTimeRemaining > 0 && !misMatch
  }

  // called when the card transitions to face up state
  private mutating func startUsingBonusTime() {
    if isConsumingBonusTime, lastTimeFaceUp == nil {
      lastTimeFaceUp = Date()
    }
  }

  // called when the card goes back down (or gets matched)
  private mutating func stopUsingBonusTime() {
    pastFaceUpTime = faceUpTime
    self.lastTimeFaceUp = nil
  }
}
