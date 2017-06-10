//
//  SwipeUpChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 5/1/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//
import UIKit

class SwipeUpChallenge:SwipeChallenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "swipeUp"
    self.gestureInstruction = "Swipe up!"
    self.challengeImage = "swipe-up.png"
  }
  
  let distanceThreshold:CGFloat = -250.0
  
  override func isGestureSuccess() -> Bool {
    return distanceTraveled < distanceThreshold
  }
}
