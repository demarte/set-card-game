//
//  Cardify.swift
//  Set Game
//
//  Created by Ivan on 11/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
  
  var rotation: Double
  
  var isFaceUp: Bool {
    rotation < 90
  }
  
  var animatableData: Double {
    get { rotation }
    set { rotation = newValue }
  }
  
  init(isFaceUp: Bool) {
    rotation = isFaceUp ? 0 : 180
  }
  
  func body(content: Content) -> some View {
    ZStack {
      Group {
        RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
        RoundedRectangle(cornerRadius: cardCornerRadius).stroke(lineWidth: borderWidth)
        content
      }
        .opacity(isFaceUp ? 1 : 0)
      RoundedRectangle(cornerRadius: cardCornerRadius).fill()
        .opacity(isFaceUp ? 0 : 1)
    }
    .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
  }
  
  // MARK: - Drawing Constants -
  
  private let cardCornerRadius: CGFloat = 10
  private let borderWidth: CGFloat = 2
  
}

extension View {
  func cardify(isFaceUp: Bool) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp))
  }
}
