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
  
  
  init(level:Level)
  {
    self.level = level
  }
  
  let level:Level
  let difficultyMultiplier:Double = 1.0
  var gesture:String?
  var gestureInstruction:String?
  var challengeImage:String?
  
  class func createChallenge (_ level:Level, type:String) -> Challenge {
    var challengeInstance:Challenge?
    switch type {
    case "tap":
      challengeInstance = TapChallenge(level: level)
    case "pinchOut":
      challengeInstance = PinchOutChallenge(level: level)
    case "pinchIn":
      challengeInstance = PinchInChallenge(level: level)
    case "swipeUp":
      challengeInstance = SwipeUpChallenge(level: level)
    default: break
    }
    return challengeInstance!
  }
  
}
