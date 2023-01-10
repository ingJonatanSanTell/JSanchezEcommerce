//
//  UsuarioViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 05/01/23.
//

import UIKit

class UsuarioViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var UsuarioImagen: UIImageView!
    @IBOutlet weak var UserNameLabel: UITextField!
    @IBOutlet weak var NombreLabel: UITextField!
    @IBOutlet weak var ApellidoPaternoLabel: UITextField!
    @IBOutlet weak var ApellidoMaternoLabel: UITextField!
    @IBOutlet weak var EmailLabel: UITextField!
    @IBOutlet weak var PasswordLabel: UITextField!
    @IBOutlet weak var FechaNacDatePicker: UIDatePicker!
    @IBOutlet weak var SexoLabel: UITextField!
    @IBOutlet weak var TelefonoLabel: UITextField!
    @IBOutlet weak var CelularLabel: UITextField!
    @IBOutlet weak var CurpLabel: UITextField!
    @IBOutlet weak var ActionButton: UIButton!
    
    
    var idUsuario : Int? = nil
    let imagePicker = UIImagePickerController()
    
    let usuarioViewModel = UsuarioViewModel()
    var usuarioModel : User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.isEditing = false
        
        Validar()
        

        
        //usuarioViewModel.Delete(idUsuario: 3)
        
        // Do any additional setup after loading the view.
    }
    
    func Validar(){
        if self.idUsuario == nil {
            
            ActionButton.setTitle("INSERT", for: .normal)
            UsuarioImagen.image = UIImage(named: "imgUser")
        }
        else{
            ActionButton.setTitle("UPDATE", for: .normal)
            
            let result : Result = usuarioViewModel.GetById(idUsuario: idUsuario!)
            
            if result.Correct{
                let usuario = result.Object as! User
                
                UserNameLabel.text = usuario.UserName
                NombreLabel.text = usuario.Nombre
                ApellidoPaternoLabel.text = usuario.ApellidoPaterno
                ApellidoMaternoLabel.text = usuario.ApellidoMaterno
                EmailLabel.text = usuario.Email
                PasswordLabel.text = usuario.Password
                FechaNacDatePicker.date = usuario.FechaNacimiento
                SexoLabel.text = usuario.Sexo
                TelefonoLabel.text = usuario.Telefono
                CelularLabel.text = usuario.Celular
                CurpLabel.text = usuario.Curp
                
                if usuario.Imagen == ""{
                    UsuarioImagen.image = UIImage(named: "imgUser")
                }
                else{
                    UsuarioImagen.image = UIImage(data: Data(base64Encoded: usuario.Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)
                }
                
            }
            else{
                print("ERROR")
            }
        }
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        UsuarioImagen.image = info[.originalImage] as? UIImage
        
        //convertir a base64
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ImageButton(_ sender: Any) {
        self.present(imagePicker, animated: true)
    }
    
    
    @IBAction func ActionButton(_ sender: UIButton) {
        
        
        guard let UserName = UserNameLabel.text, UserName != "" else{
            UserNameLabel.placeholder = "Coloca el Nombre de Usuario"
            return
            
        }
        
        guard let Nombre = NombreLabel.text, Nombre != "" else{
            NombreLabel.placeholder = "Coloca el Nombre"
            return
            
        }
        guard let ApellidoPaterno = ApellidoPaternoLabel.text, ApellidoPaterno != "" else{
            ApellidoPaternoLabel.placeholder = "Coloca el Apellido Paterno"
            return
            
        }
        
        guard let ApellidoMaterno = ApellidoMaternoLabel.text, ApellidoMaterno != "" else{
            ApellidoMaternoLabel.placeholder = "Coloca el Apellido Materno"
            return
            
        }
                
        guard let Email = EmailLabel.text, Email != "" else{
            EmailLabel.placeholder = "Coloca el Email"
            return
        }
                
        guard let Password = PasswordLabel.text, Password != "" else{
            PasswordLabel.placeholder = "Coloca una Contraseña"
            return
        }
        
        let Fecha = FechaNacDatePicker.date
                
        guard let Sexo = SexoLabel.text, Sexo != "" else{
            SexoLabel.placeholder = "Coloca el Sexo"
            return
        }
                
        guard let Telefono = TelefonoLabel.text, Telefono != "" else{
            TelefonoLabel.placeholder = "Coloca un Telefono"
            return
        }
        
        guard let Celular = CelularLabel.text, Celular != "" else{
            CelularLabel.placeholder = "Coloca un Celular"
            return
        }
        
        guard let CURP = CurpLabel.text, CURP != "" else{
            CurpLabel.placeholder = "Coloca una CURP"
            return
        }
        
        let image = UsuarioImagen.image!
        let imageString : String
        
        if UsuarioImagen.restorationIdentifier == "impUser"{
            imageString = ""
        }
        else{
            let imageData = image.pngData()! as NSData
            imageString = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        
        usuarioModel = User(IdUsuario: 0, UserName: UserName, Nombre: Nombre, ApellidoPaterno: ApellidoPaterno, ApellidoMaterno: ApellidoMaterno, Email: Email, Password: Password, FechaNacimiento: Fecha, Sexo: Sexo, Telefono: Telefono, Celular: Celular, Curp: CURP, Imagen: imageString)
        
        let result = usuarioViewModel.Add(usuario: usuarioModel!)
        
        if result.Correct{
            
            let alert  = UIAlertController(title: "CONFIRMACION", message: "USUARIO AGREGADO", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(ok)
            
            self.present(alert, animated: false)
            
            UserNameLabel.text = ""
            NombreLabel.text = ""
            ApellidoPaternoLabel.text = ""
            ApellidoMaternoLabel.text = ""
            EmailLabel.text = ""
            PasswordLabel.text = ""
            SexoLabel.text = ""
            TelefonoLabel.text = ""
            CelularLabel.text = ""
            CurpLabel.text = ""
            UsuarioImagen.image = UIImage(named: "imgProducto")
            
            
        }
        else{
            let alertError  = UIAlertController(title: "ERROR", message: "PRODUCTO NO AGREGADO", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            
            alertError.addAction(ok)
            
            self.present(alertError, animated: false)
            
            UserNameLabel.text = ""
            NombreLabel.text = ""
            ApellidoPaternoLabel.text = ""
            ApellidoMaternoLabel.text = ""
            EmailLabel.text = ""
            PasswordLabel.text = ""
            SexoLabel.text = ""
            TelefonoLabel.text = ""
            CelularLabel.text = ""
            CurpLabel.text = ""
            UsuarioImagen.image = UIImage(named: "imgProducto")
            
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
