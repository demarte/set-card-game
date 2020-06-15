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
    body(for: game)
  }

  private func body(for game: SetGameViewModel) -> some View {
    VStack {
      Button("New Game") {
        withAnimation(.linear(duration: 2)) {
          game.newGame()
        }
      }
      Grid(game.gamePile) { card in
        CardView(card: card)
          .padding(game.gamePile.count > 30 ? 2 : 5)
          .transition(
            AnyTransition.scale.combined(
              with: .offset(
                self.randomPositionsOffScreen()
              )
          ))
          .aspectRatio(self.cardAspectRatio, contentMode: .fit)
          .shake(times: game.mismatch ? 1 : 0)
          .foregroundColor(self.color(for: card))
          .scaleEffect(card.isSelected ? 1.03 : 1)
          .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
              game.choose(card: card)
            }
        }
      }
      Button("Deal 3 More Cards") {
        withAnimation(.easeInOut(duration: 1)) {
          game.dealMoreCards()
        }
      }
      .disabled(game.cards.isEmpty ? true : false)
    }.onAppear {
      withAnimation(.easeInOut(duration: 2)) {
        game.placeCards()
      }
    }
  }

  private func color(for card: Card) -> Color {
    if card.isSelected {
      return game.mismatch ? Color.red : Color.blue
    } else {
      return Color.gray
    }
  }
  
  private func randomPositionsOffScreen() -> CGSize {
    let randomWidth = Int.random(in: -2000...2000)
    let randomHeight = Int.random(in: -2000..<2000)

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
