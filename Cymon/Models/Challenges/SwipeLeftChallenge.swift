//
//  SwipeLeftChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 6/10/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

import UIKit

class SwipeLeftChallenge:SwipeChallenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "swipeLeft"
    self.gestureInstruction = "Swipe left!"
    self.challengeImage = "swipe-left.png"
    self.minimumNumberOfTouches = 1
    self.coordinate = "x"
  }
  
  let distanceThreshold:CGFloat = -150.0
  
  override func isGestureSuccess() -> Bool {
    return distanceTraveled < distanceThreshold
  }
}
