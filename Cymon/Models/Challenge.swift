//
//  Turn.swift
//  Cymon
//
//  Created by Paul Zaich on 4/16/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

//convert to protocol
class Challenge {
  
  
  init(level:LevelBase)
  {
    self.level = level
  }
  
  let level:LevelBase
  let difficultyMultiplier:Double = 1.0
  var gesture:String?
  var gestureInstruction:String?
  var challengeImage:String?
  
  class func createChallenge (level:LevelBase, type:String) -> Challenge {
    var challengeInstance:Challenge?
    switch type {
    case "tap":
      challengeInstance = TapChallenge(level: level)
    case "pinchOut":
      challengeInstance = PinchOutChallenge(level: level)
    case "pinchIn":
      challengeInstance = PinchInChallenge(level: level)
    default: break
    }
    return challengeInstance!
  }
  
}