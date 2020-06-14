//
//  GeometryProxy+Center.swift
//  Set Game
//
//  Created by Ivan on 14/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

extension GeometryProxy {
  var center: CGPoint {
    CGPoint(x: self.size.width / 2, y: self.size.height / 2)
  }
}
