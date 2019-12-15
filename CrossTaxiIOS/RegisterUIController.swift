//
//  RegisterUIController.swift
//  CrossTaxiIOS
//
//  Created by madbulsa on 08/12/2019.
//  Copyright © 2019 madbulsa. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import GoogleSignIn

class RegisterUIController: UIViewController{
    
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var DOB: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var PhoneNumber: UITextField!
    
    
  let rootDBref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do
        {
             try Auth.auth().signOut()
        }
        catch let error as NSError
        {
            print (error.localizedDescription)
        }
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func StartRegistration(_ sender: Any) {
        try! Auth.auth().signOut()
        
        
        let emailText: String = self.emailAddress.text ?? "newVal"
        let passwordText: String = self.Password.text ?? "newVal"
        let firstName: String = self.FirstName.text ?? "newVal"
          let lastName: String = self.LastName.text ?? "newVal"
        let dob: String = self.DOB.text ?? "newVal"
        let phoneTxt: String = self.PhoneNumber.text ?? "newVal"
        
    
        createUser(email: emailText, password: passwordText)
        SignInFirebas(email: emailText, password: passwordText)
       
        sleep(4)
        
        let userID = Auth.auth().currentUser?.uid
      
        
        
        
        //(self.rootDBref.child("Users") as AnyObject).child(userID ?? "nill").setValue(["phoneTxt": phoneTxt])
        self.rootDBref.child("Users").child(userID!).setValue([ "firstName": firstName,"lastName" : lastName ,"dob" : dob, "email" : emailText, "phoneNumber" : phoneTxt])
        
           }
    
    
    
    
    
           
    //Create Auth for Registration with Email and Password
    func createUser(email: String, password: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
        if let e = error{
            callback?(e)
        return
            }
        callback?(nil)}
        
           }
    
    func SignInFirebas(email: String, password: String, _ callback: ((Error?) -> ())? = nil){
           Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
               guard self != nil else { return }
           }
       }
}
