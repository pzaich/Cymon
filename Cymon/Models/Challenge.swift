//
//  Turn.swift
//  Cymon
//
//  Created by Paul Zaich on 4/16/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class Challenge {
  
  
  init(level:Level)
  {
    self.level = level
  }
  
  let level:Level
  let difficultyMultiplier:Double = 1.0
  var gesture:String?
  var gestureInstruction:String?
//  let challengeImage:String
  
  class func createChallenge (level:Level, type:String) -> Challenge {
    var challengeInstance:Challenge?
    switch type {
    case "tap":
      challengeInstance = TapChallenge(level: level)
    case "pinch":
      challengeInstance = PinchChallenge(level: level)
    default: break
    }
    return challengeInstance!
  }
  
}