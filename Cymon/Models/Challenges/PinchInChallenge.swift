//
//  PinchInChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 5/3/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

//
//  PinchInChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 4/23/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

class PinchInChallenge:Challenge {
  
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "pinchIn"
    self.gestureInstruction = "Pinch to Zoom out"
    self.challengeImage = "pinch-out.png"
  }
  
}