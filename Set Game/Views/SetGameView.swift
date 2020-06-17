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
      HStack {
        Text("Score: \(game.score)")
          .font(Font.headline)
        Button("New Game") {
          withAnimation(.linear(duration: 2)) {
            game.newGame()
          }
        }
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
              .rotationEffect(Angle.degrees(90))
              .foregroundColor(Color.gray)
          }
        }
      }
      .onTapGesture {
        withAnimation(.easeInOut(duration: 1)) {
          self.game.dealMore()
        }
      }
      .frame(width: 80, height: 60)
    }
  }
  
  private func randomPositionsOffScreen() -> CGSize {
    let randomWidth = Int.random(in: -2000...2000)
    let randomHeight = Int.random(in: -2000..<2000)
    return CGSize(width: randomWidth , height: randomHeight)
  }
  
  // MARK: - Constants -
  
  private let screenWidth = UIScreen.main.bounds.width
  private let screenHeight = UIScreen.main.bounds.height
}

struct SetGameView_Previews: PreviewProvider {
  static var previews: some View {
    SetGameView(game: SetGameViewModel())
  }
}
