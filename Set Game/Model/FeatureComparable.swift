//
//  FeatureComparable.swift
//  Set Game
//
//  Created by Ivan on 13/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation


protocol FeatureComparable {
  
  associatedtype Feature: Equatable
  
  static func compare(first: Feature, second: Feature, third: Feature) -> Bool
}

extension FeatureComparable {
  static func compare(first: Feature, second: Feature, third: Feature) -> Bool {
    first == second && first == third && second == third || first != second && first != third && second != third
  }
}
