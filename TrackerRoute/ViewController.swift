//
//  ViewController.swift
//  TrackerRoute
//
//  Created by Nora Hilda De los Reyes on 02/03/16.
//  Copyright © 2016 pedro alonso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInLabel: UILabel!
    
    let MapForPlacesSegue = "MapForPlacesSegue"
    let DriversSegue = "DriversSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func ingresarTapped(sender: UIButton) {

        let usuario = usuarioTextField.text!
        let password = passwordTextField.text!
        
        print(usuario)
        print(password)
        
        if usuario != "" && password != "" {
            
            
            if usuario == "Aldo" {
                
                
                self.performSegueWithIdentifier(DriversSegue, sender: self)
                
                
            } else {
            
            //enter app
                self.performSegueWithIdentifier(MapForPlacesSegue, sender: self)
            }
                
        } else {
            
            //not enter
           displayError("Error", message: "Los campor no puede estar vacios.")
        }
    }
    
    func displayError(title: String, message: String) {
        
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        usuarioTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        
        if segue.identifier == MapForPlacesSegue {
        
            let MFPVC = segue.destinationViewController as! MapForPlacesViewController
            
            
            MFPVC.sentText = "Bienvenido \(usuarioTextField.text!)"
            
            
        } else {
    
            let CVC = segue.destinationViewController as! ConductoresViewController
            
            CVC.userName = "Conductor \(usuarioTextField.text!)"
            
        }
        
    }
    

   
}

