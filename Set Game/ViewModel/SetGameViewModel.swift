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
  
  var cards: Array<SetGame.Card> {
    setGame.cards
  }
  
  func placeCards() -> Array<SetGame.Card> {
    setGame.placeCards()
  }
  
  func choose(card: SetGame.Card) {
    setGame.choose(card: card)
  }
}
