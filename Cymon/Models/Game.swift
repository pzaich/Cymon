//
//  Game.swift
//  Cymon
//
//  Created by Paul Zaich on 4/14/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import Foundation

class Game {
  
  static var currentGame:Game?
  
  class func createOrGetCurrent() -> Game {
    if let game = currentGame {
      return game
    } else {
      let game = Game()
      self.currentGame = game
      return game
    }
    
  }
  
  class func releaseCurrent() {
    currentGame = nil
  }
  
  var nextLevel:Int = 0
  var currentLevel:Level?
  var currentChallenge:Challenge?
  
  func getNextLevel() {
    self.nextLevel += 1
    self.currentLevel = Level.createLevel(nextLevel)
  }
  
  func start()
  {
    self.getNextLevel()
  }
  
  func nextChallenge() -> Challenge?
  {
    if currentLevel!.challenges.count > 0 {
      self.currentChallenge = currentLevel!.challenges.remove(at: 0)
    } else {
      self.currentChallenge = nil
    }
    return self.currentChallenge
  }
}
