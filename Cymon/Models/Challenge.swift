//
//  Turn.swift
//  Cymon
//
//  Created by Paul Zaich on 4/16/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

// gesture

class Challenge {

  
  init(level:Level, type:String)
  {
    self.level = level
    self.gesture = type
  }
  
  let level:Level
  let difficultyMultiplier:Double = 1.0
//  let challengeImage:String
  let gesture:String
  lazy var gestureInstruction:String = {
    switch self.gesture {
      case "tap":
        return "Tap anywhere"
      case "pinch":
        return "Pinch anywhere"
      default:
        return ""
    }
  }()
  
}