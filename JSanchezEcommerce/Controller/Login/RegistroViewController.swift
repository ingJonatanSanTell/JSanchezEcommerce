//
//  RegistroViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 10/01/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegistroViewController: UIViewController {

    @IBOutlet weak var EmailLabel: UITextField!
    
    @IBOutlet weak var PasswordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Registro de Nuevo Usuario"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func RegistrarButton(_ sender: UIButton) {
        
        if let email = EmailLabel.text, let password = PasswordLabel.text{
            
            Auth.auth().createUser(withEmail: email, password: password){ [self] (result, error) in
                
                if let result = result, error == nil{
                    
                    //mandar a inicio
                    //codigo
                    
                    let alertController  = UIAlertController(title: "CORRECTO", message: "Usuario Registrasdo", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    
                    EmailLabel.text = ""
                    PasswordLabel.text = ""
                }
                else{
                    
                    let alertController  = UIAlertController(title: "ERROR", message: "No se pudo registrar al Usuario", preferredStyle: .alert)
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
