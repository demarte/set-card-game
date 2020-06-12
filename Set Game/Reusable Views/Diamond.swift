//
//  Diamond.swift
//  Set Game
//
//  Created by Ivan on 08/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct Diamond: Shape {
  
  func path(in rect: CGRect) -> Path {

    let height = rect.height * 0.65
    let left = CGPoint(x: rect.minX, y: rect.height / 2)
    let top = CGPoint(x: rect.width / 2, y: height)
    let right = CGPoint(x: rect.width, y: rect.height / 2)
    let bottom = CGPoint(x: rect.width / 2, y: rect.minY + (rect.height - height))

    var path = Path()
    path.addLines([left, top, right, bottom])
    path.closeSubpath()
    return path
  }
}

struct Diamond_Preview: PreviewProvider {
  static var previews: some View {
    Diamond().stroke()
  }
}
