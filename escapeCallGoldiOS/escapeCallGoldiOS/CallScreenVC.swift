//
//  CallScreenVC.swift
//  EscapeCall
//
//  Created by Keith Fawcett on 9/27/17.
//  Copyright © 2017 KeithFawcett. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class CallScreenVC: UIViewController {
  
  var counter = 0
  var timer : Timer?

  var ringtone = AVAudioPlayer()
  
  
  
  @IBOutlet weak var callerImageImageView: UIImageView!
  
  @IBOutlet weak var callerLabel: UILabel!
  @IBOutlet weak var callerPhoneType: UILabel!
  @IBAction func endCall(_ sender: Any) {
    ringtone.stop()
    timer?.invalidate()
    performSegue(withIdentifier: "endCall1", sender: self)
  }
  
  @IBAction func answerButton(_ sender: Any) {
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
    }
    catch {
      print("nope")
      // report for an error
    }
    ringtone.stop()
    timer?.invalidate()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      
      if CallerImage != nil{
        callerImageImageView.image = CallerImage
      }else{
        callerImageImageView.isHidden = true
      }
      callerLabel.text = CallerName
      callerPhoneType.text = CallerPhoneType
      print("calling")
      if let path = Bundle.main.path(forResource: CallerRingTone, ofType: "mp3") {
        let filePath = NSURL(fileURLWithPath:path)
      ringtone = try! AVAudioPlayer.init(contentsOf: filePath as URL)
        do {
          try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
          // report for an error
        }
      }
      ringtone.play()
      counter = 0
      timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(CallScreenVC.vibratePhone), userInfo: nil, repeats: true)
      
  

      self.navigationController?.isNavigationBarHidden = true;
        // Do any additional setup after loading the view.
    }

  
  
  
  
  
  @objc func vibratePhone() {
      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
  }
  
  

}
