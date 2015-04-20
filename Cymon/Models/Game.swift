//
//  Game.swift
//  Cymon
//
//  Created by Paul Zaich on 4/14/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class Game {
  init() {
    
  }
  
  var nextLevel:Int = 1
  var currentLevel:Level? = nil
  let duration:Int = 60
  
  func start()
  {
    self.currentLevel = Level(level: nextLevel)
  }
}