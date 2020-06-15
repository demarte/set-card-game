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
        withAnimation(.linear(duration: 2)) {
          self.game.newGame()
        }
      }
      Grid(game.gamePile) { card in
        CardView(card: card)
          .padding(self.game.gamePile.count > 30 ? 2 : 5)
          .transition(
            AnyTransition.scale.combined(
              with: .offset(
                self.randomPositionsOffScreen()
              )
          ))
          .aspectRatio(self.cardAspectRatio, contentMode: .fit)
          .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
              self.game.choose(card: card)
            }
        }
      }
      Button("Deal 3 More Cards") {
        withAnimation(.easeInOut(duration: 1)) {
          self.game.dealMoreCards()
        }
      }
      .disabled(game.cards.isEmpty ? true : false)
    }.onAppear {
      withAnimation(.easeInOut(duration: 2)) {
        self.game.placeCards()
      }
    }
  }
  
  private func randomPositionsOffScreen() -> CGSize {
    let randomWidth = Int.random(in: -1000...2000)
    let randomHeight = Int.random(in: -1000..<2000)

    return CGSize(width: randomWidth , height: randomHeight)
  }

  //MARK: - Constants -

  private let cardAspectRatio: CGFloat = 0.75
}

struct SetGameView_Previews: PreviewProvider {
  static var previews: some View {
    SetGameView(game: SetGameViewModel())
  }
}
