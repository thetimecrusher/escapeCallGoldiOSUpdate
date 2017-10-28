//
//  CallSettingsVC.swift
//  EscapeCall
//
//  Created by Keith Fawcett on 9/17/17.
//  Copyright © 2017 KeithFawcett. All rights reserved.
//

import UIKit
import ContactsUI

var VoicePicker = "male"

class CallSettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CNContactPickerDelegate {
  

  @IBOutlet weak var chooseVoice: UISegmentedControl!
  @IBAction func voiceController(_ sender: Any) {
    switch chooseVoice.selectedSegmentIndex{
    case 0:
      VoicePicker = "male"
    case 1:
      VoicePicker = "female"
    case 2:
      VoicePicker = "Voice Off"
    default:
      print("nothing choose")
    }
  }
  
  @IBAction func startCallBtn(_ sender: Any) {
    
    print("pressed")
  
  }
  @IBOutlet weak var tblView: UITableView!
  
  let timerTimes = ["30 seconds", "1 Minute", "5 Minutes", "10 Minutes", "15 Minutes", "20 Minutes", "30 Minutes", "45 Minutes"]
  let timeInSeconds = [30,60,300,600,900,1200,1800,2700,3600]
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return timerTimes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
    cell.textLabel?.text = timerTimes[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    CallerTimerCount = timeInSeconds[indexPath.row]
    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .none
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      print(CallerName)
      VoicePicker = "male"
      let cnPicker = CNContactPickerViewController()
      cnPicker.delegate = self
      self.present(cnPicker, animated: true, completion: nil)
      
  }
  
  override func viewWillAppear(_ animated: Bool) {
    CustomVoice = nil
    self.navigationController?.isNavigationBarHidden = false;
    let indexPath = IndexPath(row: 0, section: 0)
    tblView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
  }
  
      //MARK:- CNContactPickerDelegate Method
      
      func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // You can fetch selected name and number in the following way
        
        if contact.imageDataAvailable{
          
          CallerImage = UIImage(data: contact.imageData!)
          
        }
        // caller name
        let fullName = contact.givenName + " " + contact.familyName
        
        CallerName = fullName
        print(fullName)
        
        // caller phone type
        
        let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
        if userPhoneNumbers.count > 0{
        let firstPhoneNumber: CNLabeledValue<CNPhoneNumber>  = userPhoneNumbers[0]
        let phoneType: String = CNLabeledValue<NSString>.localizedString(forLabel: firstPhoneNumber.label! )
        
        CallerPhoneType = phoneType
        print(phoneType)
        }
      }
      
      
      func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
        self.navigationController?.popViewController(animated: true)
      }


}
