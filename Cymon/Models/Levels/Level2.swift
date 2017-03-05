//
//  Level2.swift
//  Cymon
//
//  Created by Paul Zaich on 4/24/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class Level2:Level {
  
  override init() {
    super.init()
    self.duration = 10
    self.challengeScore = 11
    self.totalChallenges = 15
    self.challengeDistribution = [
      "tap": 0.25,
      "pinchOut": 0.25,
      "pinchIn": 0.25,
      "swipeUp": 0.25
    ]
  }
}
