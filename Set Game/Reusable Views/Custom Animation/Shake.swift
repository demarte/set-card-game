//
//  Shake.swift
//  Set Game
//
//  Created by Ivan De Martino on 6/15/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct Shake: GeometryEffect {

  private var position: CGFloat
  private let amount: CGFloat = 10
  private let shakesPerUnit: CGFloat = 3

  var animatableData: CGFloat {
    get { position }
    set { position = newValue }
  }

  init(shakes: Int) {
    self.position = CGFloat(shakes)
  }

  func effectValue(size: CGSize) -> ProjectionTransform {
    let transform = CGAffineTransform(translationX:
    amount * sin(position * .pi * shakesPerUnit),
    y: 0)
    return ProjectionTransform(transform)
  }
}

extension View {
  func shake(times: Int) -> some View {
    self.modifier(Shake(shakes: times))
  }
}
