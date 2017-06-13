//
//  Level1.swift
//  Cymon
//
//  Created by Paul Zaich on 4/24/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

class Level1:Level {
  
  override init() {
    super.init()
    self.duration = 40
    self.challengeScore = 10
    self.totalChallenges = 12
    self.challengeDistribution = [
      "tap": 0.5,
      "swipeRight": 0.25,
      "swipeLeft": 0.25
    ]
  }
}
