//
//  CardView.swift
//  Set Game
//
//  Created by Ivan on 11/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct CardView: View {

  @State private var animatedBonusRemaining: Double = 0
  var card: Card
  
  var body: some View {
    body(for: card)
  }

  private func startBonusTimeAnimation() {
    animatedBonusRemaining = card.bonusRemaining
    withAnimation(.linear(duration: card.bonusTimeRemaining)) {
      animatedBonusRemaining = 0
    }
  }
  
  @ViewBuilder
  private func body(for card: Card) -> some View {
    VStack {
      if card.isConsumingBonusTime {
        Pie(
          startAngle: Angle.degrees(0 - 90),
          endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90),
          clockwise: true
        )
        .onAppear {
          self.startBonusTimeAnimation()
        }
      }
      symbol(for: card.number)
        .foregroundColor(self.color())
    }
    .cardify(isFaceUp: card.isFaceUp)
    .aspectRatio(self.cardAspectRatio, contentMode: .fit)
    .foregroundColor(borderColor(for: card))
    .shake(times: card.misMatch ? 1 : 0)

  }

  private func borderColor(for card: Card) -> Color {
    if card.misMatch {
      return Color.red
    } else {
      return card.isSelected ? Color.blue : Color.gray
    }
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
      return AnyView(shape.opacity(stripedOpcity))
    }
  }
  
  // MARK: - Drawing Constants -
  
  private let stripedOpcity: Double = 0.3
  private let strokeLineWidth: CGFloat = 1
  private let symbolPadding = EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
  private let cardAspectRatio: CGFloat = 0.75
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    var card = Card(color: .purple, number: .three, shading: .solid, symbol: .squiggle)
    card.isFaceUp = true
    return CardView(card: card)
  }
}
