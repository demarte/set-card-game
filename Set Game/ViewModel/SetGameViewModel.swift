//
//  SetCardGameViewModel.swift
//  Set Game
//
//  Created by Ivan on 11/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

final class SetGameViewModel: ObservableObject {
  
  @Published private var setGame: SetGame
  
  init() {
    setGame = SetGame()
  }
  
  // MARK: - Access to the Model -
  
  var score: Int {
    setGame.score
  }
  
  var deck: Array<Card> {
    setGame.deck
  }
  
  var gamePile: Array<Card> {
    setGame.gamePile
  }

  func choose(card: Card) {
    setGame.choose(card: card)
  }
  
  func draw(amount: Int = 1) {
    setGame.draw(amount: amount)
  }

  func dealMore() {
    setGame.dealMore()
  }
  
  func newGame() {
    setGame = SetGame()
    draw(amount: 12)
  }
}
