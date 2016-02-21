//
//  Level1.swift
//  Cymon
//
//  Created by Paul Zaich on 4/24/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class Level1: LevelBase, Levelable {
  
  let totalChallenges = 12
  let levelDuration = 10
  let challengeScore = 10
  let challengeDistribution = [
    "tap": 0.5,
    "pinchOut": 0.25,
    "pinchIn": 0.25
  ]
  lazy var challenges:[Challenge]  = {
    return self.buildChallenges(self.totalChallenges, distribution: self.challengeDistribution)
  }()

}
