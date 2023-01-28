//
//  LoginViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 09/01/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailLabel: UITextField!
    @IBOutlet weak var PasswordLabel: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        
        if let email = EmailLabel.text, let password = PasswordLabel.text{
            
            
            Auth.auth().signIn(withEmail: email, password: password){ [self] (result, error) in
                
                if let result = result, error == nil{
                    
                    //mandar a inicio
                    //codigo
                    
                    self.performSegue(withIdentifier: "login", sender: self)
                
                    let alertController  = UIAlertController(title: "BIENVENIDO", message: "Usuario Encontrado", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    
                    EmailLabel.text = ""
                    PasswordLabel.text = ""
                }
                else{
                    
                    let alertController  = UIAlertController(title: "ERROR", message: "No se encontro el Email", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    
                    EmailLabel.text = ""
                    PasswordLabel.text = ""
                }
                
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
