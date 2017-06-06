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
    
    game = Game.createOrGetCurrent()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    print("closing game controller")
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
  
  @IBOutlet weak var simonHead: UIImageView!
  
  // ivars
  var game:Game!
  
  @IBAction func cancel()
  {
    let refreshAlert = UIAlertController(title: "Quit game", message: "Are you sure you want to leave?", preferredStyle: UIAlertControllerStyle.alert)
    
    refreshAlert.addAction(UIAlertAction(title: "Leave", style: .default, handler: { (action: UIAlertAction!) in
        self.dismiss(animated: true, completion: nil)
    }))
    
    refreshAlert.addAction(UIAlertAction(title: "Stay", style: .default, handler: { (action: UIAlertAction!) in
        print("Handle Cancel Logic here")
    }))
    
    present(refreshAlert, animated: true, completion: nil)
  }
  
  func toggleGameElements()
  {
    gameheader.isHidden = !gameheader.isHidden
    challengeBoard.isHidden = !challengeBoard.isHidden
    gameTimeRemaining.isHidden = !gameTimeRemaining.isHidden
    simonHead.isHidden = true
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
          gesture.addTarget(self, action: #selector(GameController.handleTapChallenge(_:)))
          return gesture
        case "pinchOut":
          print("pinch out!")
          let gesture = UIPinchGestureRecognizer()
          gesture.addTarget(self, action: #selector(GameController.handlePinchInChallenge(_:)))
          return gesture
        case "pinchIn":
          print("pinch in!")
          let gesture = UIPinchGestureRecognizer()
          gesture.addTarget(self, action: #selector(GameController.handlePinchOutChallenge(_:)))
          return gesture
        case "swipeUp":
          let gestureRecognizer = UIPanGestureRecognizer()
          gestureRecognizer.minimumNumberOfTouches = 1
          gestureRecognizer.addTarget(self, action: #selector(GameController.handleSwipe(_:)))
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
  
  func handlePinchOutChallenge(_ sender: UIPinchGestureRecognizer) {
    if sender.state == .began && Float(sender.scale) > 1.0 {
      let multiplier:Float = 1.5
      let transformScale = multiplier * Float(sender.scale)
      challengeImage.transform = challengeImage.transform.scaledBy(x: CGFloat(transformScale), y: CGFloat(transformScale))
      sender.scale = 1
    }
    
    //reset initial scaling
    if sender.state == .cancelled || sender.state == .ended {
      challengeImage.transform = CGAffineTransform(scaleX: CGFloat(1.0), y: CGFloat(1.0))
    }
    
    if sender.state == .ended && Float(sender.scale) > 2.0  {
      onGestureSuccess()
    } else if sender.state == .ended {
      wiggle(challengeImage)
    }
  }
  
  func handlePinchInChallenge(_ sender: UIPinchGestureRecognizer) {
    if (sender.state == .began) && (Float(sender.scale) < 1.0)  {
      let multiplier:Float = 5.0
      let transformScale = Float(sender.scale) / multiplier
      challengeImage.transform = challengeImage.transform.scaledBy(x: CGFloat(transformScale), y: CGFloat(transformScale))
      sender.scale = 1
    }
    
    //reset initial scaling
    if sender.state == .cancelled || sender.state == .ended {
      challengeImage.transform = CGAffineTransform(scaleX: CGFloat(1.0), y: CGFloat(1.0))
    }
    
    if sender.state == .ended && Float(sender.scale) < 0.8  {
      onGestureSuccess()
    } else if sender.state == .ended {
      wiggle(challengeImage)
    }
  }
  
  func handleTapChallenge(_ sender: UILongPressGestureRecognizer) {
    let challenge = game.currentChallenge as! TapChallenge

    if sender.state == .ended {
      challengeImage.image = UIImage(named: challenge.challengeImage!)
      onGestureSuccess()
    }

    if sender.state == .began {
      challengeImage.image = UIImage(named: challenge.challengeImageAnimation)
    }
  }
  
  
  var initialYCoord:CGFloat?
  var distanceTraveled:CGFloat = 0.0
  func handleSwipe(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: self.view)
    
    if sender.state == .began || sender.state == .changed {
      if initialYCoord == nil {
        distanceTraveled = 0.0
        self.initialYCoord = challengeImage.center.y
      }
      
      distanceTraveled += translation.y
      
      sender.view!.center = CGPoint(x: sender.view!.center.x, y: sender.view!.center.y + translation.y)
      sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    if sender.state == .ended, let initialYCoord = initialYCoord {
      if distanceTraveled < -250 {
        UIView.animate(withDuration: 0.15, animations: {
          self.challengeImage.transform = CGAffineTransform(translationX: 0, y: -256)
          self.onGestureSuccess()
          self.challengeImage.transform = CGAffineTransform.identity
        })
      } else {
        sender.view!.center = CGPoint(x: sender.view!.center.x, y: initialYCoord)
        wiggle(challengeImage)
      }
      distanceTraveled = 0.0
    }
  }
  
  func onGestureSuccess()
  {
    handleSuccess()
  }
  
  func removeOldGestures() {
    for recognizer in challengeBoard.gestureRecognizers! {
      challengeBoard.removeGestureRecognizer(recognizer)
    }
  }
  
  func appendScore(_ challenge: Challenge)
  {
    game.incrementScoreBy(game.currentLevel!.challengeScore)
    gameScore.text = "\(game.score)"
  }
  
  func appendChallengesRemainingCount() {
    challengesRemainingLabel.text = "\(game.currentLevel!.challenges.count) left"
  }
  
  func wiggle( _ challengeImage: UIImageView ) {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.07
    animation.repeatCount = 2
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: challengeImage.center.x - 5, y: challengeImage.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: challengeImage.center.x + 5, y: challengeImage.center.y))
    challengeImage.layer.add(animation, forKey: "position")
  }
  
  func animateChallenge() {
    self.simonHead.isHidden = false
    
    UIView.animate(withDuration: 0.5, animations: {
      self.challengeBoard.isHidden = true
      self.simonHead.transform = CGAffineTransform(scaleX: CGFloat(20.0), y: CGFloat(20.0))
    }, completion: { (finished: Bool) in
      UIView.animate(withDuration: 0.5, animations: {
        self.simonHead.transform = CGAffineTransform(scaleX: CGFloat(1.0), y: CGFloat(1.0))
      }, completion: { (finished: Bool) in
        self.simonHead.isHidden = true
        self.challengeBoard.isHidden = false
        
        UIView.animate(withDuration: 0.15, animations: {
          self.gameScore.transform = CGAffineTransform(scaleX: CGFloat(1.4), y: CGFloat(1.4))
        }, completion: { (finished: Bool) in
          UIView.animate(withDuration: 0.15, animations: {
            self.gameScore.transform = CGAffineTransform(scaleX: CGFloat(1.0), y: CGFloat(1.0))
          })
        })
      })
    })
  }
  
  func handleSuccess() {
    appendScore(game.currentChallenge!)
    appendChallengesRemainingCount()
    removeOldGestures()
    setChallenge()
    animateChallenge()
    
    if game.currentChallenge == nil {
      onLevelCompletion()
    }
  }
  
  func initializeGame()
  {
    game.start()
    toggleGameElements()
    gameTimeRemaining.text = "\(game.currentLevel!.duration)"
    gameTimeRemainingCountDown()
    appendChallengesRemainingCount()
    setChallenge()
  }
  
  func gameTimeRemainingCountDown()
  {
    countDown(gameTimeRemaining,
      timer: { () in
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameController.gameTimeRemainingCountDown), userInfo: nil, repeats: false)
      },
      callback: { () in
        self.onLevelFailure()
    })
  }
  
  func gameStartCountDown()
  {
    countDown(gameStartTimeRemaining,
      timer: { () in
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameController.gameStartCountDown), userInfo: nil, repeats: false)
      },
      callback: { () in
        self.initializeGame()
        self.gameStartTimeRemaining.isHidden = true
    })
  }
  
  func countDown(_ label:UILabel, timer:() -> Void, callback:() -> Void)
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
  
  func onLevelCompletion() {
    // cancel timer
    
    let LevelInterludeController = self.storyboard?.instantiateViewController(withIdentifier: "LevelInterludeController") as! LevelInterludeController
    present(LevelInterludeController, animated: true, completion: nil)
  }
  
  func onLevelFailure()
  {
    let gameCompletionController = self.storyboard?.instantiateViewController(withIdentifier: "GameCompletion") as! GameCompletionController
    present(gameCompletionController, animated: true, completion: nil)
  }
}
