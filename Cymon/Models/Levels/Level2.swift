//
//  Level2.swift
//  Cymon
//
//  Created by Paul Zaich on 4/24/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class Level2: LevelBase, Levelable {
  
  let totalChallenges = 12
  let levelDuration = 20
  let challengeScore = 20
  let challengeDistribution = [
    "tap": 0.5,
    "pinchOut": 0.25,
    "pinchIn": 0.25
  ]
  lazy var challenges:[Challenge]  = {
    return self.buildChallenges(self.totalChallenges, distribution: self.challengeDistribution)
  }()
  
//  override init() {
//    super.init()
//    
//    self.challengeScore = 20
//
//    self.challengeDistribution = [
//      "tap": 0.5,
//      "pinchOut": 0.25,
//      "pinchIn": 0.25
//    ]
//  }
}
