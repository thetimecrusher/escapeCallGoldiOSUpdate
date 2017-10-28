//
//  LoadCustomCallersVC.swift
//  escapeCallBetaiOS
//
//  Created by Keith Fawcett on 10/6/17.
//  Copyright © 2017 KeithFawcett. All rights reserved.
//

import UIKit
import CoreData


var SelectedCaller : Caller? = nil

class LoadCustomCallersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tblView: UITableView!
  
  var callersArray:[Caller] = []
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return(callersArray.count)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
    let caller = callersArray[indexPath.row]
    cell.textLabel?.text = caller.name! + " " + caller.phoneType!
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("selected")
    SelectedCaller = callersArray[indexPath.row]
    CallerName = callersArray[indexPath.row].name!
    CallerPhoneType = callersArray[indexPath.row].phoneType!
    CallerRingTone = callersArray[indexPath.row].ringtone!
    CallerTime = callersArray[indexPath.row].time!
    CallerTimerCount = Int(callersArray[indexPath.row].timeCounter)
    if callersArray[indexPath.row].voice != nil{
      CustomVoice = URL(string: callersArray[indexPath.row].voice!)
      HasVoice = "Yes"
    }else{
      HasVoice = "No"
    }
    if callersArray[indexPath.row].image != nil{
      CallerImage = UIImage(data: callersArray[indexPath.row].image! as Data)
    }
    performSegue(withIdentifier: "selectedCaller", sender: self)
//    navigationController?.popViewController(animated: true)
//    dismiss(animated: true, completion: nil)
  }
  
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    if editingStyle == .delete{
      
      let caller = callersArray[indexPath.row]
      context.delete(caller)
      (UIApplication.shared.delegate as! AppDelegate).saveContext()
      
      do{
        callersArray = try context.fetch(Caller.fetchRequest())
      }
      catch{
        print(error)
      }
      
    }
    
    tableView.reloadData()
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      
      GetData()
      tblView.reloadData()

        // Do any additional setup after loading the view.
    }

  func GetData(){
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
      callersArray = try context.fetch(Caller.fetchRequest())
    } catch {
      print(error)
    }
    
    
    
  }
  

}
