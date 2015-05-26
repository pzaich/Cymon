//
//  Level1.swift
//  Cymon
//
//  Created by Paul Zaich on 4/24/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class Level1:Level {
  
  override init() {
    super.init()
    self.challengeDistribution = [
      "tap": 0.5,
      "pinchOut": 0.25,
      "pinchIn": 0.25
    ]
  }
}
