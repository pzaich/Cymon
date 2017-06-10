//
//  SwipeDownChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 6/9/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

import UIKit

class SwipeDownChallenge:SwipeChallenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "swipeDown"
    self.gestureInstruction = "Swipe down!"
    self.challengeImage = "swipe-down.png"
    self.minimumNumberOfTouches = 1
  }
  
  let distanceThreshold:CGFloat = 250.0

  override func isGestureSuccess() -> Bool {
    return distanceTraveled > distanceThreshold
  }
}
