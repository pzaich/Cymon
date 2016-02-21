//
//  SwipeUpChallenge.swift
//  Cymon
//
//  Created by Paul Zaich on 5/1/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

class SwipeUpChallenge:Challenge {
  override init(level: LevelBase)
  {
    super.init(level: level)
    self.gesture = "swipeUp"
    self.gestureInstruction = "Swipe up!"
    self.challengeImage = "swipe-up.png"
  }
}