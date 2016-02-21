//
//  Level.swift
//  Cymon
//
//  Created by Paul Zaich on 4/14/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class LevelFactory {
  
  class func createLevel (level:Int)-> LevelBase
  {
    var levelInstance:LevelBase?
      switch level {
        case 1:
          levelInstance = Level1()
          break;
        case 2:
          levelInstance = Level2()
      default: break
    }
    return levelInstance!
  }
}