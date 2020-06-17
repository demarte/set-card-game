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
      HStack(spacing: topContainerSpacing) {
        Text("Score: \(game.score)")
          .font(Font.headline)
        Button("New Game") {
          withAnimation(.linear(duration: 2)) {
            game.newGame()
          }
        }
        Button("Hint") {
          withAnimation(.linear(duration: 0.3)) {
            game.hint()
          }
        }
        .disabled(game.hasChooseCards)
      }
      Grid(game.gamePile) { card in
        CardView(card: card)
          .padding(game.gamePile.count > 30 ? 2 : 5)
          .transition(.offset(self.randomPositionsOffScreen()))
          .scaleEffect(card.isSelected ? 1.03 : 1)
          .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
              game.choose(card: card)
            }
        }
      }
      .onAppear {
        withAnimation(.linear(duration: 2)) {
          self.game.draw(amount: 12)
        }
      }
      ZStack {
        if !self.game.deck.isEmpty {
          ForEach(self.game.deck.reversed()) { card in
            CardView(card: card)
              .rotationEffect(Angle.degrees(self.deckRotation))
              .foregroundColor(Color.gray)
          }
        }
      }
      .onTapGesture {
        withAnimation(.easeInOut(duration: 1)) {
          self.game.dealMore()
        }
      }
      .frame(width: deckWidth, height: deckHeigth)
    }
  }
  
  private func randomPositionsOffScreen() -> CGSize {
    let randomWidth = Int.random(in: randomRange)
    let randomHeight = Int.random(in: randomRange)
    return CGSize(width: randomWidth , height: randomHeight)
  }
  
  // MARK: - Constants -
  private let topContainerSpacing: CGFloat = 40
  private let randomRange = -2000..<2000
  private let deckWidth: CGFloat = 80
  private let deckHeigth: CGFloat = 60
  private let deckRotation: Double = 90
}

struct SetGameView_Previews: PreviewProvider {
  static var previews: some View {
    SetGameView(game: SetGameViewModel())
  }
}
