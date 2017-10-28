//
//  ViewController.swift
//  escapeCallBetaiOS
//
//  Created by Keith Fawcett on 10/2/17.
//  Copyright © 2017 KeithFawcett. All rights reserved.
//

import UIKit

var CallerName: String = ""
var CallerPhoneType: String = "iPhone"
var CallerRingTone: String = "default"
var CallerTime: String = "30 Seconds"
var CallerTimerCount: Int = 30
var CallerImage: UIImage? = nil
var CustomVoice: URL? = nil
var HasVoice: String = "No"
var RecordLoaded = false

class ViewController: UIViewController {

  @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
    
    self.navigationController?.isNavigationBarHidden = false;
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UIApplication.shared.isIdleTimerDisabled = true
    self.navigationController?.isNavigationBarHidden = false;
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func viewWillAppear(_ animated: Bool) {
    
    CallerName = ""
    CallerPhoneType = "iPhone"
    CallerRingTone = "default"
    CallerTime = "30 Seconds"
    CallerTimerCount = 30
    CallerImage  = nil
    HasVoice = "No"
  }




}

