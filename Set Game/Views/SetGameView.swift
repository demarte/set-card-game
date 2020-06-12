//
//  SetGameView.swift
//  Set Game
//
//  Created by Ivan on 08/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
  
  @ObservedObject var game: SetGameViewModel
  
  var body: some View {
    VStack {
      Grid(game.placeCards()) { card in
        CardView(card: card)
        .padding()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    SetGameView(game: SetGameViewModel())
  }
}
