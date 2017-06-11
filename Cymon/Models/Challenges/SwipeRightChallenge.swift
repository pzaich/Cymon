//
//  SwipeRightChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 5/1/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//
import UIKit

class SwipeRightChallenge:SwipeChallenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "swipeRight"
    self.gestureInstruction = "Swipe right!"
    self.challengeImage = "swipe-right.png"
    self.minimumNumberOfTouches = 1
    self.coordinate = "x"
  }
  
  let distanceThreshold:CGFloat = 150.0
  
  override func isGestureSuccess() -> Bool {
    return distanceTraveled > distanceThreshold
  }
}
