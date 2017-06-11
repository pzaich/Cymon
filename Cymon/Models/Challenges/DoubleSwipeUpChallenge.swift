//
//  DoubleSwipeUpChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 6/10/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

import UIKit

class DoubleSwipeUpChallenge:SwipeUpChallenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "doubleSwipeUp"
    self.gestureInstruction = "Two finger swipe up!"
    self.challengeImage = "double-swipe-up.png"
    self.minimumNumberOfTouches = 2
  }
}
