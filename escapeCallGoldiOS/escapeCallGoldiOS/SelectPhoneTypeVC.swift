//
//  SelectPhoneTypeVC.swift
//  escapeCallBetaiOS
//
//  Created by Keith Fawcett on 10/8/17.
//  Copyright © 2017 KeithFawcett. All rights reserved.
//

import UIKit
import AVFoundation

class SelectPhoneTypeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  
  var ringtone = AVAudioPlayer()
  
  let phoneTypes = ["iPhone", "mobile ","home", "work"]
  
  let ringtones = ["default", "apple_ring","deadpool", "despacito","remix", "ring_plus", "shape" ]
  
  let setTimer = ["30 seconds", "1 Minute", "5 Minutes", "10 Minutes", "15 Minutes", "20 Minutes", "30 Minutes", "45 Minutes"]
  let timeInSeconds = [30,60,300,600,900,1200,1800,2700,3600]
  

  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      

        // Do any additional setup after loading the view.
    }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch (FeatureSelected) {
    case ("phoneType"):
      return(phoneTypes.count)
    case ("ringtone"):
      return(ringtones.count)
    case ("setTimer"):
      return(setTimer.count)
    default:
      return(1)
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
    
    switch (FeatureSelected) {
    case ("phoneType"):
      cell.textLabel?.text = phoneTypes[indexPath.row]
    case ("ringtone"):
      cell.textLabel?.text = ringtones[indexPath.row]
    case ("setTimer"):
      cell.textLabel?.text = setTimer[indexPath.row]
    default:
      print(indexPath.row)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    switch (FeatureSelected) {
    case ("phoneType"):
      CallerPhoneType = phoneTypes[indexPath.row]
      performSegue(withIdentifier: "selectedPhoneType", sender: self)
    case ("ringtone"):
      
      CallerRingTone = ringtones[indexPath.row]
      if let path = Bundle.main.path(forResource: CallerRingTone, ofType: "mp3") {
        let filePath = NSURL(fileURLWithPath:path)
        ringtone = try! AVAudioPlayer.init(contentsOf: filePath as URL)
        ringtone.prepareToPlay()
        do {
          try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers)
        }
        catch {
          // report for an error
        }
      }
      ringtone.stop()
      ringtone.play()
    case ("setTimer"):
      CallerTime = setTimer[indexPath.row]
      CallerTimerCount = timeInSeconds[indexPath.row]
      performSegue(withIdentifier: "selectedPhoneType", sender: self)
    default:
      print(indexPath.row)
    }
  }

}
