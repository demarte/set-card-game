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
  var deckPosition: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
  
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
          .shake(times: game.mismatch ? 1 : 0)
          .foregroundColor(self.borderColor(for: card))
          .scaleEffect(card.isSelected ? 1.03 : 1)
          .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
              game.choose(card: card)
            }
        }
      }
      ZStack {
        if !self.game.deck.isEmpty {
          ForEach(self.game.deck.reversed()) { card in
            self.deckView(for: card)
              .rotationEffect(Angle.degrees(90))
              .foregroundColor(Color.gray)
          }
        }
      }
      .onTapGesture {
        withAnimation(.easeInOut(duration: 1)) {
          self.game.dealMoreCards()
        }
      }
    }.onAppear {
      withAnimation(.easeInOut(duration: 2)) {
        game.placeCards()
      }
    }
  }

  private mutating func deckView(for card: Card) -> some View {
    GeometryReader { geometry -> CardView in
      self.deckPosition = geometry.frame(in: CoordinateSpace.global)
      print(self.deckPosition)
      return CardView(card: card)
    }
    .frame(width: 60, height: 80)
  }

  private func borderColor(for card: Card) -> Color {
    print(CoordinateSpace.local)
    if card.isSelected {
      return game.mismatch ? Color.red : Color.blue
    } else {
      return Color.gray
    }
  }

  var borderColor: Color {
    game.mismatch ? Color.red : Color.gray
  }

  private func randomPositionsOffScreen() -> CGSize {
    let randomWidth = Int.random(in: -2000...2000)
    let randomHeight = Int.random(in: -2000..<2000)

    return CGSize(width: randomWidth , height: randomHeight)
  }
}

struct SetGameView_Previews: PreviewProvider {
  static var previews: some View {
    SetGameView(game: SetGameViewModel())
  }
}

struct DeckView: View {
  var game: SetGameViewModel

  var body: some View {
    GeometryReader { geometry in
      VStack {
        ZStack {
          if !self.game.deck.isEmpty {
            ForEach(self.game.deck.reversed()) { card in
              CardView(card: card)
                .rotationEffect(Angle.degrees(90))
                .frame(width: 60, height: 80)
                .foregroundColor(Color.gray)
            }
          }
        }
        .onTapGesture {
          withAnimation(.easeInOut(duration: 1)) {
            self.game.dealMoreCards()
          }
        }
        Text("\(geometry.frame(in: CoordinateSpace.global).origin.x), \(geometry.frame(in: CoordinateSpace.global).origin.y), \(geometry.frame(in: CoordinateSpace.global).size.width), \(geometry.frame(in: CoordinateSpace.global).size.height)")
      }
    }
  }
}
