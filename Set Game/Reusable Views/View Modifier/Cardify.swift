//
//  Cardify.swift
//  Set Game
//
//  Created by Ivan on 11/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
  
  var isFaceUp: Bool
  
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
  }
  
  // MARK: - Drawing Constants -
  
  let cardCornerRadius: CGFloat = 10
  let borderWidth: CGFloat = 3
  
}

extension View {
  func cardify(isFaceUp: Bool) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp))
  }
}
