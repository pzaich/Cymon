//
//  Level4.swift
//  Cymon
//
//  Created by Paul Zaich on 6/12/17.
//  Copyright © 2017 Paul Zaich. All rights reserved.
//

import Foundation

class Level4:Level {
  
  override init() {
    super.init()
    self.duration = 40
    self.challengeScore = 40
    self.totalChallenges = 12
    self.challengeDistribution = [
      "pinchOut":  0.2,
      "pinchIn": 0.2,
      "swipeUp": 0.1,
      "swipeDown": 0.2,
      "swipeLeft": 0.1,
      "swipeRight": 0.2,
    ]
  }
}
