//
//  Level.swift
//  Cymon
//
//  Created by Paul Zaich on 4/14/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class Level {
  init(level: Int) {
    self.level = level
  }

  var level:Int
  var levelDuration:Int = 60
  var currentChallenge:Challenge? = nil
  
  lazy var challenges:[Challenge] = {
    var placeholder:[Challenge] = []
    for i in 1...50 {
      placeholder.append(Challenge())
    }
    return placeholder
  }()
  
  lazy var scoreMultiplier:Double =
  {
    let multiplier:Double =  1.0 + (Double(self.level) * 0.1)
    return multiplier
  }()
  
  func begin()
  {
//    self.challenges.
  }
  
}