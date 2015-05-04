//
//  PinchOutChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 4/23/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

class PinchOutChallenge:Challenge {
  
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "pinchOut"
    self.gestureInstruction = "Pinch to zoom in"
    self.challengeImage = "pinch-out.png"
  }
  
}