//
//  DoubleSwipeDownChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 6/10/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

import UIKit

class DoubleSwipeDownChallenge:SwipeDownChallenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "doubleSwipeDown"
    self.gestureInstruction = "Two finger swipe down!"
    self.challengeImage = "double-swipe-down.png"
    self.minimumNumberOfTouches = 2
  }
}
