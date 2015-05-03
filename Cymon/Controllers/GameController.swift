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
    gameStartCountDown()
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
  
  @IBOutlet weak var challengeBoard: UIView!
  
  @IBOutlet weak var challengeImage: UIImageView!
  @IBOutlet weak var challengeLabel: UILabel!
  @IBOutlet weak var gameheader: UIView!
  @IBOutlet weak var challengesRemainingLabel: UILabel!
  
  let game:Game = Game()
  
  @IBAction func cancel()
  {
    var refreshAlert = UIAlertController(title: "Quit game", message: "Are you sure you want to leave?", preferredStyle: UIAlertControllerStyle.Alert)
    
    refreshAlert.addAction(UIAlertAction(title: "Leave", style: .Default, handler: { (action: UIAlertAction!) in
        self.dismissViewControllerAnimated(true, completion: nil)
    }))
    
    refreshAlert.addAction(UIAlertAction(title: "Stay", style: .Default, handler: { (action: UIAlertAction!) in
        println("Handle Cancel Logic here")
    }))
    
    presentViewController(refreshAlert, animated: true, completion: nil)
  }
  
  func toggleGameElements()
  {
    gameheader.hidden = !gameheader.hidden
    challengeBoard.hidden = !challengeBoard.hidden
    gameTimeRemaining.hidden = !gameTimeRemaining.hidden
  }
  
  func setChallenge()
  {
    if let nextChallenge = game.nextChallenge() {
      
      challengeLabel.text = nextChallenge.gestureInstruction
      challengeImage.image = UIImage(named: nextChallenge.challengeImage!)

      let gestureRecognizer:UIGestureRecognizer? = {
        switch nextChallenge.gesture! {
        case "tap":
          println("tap")
          let gesture = UILongPressGestureRecognizer()
          gesture.minimumPressDuration = 0.01
          gesture.addTarget(self, action: "handleTapChallenge:")
          return gesture
        case "pinch":
          println("pinch!")
          return UIPinchGestureRecognizer()
        case "swipeUp":
          var gestureRecognizer = UISwipeGestureRecognizer()
          gestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
          return gestureRecognizer
        default:
          return nil
        }
      }()
    
      challengeBoard.addGestureRecognizer(gestureRecognizer!)
    } else {
      println("should call: level won!")
    }
  }
  
  func handleTapChallenge(sender: UILongPressGestureRecognizer) {
    let challenge = game.currentChallenge as! TapChallenge

    if sender.state == .Ended {
      challengeImage.image = UIImage(named: challenge.challengeImage!)
      onGestureSuccess()
    }
    
    if (sender.state == .Began) {
      println("lxxxxll")
      challengeImage.image = UIImage(named: challenge.challengeImageAnimation)
    }
    
  }
  
  func onGestureSuccess()
  {
    println("gesture success")
    appendScore(game.currentChallenge!)
    appendChallengesRemainingCount()
    removeOldGestures()
    
    // proceed to next challenge
    setChallenge()
  }
  
  func removeOldGestures() {
    for recognizer in challengeBoard.gestureRecognizers! {
      challengeBoard.removeGestureRecognizer(recognizer as! UIGestureRecognizer)
    }
  }
  
  func appendScore(challenge: Challenge)
  {
    var score:Int = gameScore.text!.toInt()!
    gameScore.text = "\(score + game.currentLevel!.challengeScore)"
  }
  
  func appendChallengesRemainingCount() {
    challengesRemainingLabel.text = "\(game.currentLevel!.challenges.count) left"
  }
  
  func initializeGame()
  {
    game.start()
    toggleGameElements()
    gameTimeRemaining.text = "\(game.duration)"
    gameTimeRemainingCountDown()
    appendChallengesRemainingCount()
    setChallenge()
  }
  
  func gameTimeRemainingCountDown()
  {
    countDown(gameTimeRemaining,
      timer: { () in
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "gameTimeRemainingCountDown", userInfo: nil, repeats: false)
      },
      callback: { () in
        println("game Over")
    })
  }
  
  func gameStartCountDown()
  {
    countDown(gameStartTimeRemaining,
      timer: { () in
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "gameStartCountDown", userInfo: nil, repeats: false)
      },
      callback: { () in
        self.initializeGame()
        self.gameStartTimeRemaining.hidden = true
    })
  }
  
  func countDown(label:UILabel, timer:() -> Void, callback:() -> Void)
  {
    let count = label.text!
    var newCount = count.toInt()! - 1
    
    if (newCount > 0 ) {
      label.text = "\(newCount)"
      timer()
    } else {
      callback()
    }
  }
  
}