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
      println(nextChallenge.challengeImage!)
      challengeImage.image = UIImage(named: nextChallenge.challengeImage!)

      let gestureRecognizer:UIGestureRecognizer? = {
        switch nextChallenge.gesture! {
        case "tap":
          let gesture = UILongPressGestureRecognizer()
          gesture.minimumPressDuration = 0.01
          gesture.addTarget(self, action: "handleTapChallenge:")
          return gesture
        case "pinchOut":
          println("pinch out!")
          let gesture = UIPinchGestureRecognizer()
          gesture.addTarget(self, action: "handlePinchOutChallenge:")
          return gesture
        case "pinchIn":
          println("pinch in!")
          let gesture = UIPinchGestureRecognizer()
          gesture.addTarget(self, action: "handlePinchInChallenge:")
          return gesture
        case "swipeUp":
          var gestureRecognizer = UISwipeGestureRecognizer()
          gestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
          return gestureRecognizer
        default:
          return nil
        }
      }()
      
      if let gesture = gestureRecognizer {
        challengeBoard.addGestureRecognizer(gesture)
      }
    } else {
      println("should call: level won!")
    }
  }
  
  func handlePinchOutChallenge(sender: UIPinchGestureRecognizer) {
    if sender.state == .Began && Float(sender.scale) > 1.0 {
      let multiplier:Float = 1.5
      let transformScale = Float(multiplier) * Float(sender.scale)
      challengeImage.transform = CGAffineTransformScale(challengeImage.transform, CGFloat(transformScale), CGFloat(transformScale))
      sender.scale = 1
    }
    
    //reset initial scaling
    if sender.state == .Cancelled || sender.state == .Ended {
      challengeImage.transform = CGAffineTransformMakeScale(CGFloat(1.0), CGFloat(1.0))
      println("reset scaling")
    }
    
    if sender.state == .Ended && Float(sender.scale) > 2.0  {
      onGestureSuccess()
    }
  }
  
  func handlePinchInChallenge(sender: UIPinchGestureRecognizer) {
    if (sender.state == .Began) && (Float(sender.scale) < 1.0)  {
      let multiplier:Float = 1.5
      let transformScale = Float(multiplier) / Float(sender.scale)
      challengeImage.transform = CGAffineTransformScale(challengeImage.transform, CGFloat(transformScale), CGFloat(transformScale))
      sender.scale = 1
    }
    
    //reset initial scaling
    if sender.state == .Cancelled || sender.state == .Ended {
      challengeImage.transform = CGAffineTransformMakeScale(CGFloat(1.0), CGFloat(1.0))
      println("reset scaling")
    }
    
    if sender.state == .Ended && Float(sender.scale) < 0.5  {
      onGestureSuccess()
    }
  }
  
  func handleTapChallenge(sender: UILongPressGestureRecognizer) {
    let challenge = game.currentChallenge as! TapChallenge

    if sender.state == .Ended {
      challengeImage.image = UIImage(named: challenge.challengeImage!)
      onGestureSuccess()
    }
    
    if sender.state == .Began {
      println("lxxxxll")
      challengeImage.image = UIImage(named: challenge.challengeImageAnimation)
    }
    
  }
  
  func onGestureSuccess()
  {
    println("gesture success")
    handleSuccess()
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
  
  func handleSuccess() {
    appendScore(game.currentChallenge!)
    appendChallengesRemainingCount()
    removeOldGestures()
    setChallenge()
    
//    [UIView animateWithDuration:1.0 animations:^{
//      view.backgroundColor = [UIColor redColor];
//      }];
//    toggleGameElements()
//    let originalColor = view.backgroundColor
    
//    UIView.animateWithDuration(2.0, delay: 0, options: .CurveEaseInOut, animations: {
////      self.view.backgroundColor = UIColor(red: CGFloat(0.976), green: CGFloat(0.91), blue: CGFloat(0.337), alpha: CGFloat(0.5))
//    }, completion: { finished in
//      // proceed to next challenge
//      self.setChallenge()
////      self.view.backgroundColor = originalColor
//    })
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