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
    setGame.placeCards()
  }
  
  // MARK: - Access to the Model -
  
  var cards: Array<Card> {
    setGame.cards
  }
  
  var gamePile: Array<Card> {
    setGame.gamePile
  }
  
  func placeCards() {
    setGame.placeCards()
  }
  
  func choose(card: Card) {
    setGame.choose(card: card)
  }
  
  func dealThreeCards() {
    setGame.dealThreeCards()
  }
}
