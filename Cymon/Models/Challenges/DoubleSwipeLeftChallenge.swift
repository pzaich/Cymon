//
//  DoubleSwipeLeftChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 6/10/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

import UIKit

class DoubleSwipeLeftChallenge:SwipeLeftChallenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "doubleSwipeLeft"
    self.gestureInstruction = "Two finger swipe left!"
    self.challengeImage = "double-swipe-left.png"
    self.minimumNumberOfTouches = 2
    self.coordinate = "x"
  }
}
