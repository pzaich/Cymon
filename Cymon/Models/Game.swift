//
//  Game.swift
//  Cymon
//
//  Created by Paul Zaich on 4/14/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class Game {
  
  var nextLevel:Int = 1
  var currentLevel:LevelBase?
  var currentChallenge:Challenge?

  let duration:Int = 10
  
  func start()
  {
    self.currentLevel = LevelFactory.createLevel(nextLevel)
    self.nextLevel += 1
    
    print(nextLevel)
  }
  
  func nextChallenge() -> Challenge?
  {
    if currentLevel!.challenges.count > 0 {
      self.currentChallenge = currentLevel!.challenges.removeAtIndex(0)
    } else {
      self.currentChallenge = nil
    }
    return self.currentChallenge
  }
}