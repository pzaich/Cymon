//
//  DoubleSwipeRightChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 6/10/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

import UIKit

class DoubleSwipeRightChallenge:SwipeRightChallenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "doubleSwipeRight"
    self.gestureInstruction = "Two finger Swipe right!"
    self.challengeImage = "double-swipe-right.png"
    self.minimumNumberOfTouches = 2
    self.coordinate = "x"
  }
}
