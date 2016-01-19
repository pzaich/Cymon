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
    let refreshAlert = UIAlertController(title: "Quit game", message: "Are you sure you want to leave?", preferredStyle: UIAlertControllerStyle.Alert)
    
    refreshAlert.addAction(UIAlertAction(title: "Leave", style: .Default, handler: { (action: UIAlertAction!) in
        self.dismissViewControllerAnimated(true, completion: nil)
    }))
    
    refreshAlert.addAction(UIAlertAction(title: "Stay", style: .Default, handler: { (action: UIAlertAction!) in
        print("Handle Cancel Logic here")
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
      print(nextChallenge.challengeImage!)
      challengeImage.image = UIImage(named: nextChallenge.challengeImage!)

      let gestureRecognizer:UIGestureRecognizer? = {
        switch nextChallenge.gesture! {
        case "tap":
          let gesture = UILongPressGestureRecognizer()
          gesture.minimumPressDuration = 0.01
          gesture.addTarget(self, action: "handleTapChallenge:")
          return gesture
        case "pinchOut":
          print("pinch out!")
          let gesture = UIPinchGestureRecognizer()
          gesture.addTarget(self, action: "handlePinchInChallenge:")
          return gesture
        case "pinchIn":
          print("pinch in!")
          let gesture = UIPinchGestureRecognizer()
          gesture.addTarget(self, action: "handlePinchOutChallenge:")
          return gesture
        case "swipeUp":
          let gestureRecognizer = UISwipeGestureRecognizer()
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
      print("should call: level won!")
    }
  }
  
  func handlePinchOutChallenge(sender: UIPinchGestureRecognizer) {
    if sender.state == .Began && Float(sender.scale) > 1.0 {
      let multiplier:Float = 1.5
      let transformScale = multiplier * Float(sender.scale)
      challengeImage.transform = CGAffineTransformScale(challengeImage.transform, CGFloat(transformScale), CGFloat(transformScale))
      sender.scale = 1
    }
    
    //reset initial scaling
    if sender.state == .Cancelled || sender.state == .Ended {
      challengeImage.transform = CGAffineTransformMakeScale(CGFloat(1.0), CGFloat(1.0))
    }
    
    if sender.state == .Ended && Float(sender.scale) > 2.0  {
      onGestureSuccess()
    } else {
      wiggle(challengeImage)
    }
  }
  
  func handlePinchInChallenge(sender: UIPinchGestureRecognizer) {
    if (sender.state == .Began) && (Float(sender.scale) < 1.0)  {
      let multiplier:Float = 5.0
      let transformScale = Float(sender.scale) / multiplier
      challengeImage.transform = CGAffineTransformScale(challengeImage.transform, CGFloat(transformScale), CGFloat(transformScale))
      sender.scale = 1
    }
    
    //reset initial scaling
    if sender.state == .Cancelled || sender.state == .Ended {
      challengeImage.transform = CGAffineTransformMakeScale(CGFloat(1.0), CGFloat(1.0))
    }
    
    if sender.state == .Ended && Float(sender.scale) < 0.8  {
      onGestureSuccess()
    } else {
      wiggle(challengeImage)
    }
  }
  
  func handleTapChallenge(sender: UILongPressGestureRecognizer) {
    let challenge = game.currentChallenge as! TapChallenge

    if sender.state == .Ended {
      challengeImage.image = UIImage(named: challenge.challengeImage!)
      onGestureSuccess()
    } else {
      wiggle(challengeImage)
    }
    
    if sender.state == .Began {
      challengeImage.image = UIImage(named: challenge.challengeImageAnimation)
    }
    
  }
  
  func onGestureSuccess()
  {
    print("gesture success")
    handleSuccess()
  }
  
  func removeOldGestures() {
    for recognizer in challengeBoard.gestureRecognizers! {
      challengeBoard.removeGestureRecognizer(recognizer)
    }
  }
  
  func appendScore(challenge: Challenge)
  {
    let score:Int = Int(gameScore.text!)!
    gameScore.text = "\(score + game.currentLevel!.challengeScore)"
  }
  
  func appendChallengesRemainingCount() {
    challengesRemainingLabel.text = "\(game.currentLevel!.challenges.count) left"
  }
  
  func wiggle( challengeImage: UIImageView ) {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.07
    animation.repeatCount = 2
    animation.autoreverses = true
    animation.fromValue = NSValue(CGPoint: CGPointMake(challengeImage.center.x - 5, challengeImage.center.y))
    animation.toValue = NSValue(CGPoint: CGPointMake(challengeImage.center.x + 5, challengeImage.center.y))
    challengeImage.layer.addAnimation(animation, forKey: "position")
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
        print("game Over")
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
    let newCount = Int(count)! - 1
    
    if (newCount > 0 ) {
      label.text = "\(newCount)"
      timer()
    } else {
      callback()
    }
  }
  
}