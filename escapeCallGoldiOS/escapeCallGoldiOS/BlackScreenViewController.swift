//
//  BlackScreenViewController.swift
//  escapeCallAlpha
//
//  Created by Keith Fawcett on 9/27/17.
//  Copyright © 2017 KeithFawcett. All rights reserved.
//

import UIKit
import AVFoundation

class BlackScreenViewController: UIViewController, UIApplicationDelegate {

  var timer = Timer()
  var hint = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 300))
  var timerLabel = UILabel()
  var hideHintTime = CallerTimerCount - 5
  var countDown = CallerTimerCount
  
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      let window = UIApplication.shared.keyWindow!
      self.navigationController?.isNavigationBarHidden = true
      let v = UIView(frame: CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: window.frame.height))
      v.tag = 100
      self.view.addSubview(v)
      v.backgroundColor = UIColor.black
      
      
      hint.text = "Cancel call by long pressing the screen \r Do not hit the power button or the home button"
      hint.textAlignment = .center
      hint.textColor = UIColor.white
      hint.translatesAutoresizingMaskIntoConstraints = false
      hint.lineBreakMode = .byWordWrapping
      hint.numberOfLines = 0
      v.addSubview(hint)
      
      timerLabel.textAlignment = .center
      timerLabel.font = timerLabel.font.withSize(30)
      timerLabel.textColor = UIColor.darkGray
      timerLabel.text = String(countDown)
      timerLabel.translatesAutoresizingMaskIntoConstraints = false
      v.addSubview(timerLabel)
      
      let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
      longPressRecognizer.minimumPressDuration = 2.0
      v.addGestureRecognizer(longPressRecognizer)
      
      
      timer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: (#selector(BlackScreenViewController.updateStopwatch)), userInfo: nil, repeats: true)
     

        // Do any additional setup after loading the view.
    }
  
  
  
  @objc func longPressed(sender: UILongPressGestureRecognizer)
  {
    print("longpressed")
    timer.invalidate()
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func updateStopwatch(){
    
    if(countDown == 1){
      countDown -= 1
      timer.invalidate()
      performSegue(withIdentifier: "startCall", sender: self)
      print("segue")
    }else{
      if (countDown == hideHintTime){
        hint.isHidden = true
      }
      countDown -= 1
      timerLabel.text = String(countDown)
      print(countDown)
    }
    
    
  }
  func applicationDidEnterBackground(_ application: UIApplication) {
    timer.invalidate()
    self.navigationController?.popViewController(animated: true)
    print("background")
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    timer.invalidate()
    self.navigationController?.popViewController(animated: true)
  }


}
