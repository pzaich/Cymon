//
//  PinchChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 4/23/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class PinchChallenge:Challenge {
  
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "pinch"
    self.gestureInstruction = "Pinch screen"
    self.challengeImage = "pinch-out.png"
  }
  
  

}