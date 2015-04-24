//
//  Level.swift
//  Cymon
//
//  Created by Paul Zaich on 4/14/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation
import Dollar

class Level {
  init(level: Int) {
    self.level = level
  }

  var level:Int
  var levelDuration:Int = 60
  let challengeScore:Int = 10
  
  lazy var challenges:[Challenge] = {
    var placeholder:[Challenge] = []
    for i in 1...50 {
      if i % 2 == 0 {
        placeholder.append(Challenge(level: self, type: "tap"))
      } else {
        placeholder.append(Challenge(level: self, type: "pinch"))
      }
    }

    return $.shuffle(placeholder)
  }()
  
  private lazy var challengeDistribution:[String:Double] = {
    var distribution:[String:Double]?
    switch self.level {
    case 1:
      distribution = [
        "tap": 0.5,
        "pinch": 0.5
      ]
      break
    default: break
    }
    return distribution!
  }()
  
  lazy var scoreMultiplier:Double =
  {
    let multiplier:Double =  1.0 + (Double(self.level) * 0.1)
    return multiplier
  }()

}