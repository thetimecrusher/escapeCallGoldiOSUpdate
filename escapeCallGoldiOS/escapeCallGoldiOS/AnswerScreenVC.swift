//
//  AnswerScreenVC.swift
//  EscapeCall
//
//  Created by Keith Fawcett on 9/27/17.
//  Copyright © 2017 KeithFawcett. All rights reserved.
//

import UIKit
import AVFoundation
import ContactsUI

class AnswerScreenVC: UIViewController, CNContactPickerDelegate {

  @IBOutlet weak var callerLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  
  
  var audioPlayer: AVAudioPlayer!
  
  
  var voice: AVAudioPlayer!
  
  var timer = Timer()
  var seconds = 00
  var minutes = 00
  
  @IBOutlet weak var visualBlur: UIVisualEffectView!
  @IBOutlet weak var callerImageImageView: UIImageView!
  
  @IBAction func endCall(_ sender: Any) {
    if voice != nil{
    voice.stop()
    }
    if audioPlayer != nil{
    audioPlayer.stop()
    }
    performSegue(withIdentifier: "endCall2", sender: self)
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      hideOutlet.isHidden = true
      for buttons in keyPadButtons {
        buttons.isHidden = true
      }
      if CallerImage != nil{
        callerImageImageView.image = CallerImage
      }else{
        callerImageImageView.isHidden = true
        visualBlur.isHidden = true
      }
      
      timeLabel.text = "00:00"
      callerLabel.text = CallerName
      
      
      timer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: (#selector(AnswerScreenVC.updateStopwatch)), userInfo: nil, repeats: true)
      
      
      self.navigationController?.isNavigationBarHidden = true;
        // Do any additional setup after loading the view.
      
    
      if VoicePicker != "Voice Off"{
      if let path = Bundle.main.path(forResource: VoicePicker, ofType: "mp3") {
        let filePath = NSURL(fileURLWithPath:path)
        voice = try! AVAudioPlayer.init(contentsOf: filePath as URL)
        voice.play()
      }
    }
      if CustomVoice != nil{
      let path = CustomVoice!
      
      do{
        
        audioPlayer = try AVAudioPlayer(contentsOf: path)
        audioPlayer.play()
      }catch{
        
      }
  }
  }
  

  @objc func updateStopwatch(){
    if seconds == 59{
      minutes += 1
      seconds = 00
      let minutesString = String(format: "%02d", minutes)
      let secondsString = String(format: "%02d", seconds)
      timeLabel.text = minutesString + ":" + secondsString
      
    }else{
      seconds += 1
      let minutesString = String(format: "%02d", minutes)
      let secondsString = String(format: "%02d", seconds)
      timeLabel.text = minutesString + ":" + secondsString
    }
  }
  
  
  @IBOutlet weak var muteOutlet: UIButton!
  @IBOutlet weak var keypadOutlet: UIButton!
  @IBOutlet weak var speakerOutlet: UIButton!
  @IBOutlet weak var addCallOutlet: UIButton!
  @IBOutlet weak var facetimeOutlet: UIButton!
  @IBOutlet weak var concactsOutlet: UIButton!
  
  var mute = false
  var keypad = false
  var speaker = false
  var addCall = false
  var faceTime = false
  var contacts = false
  
  @IBOutlet var keyPadButtons: [UIButton]!
  
  @IBOutlet var ButtonLabelsCollection: [UILabel]!
  
  @IBAction func muteAction(_ sender: Any) {
    if mute{
      mute = false
      muteOutlet.setImage(UIImage(named: "iOS Styled Ui Icons - White (16).png"), for: UIControlState.normal)
    }else{
      mute = true
      muteOutlet.setImage(UIImage(named: "iOS Styled Ui Icons - White (16)pressed.png"), for: UIControlState.normal)
    }
  }
  @IBAction func keypadAction(_ sender: Any) {
    for buttons in keyPadButtons {
      buttons.isHidden = false
    }
    hideOutlet.isHidden = false
    
      for lables in ButtonLabelsCollection {
        lables.isHidden = true
      }
    
    muteOutlet.isHidden = true
    keypadOutlet.isHidden = true
    speakerOutlet.isHidden = true
    addCallOutlet.isHidden = true
    facetimeOutlet.isHidden = true
    concactsOutlet.isHidden = true
  
  }
  @IBAction func speakerAction(_ sender: Any) {
    if speaker{
      do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
      }
      catch {
        print("nope")
        // report for an error
      }
      speaker = false
      speakerOutlet.setImage(UIImage(named: "iOS Styled Ui Icons - White (7).png"), for: UIControlState.normal)
    }else{
      do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      }
      catch {
        // report for an error
      }
      speaker = true
      speakerOutlet.setImage(UIImage(named: "iOS Styled Ui Icons - White (7)pressed.png"), for: UIControlState.normal)
    }
  }
 

  @IBAction func contactsAction(_ sender: Any) {
    let cnPicker = CNContactPickerViewController()
    cnPicker.delegate = self
    self.present(cnPicker, animated: true, completion: nil)
  }
  
  //MARK:- CNContactPickerDelegate Method
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
   
  }
  
  
  func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
    
  }
  
  @IBOutlet weak var hideOutlet: UIButton!
  @IBAction func hideButton(_ sender: Any) {
    for buttons in keyPadButtons {
      buttons.isHidden = true
    }
    hideOutlet.isHidden = true
    
    muteOutlet.isHidden = false
    keypadOutlet.isHidden = false
    speakerOutlet.isHidden = false
    addCallOutlet.isHidden = false
    facetimeOutlet.isHidden = false
    concactsOutlet.isHidden = false
    
      for lables in ButtonLabelsCollection {
        lables.isHidden = false
      }
    
    
  }
  
  
  
  
}
