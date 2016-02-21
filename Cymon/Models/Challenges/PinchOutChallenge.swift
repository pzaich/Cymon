//
//  PinchOutChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 4/23/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

//TODO rename image styles

class PinchOutChallenge:Challenge {
  
  override init(level: LevelBase)
  {
    super.init(level: level)
    self.gesture = "pinchOut"
    self.gestureInstruction = "Pinch inwards to zoom out"
    self.challengeImage = "pinch-in.png"
  }
  
}