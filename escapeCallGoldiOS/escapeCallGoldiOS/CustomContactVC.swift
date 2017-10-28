//
//  CustomContactVC.swift
//  EscapeCall
//
//  Created by Keith Fawcett on 9/17/17.
//  Copyright © 2017 KeithFawcett. All rights reserved.
//

import UIKit
import CoreData

var FeatureSelected = ""

class CustomContactVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

  var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  
  @IBOutlet weak var tblView: UITableView!
  
  
  
  @IBAction func UnwindLoadedCaller(segue: UIStoryboardSegue){
    
    
  }
  
  @IBAction func StartCallButton(_ sender: Any) {
  
    VoicePicker = "Voice Off"
    if nameTextField.text != "" {
      
      CallerName = nameTextField.text!
//      CallerPhoneType = phoneTypes[(self.tblView.indexPathForSelectedRow?.row)!]
      performSegue(withIdentifier: "StartCallFromCustom", sender: self)
      
      
    }else{
      
      createAlert(title: "Enter Name", message: "Please enter to call you.")
    }
    
  }
  @IBOutlet weak var nameTextField: UITextField!
  
  @IBAction func getImageButton(_ sender: Any) {
    let image = UIImagePickerController()
    image.delegate = self
    
    let actionSheet = UIAlertController(title: "Photo Source", message: "Shoose a source", preferredStyle: .actionSheet)
    
    actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
      image.sourceType = UIImagePickerControllerSourceType.camera
      self.present(image, animated: true, completion: nil)
      }else{
        print("Camera not available")
      }
    }))
    actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
      image.sourceType = UIImagePickerControllerSourceType.photoLibrary
      self.present(image, animated: true, completion: nil)
    }))
    
    actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
    
    self.present(actionSheet, animated: true, completion: nil)
    
    if nameTextField.text != "" {
      CallerName = nameTextField.text!
    }
    
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
   
    let theInfo:NSDictionary = info as NSDictionary
    
    let img:UIImage = theInfo.object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
    
    CallerImage = img
    
    displayImage.setBackgroundImage(img, for: .normal)
    
    self.dismiss(animated: true, completion: nil)
  }
  
  
  @IBOutlet weak var displayImage: UIButton!
  var phoneTypes = ["Phone Type - " + CallerPhoneType, "Ringtone - " + CallerRingTone, "Set Timer - " + CallerTime, "Voice - " + HasVoice]
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return phoneTypes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
    cell.textLabel?.text = phoneTypes[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch (indexPath.row) {
    case (0):
      FeatureSelected = "phoneType"
    case (1):
      FeatureSelected = "ringtone"
    case (2):
      FeatureSelected = "setTimer"
    case (3):
      FeatureSelected = "voice"
    default:
      print(indexPath.row)
    }
    if FeatureSelected == "voice"{
      
      performSegue(withIdentifier: "toRecorder", sender: self)
    }else{
    performSegue(withIdentifier: "toSelectPhoneType", sender: self)
    }
    dismissKeyboard()
  }
  
  
  func createAlert(title:String, message:String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: {(action) in alert.dismiss(animated: true, completion: nil)
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  
    // MARK: - Core Data
  
  
  @IBAction func saveButton(_ sender: Any) {
    
    if nameTextField.text != "" {
    
      if SelectedCaller != nil{
        context.delete(SelectedCaller!)
      }
      
      let caller = NSEntityDescription.insertNewObject(forEntityName: "Caller", into: context)
      caller.setValue(self.nameTextField!.text, forKey: "name")
      caller.setValue(CallerPhoneType, forKey: "phoneType")
      caller.setValue(CallerTimerCount, forKey: "timeCounter")
      caller.setValue(CallerRingTone, forKey: "ringtone")
      caller.setValue(CallerTime, forKey: "time")
      if CustomVoice != nil{
      caller.setValue(String(describing: CustomVoice!), forKey: "voice")
      }
      if CallerImage != nil{
        let imgData = UIImageJPEGRepresentation(CallerImage!, 1)
        caller.setValue(imgData, forKey: "image")
      }
      
      do {
        try context.save()
      }
      catch{
        print(error)
      }
      
      
    }else{
      
      createAlert(title: "Enter Name", message: "Please enter a name to save")
    }
    
    
    createAlert(title: "Saved", message: "Your contact has saved")
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      
      self.nameTextField.delegate = self;
      
      
      
        // Do any additional setup after loading the view.
    }
  
  override func viewWillAppear(_ animated: Bool) {
    
    self.navigationController?.isNavigationBarHidden = false;
    nameTextField.text = CallerName
    phoneTypes = ["Phone Type - " + CallerPhoneType, "Ringtone - " + CallerRingTone, "Set Timer - " + CallerTime, "Voice - " + HasVoice]
    
    if CallerImage != nil{
    displayImage.setBackgroundImage(CallerImage, for: .normal)
    }
    
    tblView.reloadData()
    print("loaded")
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    dismissKeyboard()
    return false
  }
  
  func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    CallerName = nameTextField.text!
    view.endEditing(true)
  }

}
