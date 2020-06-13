//
//  SetGameView.swift
//  Set Game
//
//  Created by Ivan on 08/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
  
  @ObservedObject var game: SetGameViewModel
  
  var body: some View {
    VStack {
      Button("New Game") {
        print("new game")
      }
      Spacer()
      Grid(game.gamePile) { card in
        CardView(card: card)
          .padding(2)
          .animation(.easeIn(duration: 1))
          .onTapGesture {
            self.game.choose(card: card)
        }
      }
      Spacer()
      Button("Deal 3 More Cards") {
        self.game.dealThreeCards()
      }
      .disabled(game.cards.count > 0 ? false : true)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    SetGameView(game: SetGameViewModel())
  }
}
