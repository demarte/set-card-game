//
//  Squiggle.swift
//  Set Game
//
//  Created by Ivan De Martino on 6/8/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct Squiggle: Shape {

  func path(in rect: CGRect) -> Path {
    let scaleFactor = rect.width / 107.8
    var path = Path()

    path.move(to: CGPoint(x: 104, y: 15))
    path.addCurve(
      to: CGPoint(x: 63.0, y: 54.0),
      control1: CGPoint(x: 112.4, y: 36.9),
      control2: CGPoint(x: 89.7, y: 60.8)
    )
    path.addCurve(
      to: CGPoint(x: 27.0, y: 53.0),
      control1: CGPoint(x: 52.3, y: 51.3),
      control2: CGPoint(x: 42.2, y: 42.0)
    )
    path.addCurve(
      to: CGPoint(x: 5.0, y: 40.0),
      control1: CGPoint(x: 9.6, y: 65.6),
      control2: CGPoint(x: 5.4, y: 58.3)
    )
    path.addCurve(
      to: CGPoint(x: 36.0, y: 12.0),
      control1: CGPoint(x: 4.6, y: 22.0),
      control2: CGPoint(x: 19.1, y: 9.7)
    )
    path.addCurve(
      to: CGPoint(x: 89.0, y: 14.0),
      control1: CGPoint(x: 59.2, y: 15.2),
      control2: CGPoint(x: 61.9, y: 31.5)
    )
    path.addCurve(
      to: CGPoint(x: 104.0, y: 15.0),
      control1: CGPoint(x: 95.3, y: 10.0),
      control2: CGPoint(x: 100.9, y: 6.9)
    )
    
    var transform = CGAffineTransform(translationX: offsetTranslationX, y: 0)
    transform = transform.scaledBy(x: scaleFactor, y: scaleFactor)
    path = path.applying(transform)
    
    return path
  }
  
  // MARK: - Drawing Constants -
  
  let offsetTranslationX: CGFloat = -5

}

struct Squiggle_Preview: PreviewProvider {
  static var previews: some View {
    Squiggle().stroke()
  }
}
