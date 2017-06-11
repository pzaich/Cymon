//
//  Turn.swift
//  Cymon
//
//  Created by Paul Zaich on 4/16/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation
import UIKit

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
    case "swipeDown":
      challengeInstance = SwipeDownChallenge(level: level)
    case "swipeLeft":
      challengeInstance = SwipeLeftChallenge(level: level)
    case "swipeRight":
      challengeInstance = SwipeRightChallenge(level: level)
    case "doubleSwipeUp":
      challengeInstance = DoubleSwipeUpChallenge(level: level)
    case "doubleSwipeDown":
      challengeInstance = DoubleSwipeDownChallenge(level: level)
    case "doubleSwipeLeft":
      challengeInstance = DoubleSwipeLeftChallenge(level: level)
    case "doubleSwipeRight":
      challengeInstance = DoubleSwipeRightChallenge(level: level)
    default: break
    }
    return challengeInstance!
  }
  
  func handler(_ sender:UIGestureRecognizer, challengeImage:UIImageView, onSuccess:() -> Void, onFail:(_ challengeImage:UIImageView) -> Void) {
    print("Not Implemented")
  }
  
}
