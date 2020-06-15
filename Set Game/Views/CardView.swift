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
      Spacer()
      symbol(for: card.number)
        .foregroundColor(self.color())
      Spacer()
    }
    .cardify(isFaceUp: true)
  }
  
  private func symbol(for number: Card.Number) -> some View {
    ForEach(0..<number.rawValue) { index in
      GeometryReader { geometry in
        self.symbol()
          .aspectRatio(CGSize(width: geometry.size.width, height: geometry.size.height * 0.25 * CGFloat((number.rawValue))), contentMode: .fit)
          .padding(self.symbolPadding)
          .position(geometry.center)
      }
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
      return AnyView(shape.stroke(lineWidth: strokeLineWidth))
    case .solid:
      return AnyView(shape.fill())
    case .striped:
      return AnyView(shape.opacity(0.3))
    }
  }
  
  // MARK: - Drawing Constants -
  
  private let strokeLineWidth: CGFloat = 2
  private let symbolPadding = EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card(color: .purple, number: .three, shading: .solid, symbol: .squiggle))
  }
}
