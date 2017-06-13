//
//  Level3.swift
//  Cymon
//
//  Created by Paul Zaich on 6/12/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

class Level3:Level {
  
  override init() {
    super.init()
    self.duration = 40
    self.challengeScore = 30
    self.totalChallenges = 12
    self.challengeDistribution = [
      "tap": 0.2,
      "pinchOut":  0.1,
      "pinchIn": 0.1,
      "swipeUp": 0.2,
      "swipeDown": 0.2,
      "swipeLeft": 0.1,
      "swipeRight": 0.1,
    ]
  }
}
