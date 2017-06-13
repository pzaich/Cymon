//
//  Level5.swift
//  Cymon
//
//  Created by Paul Zaich on 6/12/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

class Level5:Level {
  
  override init() {
    super.init()
    self.duration = 40
    self.challengeScore = 50
    self.totalChallenges = 12
    self.challengeDistribution = [
      "tap": 0.1,
      "pinchOut":  0.1,
      "pinchIn": 0.1,
      "swipeUp": 0.1,
      "swipeDown": 0.1,
      "swipeLeft": 0.1,
      "swipeRight": 0.1,
      "doubleSwipeDown": 0.05,
      "doubleSwipeUp": 0.05,
      "doubleSwipeLeft": 0.1,
      "doubleSwipeRight": 0.1
    ]
  }
}
