//
//  SwipeRightChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 5/1/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

class SwipeRightChallenge:Challenge {
  override init(level: Level)
  {
    super.init(level: level)
    self.gesture = "swipeRight"
    self.gestureInstruction = "Swipe right!"
    self.challengeImage = "swipe-up.png"
  }
}