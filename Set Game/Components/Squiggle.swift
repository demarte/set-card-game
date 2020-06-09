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
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let height = rect.height * 0.65

    let radius = rect.height / 4
    let startPoint = CGPoint(x: center.x, y: center.y + radius)
    var path = Path()

//    path.move(to: center)
//    path.move(to: startPoint)
    path.addArc(
      center: CGPoint(x: rect.width * 0.25, y: rect.height * 0.25),
      radius: rect.width * 0.25,
      startAngle: Angle.degrees(0),
      endAngle: Angle.degrees(180),
      clockwise: true
    )

    path.addLine(to: center)

//    path.addCurve(
//      to: CGPoint(x: rect.midX, y: rect.maxY * 0.7),
//      control1: CGPoint(x: rect.maxX * 0.9, y: rect.maxY * 0.8),
//      control2: CGPoint(x: rect.maxX * 0.7, y: rect.maxY * 0.8)
//    )
//
//    path.addCurve(
//      to: CGPoint(x: rect.maxX * 0.1, y: rect.maxY * 0.8),
//      control1: CGPoint(x: rect.maxX * 0.2, y: rect.maxY * 0.5),
//      control2: CGPoint(x: rect.maxX * 0.4, y: rect.maxY * 0.6)
//    )



//    path.addCurve(
//      to: CGPoint(x: rect.minX, y: rect.midY),
//      control1: CGPoint(x: rect.midX * 0.75, y: rect.midY * 0.5 - 20),
//      control2: CGPoint(x: rect.midX * 0.25, y: rect.midY * 0.5 + 10))

//    path.addCurve(
//      to: CGPoint(x: rect.midX * 0.25, y: rect.midY + rect.midY * 0.5),
//      control1: CGPoint(x: rect.minX, y: rect.midY + 50),
//      control2: CGPoint(x: rect.minX, y: rect.midY + 80))

//    path.addCurve(
//      to: CGPoint(x: rect.midX, y: rect.midY + rect.midY * 0.3), control1: CGPoint(x: rect.midX * 0.2, y: rect.midY + rect.midY * 0.2),
//      control2: CGPoint(x: rect.midX * 0.4, y: rect.midY + rect.midY * 0.2))


    var transform = CGAffineTransform(translationX: rect.midX, y: 0)
    //    transform = transform.scaledBy(x: 1, y: -1)
    //    path.addPath(path, transform: transform)



    //    path.addLine(to: CGPoint(x: rect.midX, y: height))
    //    path.addArc(
    //      center: center,
    //      radius: radius,
    //      startAngle: Angle.degrees(0 - 90),
    //      endAngle: Angle.degrees(270 - 90),
    //      clockwise: true
    //    )
    //    path.move(to: center)
    //    path.addArc(
    //      center: CGPoint(x: rect.midX, y: height + radius),
    //      radius: radius,
    //      startAngle: Angle.degrees(0 - 90),
    //      endAngle: Angle.degrees(270 - 90),
    //      clockwise: false
    //    )
    //    path.move(to: CGPoint(x: rect.midX, y: rect.minY + radius))
    //    path.addArc(
    //          center: CGPoint(x: rect.midX, y: height + radius),
    //          radius: radius,
    //          startAngle: Angle.degrees(0 - 90),
    //          endAngle: Angle.degrees(270 - 90),
    //          clockwise: false
    //        )
    return path
  }

}

struct Squiggle_Preview: PreviewProvider {
  static var previews: some View {
    Squiggle()
  }
}
