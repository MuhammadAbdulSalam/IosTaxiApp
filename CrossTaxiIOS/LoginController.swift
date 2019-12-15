//
//  LoginController.swift
//  CrossTaxiIOS
//
//  Created by madbulsa on 14/12/2019.
//  Copyright © 2019 madbulsa. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import GoogleMaps



class LoginController: UIViewController {

    @IBOutlet weak var emailAdr: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()        
        }

    
    @IBAction func SiginToApp(_ sender: Any) {
        let emailText: String = self.emailAdr.text ?? "newVal"
        let passwordText: String = self.passwordText.text ?? "newVal"
    
        SignInFirebas(email: emailText, password: passwordText)
    }
    
    //Documentation SignIn
    func SignInFirebas(email: String, password: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
        }
    }
    
}
