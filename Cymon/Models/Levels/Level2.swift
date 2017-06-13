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
    self.duration = 40
    self.challengeScore = 20
    self.totalChallenges = 15
    self.challengeDistribution = [
      "swipeDown": 0.25,
      "swipeLeft": 0.25,
      "swipeRight": 0.25,
      "swipeUp": 0.25
    ]
  }
}
