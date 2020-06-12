//
//  Oval.swift
//  Set Game
//
//  Created by Ivan on 11/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct Oval: View {
  var body: some View {
    GeometryReader { geometry in
      Capsule()
        .frame(
          width: geometry.size.width * 0.8,
          height: geometry.size.width * 0.35
      )
    }
  }
}

struct Oval_Previews: PreviewProvider {
  static var previews: some View {
    Oval()
  }
}
