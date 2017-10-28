//
//  RecorderVC.swift
//  escapeCallReleaseCandidateiOS
//
//  Created by Keith Fawcett on 10/11/17.
//  Copyright © 2017 KeithFawcett. All rights reserved.
//

import UIKit
import AVFoundation


class RecorderVC: UIViewController, AVAudioRecorderDelegate {
  
  var recordingSession:AVAudioSession!
  var audioRecorder:AVAudioRecorder!
  var audioPlayer: AVAudioPlayer!
  
  var numberOfRecords:Int = 0

  @IBOutlet weak var startRecordButton: UIButton!
  @IBOutlet weak var playButtonOutlet: UIButton!
  @IBOutlet weak var selectButtonOutlet: UIButton!
  
  
  @IBAction func startRecordingActionButton(_ sender: Any) {
    if audioRecorder == nil{
      
      let filename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
      
      let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
      
      do{
        audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
        audioRecorder.delegate = self
        audioRecorder.record()
        
        startRecordButton.setTitle("Stop Recording", for: .normal)
      }catch{
        displayAlert(title: "Ups!", message: "Recording failed")
      }
      
      playButtonOutlet.isEnabled = false
      selectButtonOutlet.isEnabled = false
    }else{
      audioRecorder.stop()
      audioRecorder = nil
      playButtonOutlet.isEnabled = true
      selectButtonOutlet.isEnabled = true
      
//      UserDefaults.standard.set(numberOfRecords, forKey: "myNumber")
      
      startRecordButton.setTitle("Start Recording", for: .normal)
    }
  }
  
  @IBAction func playButton(_ sender: Any) {
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryMultiRoute)
    }
    catch {
      print("nope")
      // report for an error
    }
    let path = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")

    do{
      audioPlayer = try AVAudioPlayer(contentsOf: path)
      audioPlayer.play()
      print("playing")
    }catch{
      print("not playing")
    }

    
  }
  
  @IBAction func selectButton(_ sender: Any) {
    CustomVoice = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
    HasVoice = "Yes"
    numberOfRecords += 1
    self.navigationController?.popViewController(animated: true)
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    if !RecordLoaded{
      initialSetUP()
      RecordLoaded = true
    }
    
      recordingSession = AVAudioSession.sharedInstance()
    
    if let number:Int = UserDefaults.standard.object(forKey: "myNumber") as? Int{
      numberOfRecords = number
    }
    
    
      
    AVAudioSession.sharedInstance().requestRecordPermission{ (hasPermission) in
      if hasPermission{
        print("ACCEPTED")
      }
    }
  }
    func getDirectory() -> URL{
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      let documentDirectory = paths[0]
      return documentDirectory
    }
  
  func displayAlert(title:String, message:String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "dissmiss", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  func initialSetUP(){
      
      let filename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
      
      let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
      
      do{
        audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
        audioRecorder.delegate = self
        audioRecorder.record()
      }catch{
        displayAlert(title: "Ups!", message: "Recording failed")
      }
      
  
      audioRecorder.stop()
      audioRecorder = nil
    
  }

  
  
}










