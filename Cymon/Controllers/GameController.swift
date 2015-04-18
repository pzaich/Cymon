//
//  GameController.swift
//  Cymon
//
//  Created by Paul Zaich on 4/13/15.
//  Copyright (c) 2015 Paul Zaich. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    countDown()
    toggleGameElements()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBOutlet weak var gameScore: UILabel!
  @IBOutlet weak var gameStartTimeRemaining: UILabel!
  @IBOutlet weak var homeButton: UIButton!
  
  @IBOutlet weak var gameTimeRemaining: UILabel!
  
  var game:Game = Game()
  
  @IBAction func cancel() {
    var refreshAlert = UIAlertController(title: "Quit game", message: "Are you sure you want to leave?", preferredStyle: UIAlertControllerStyle.Alert)
    
    refreshAlert.addAction(UIAlertAction(title: "Leave", style: .Default, handler: { (action: UIAlertAction!) in
        self.dismissViewControllerAnimated(true, completion: nil)
    }))
    
    refreshAlert.addAction(UIAlertAction(title: "Stay", style: .Default, handler: { (action: UIAlertAction!) in
        println("Handle Cancel Logic here")
    }))
    
    presentViewController(refreshAlert, animated: true, completion: nil)
  }
  
  
  func toggleGameElements() {
    gameScore.hidden  = !gameScore.hidden
    homeButton.hidden = !homeButton.hidden
    gameTimeRemaining.hidden = !gameTimeRemaining.hidden
  }
  
  func setChallenge() {
    
  }
  
  func initializeGame() {
    game.start()
    toggleGameElements()
  }
  
  func countDown() {
    let count = gameStartTimeRemaining.text!
    var newCount = count.toInt()! - 1
    
    if (newCount > 0 ) {
      gameStartTimeRemaining.text = "\(newCount)"
      NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: false)
    } else {
      initializeGame()
      gameStartTimeRemaining.hidden = true
    }
  }

}


