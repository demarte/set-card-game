//
//  CardView.swift
//  Set Game
//
//  Created by Ivan on 11/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct CardView: View {
  
  var card: Card
  
  var body: some View {
    body(for: card)
  }
  
  @ViewBuilder
  private func body(for card: Card) -> some View {
    VStack {
      symbol(for: card.number)
        .foregroundColor(self.color())
      .padding(2)
    }
    .cardify(isFaceUp: true)
    .foregroundColor(card.isSelected ? Color.blue : Color.black)
    .scaleEffect(card.isSelected ? 1.1 : 1)
    .animation(Animation.easeIn(duration: 0.1))
  }
  
  private func symbol(for number: Card.Number) -> some View {
    ForEach(0..<Card.Number.allCases.count) { index in
      self.symbol()
        .aspectRatio(5, contentMode: .fit)
//        .opacity(number.rawValue == index + 1 ? 1 : 0)
      .padding(2)
    }
  }
  
  private func symbol() -> some View {
    switch card.symbol {
    case .diamond:
      return AnyView(shading(for: Diamond()))
    case .oval:
      return AnyView(shading(for: Capsule()))
    case .squiggle:
      return AnyView(shading(for: Squiggle()))
    }
  }
  
  private func color() -> Color {
    switch card.color {
    case .green:
      return Color.green
    case .purple:
      return Color.purple
    case .red:
      return Color.red
    }
  }
  
  private func shading<T : Shape>(for shape: T) -> some View {
    switch card.shading {
    case .open:
      return AnyView(shape.stroke())
    case .solid:
      return AnyView(shape.fill())
    case .striped:
      return AnyView(shape.opacity(0.3))
    }
  }
}
