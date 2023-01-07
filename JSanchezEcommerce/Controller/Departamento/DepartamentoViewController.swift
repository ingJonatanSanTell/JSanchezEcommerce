//
//  DepartamentoViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 05/01/23.
//

import UIKit

class DepartamentoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var NombreDepartamentoLabel: UITextField!
    @IBOutlet weak var IdAreaLabel: UITextField!
    @IBOutlet weak var ActionButton: UIButton!
    
    var idDepartamento : Int? = nil
    
    let departamentoViewModel = DepartamentoViewModel()
    var departamentoModel : Departamento? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        Validar()
    }
    
    func Validar(){
        if self.idDepartamento == nil {
            
            ActionButton.setTitle("INSERT", for: .normal)
            //ImageProducto.image = UIImage(named: "imgProducto")
        }
        else{
            ActionButton.setTitle("UPDATE", for: .normal)
            
            let result : Result = departamentoViewModel.GetById(idDepartamento: idDepartamento!)
            
            if result.Correct{
                let departamento = result.Object as! Departamento
                
                NombreDepartamentoLabel.text = departamento.Nombre
                IdAreaLabel.text = String(departamento.Area!.IdArea)
                
            }
            else{
                print("ERROR")
            }
        }
        
    }

    @IBAction func ActionButton(_ sender: Any) {
        
        guard let Nombre = NombreDepartamentoLabel.text, Nombre != "" else{
            NombreDepartamentoLabel.placeholder = "Coloca el Nombre"
            return
            
        }
                
        guard let IdArea = IdAreaLabel.text, IdArea != "" else{
            IdAreaLabel.placeholder = "Coloca el Id del Area"
            return
        }
        
        
        departamentoModel = Departamento(IdDepartamento: 0, Nombre: Nombre, Area: Area(IdArea: Int(IdArea)!, Nombre: ""))
        
        if (sender as AnyObject).currentTitle == "INSERT"{
            
            let result = departamentoViewModel.Add(departamento: departamentoModel!)
            
            if result.Correct{
                
                let alert  = UIAlertController(title: "CONFIRMACION", message: "AREA AGREGADA", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: false)
                
                NombreDepartamentoLabel.text = ""
                IdAreaLabel.text = ""
                
            }
            else{
                let alertError  = UIAlertController(title: "ERROR", message: "AREA NO AGREGADA", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alertError.addAction(ok)
                
                self.present(alertError, animated: false)
                
                NombreDepartamentoLabel.text = ""
                IdAreaLabel.text = ""
                
            }
        }
        else if (sender as AnyObject).currentTitle == "UPDATE"{
            
            departamentoModel = Departamento(IdDepartamento: self.idDepartamento!, Nombre: Nombre, Area: Area(IdArea: Int(IdArea)!, Nombre: ""))
            
            let result = departamentoViewModel.Update(departamento: departamentoModel!)
            
            if result.Correct{
                
                let alert  = UIAlertController(title: "CONFIRMACION", message: "AREA ACTUALIZADA", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: false)
                
                NombreDepartamentoLabel.text = ""
                IdAreaLabel.text = ""
                
            }
            else{
                let alertError  = UIAlertController(title: "ERROR", message: "AREA NO ACTUALIZADA", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alertError.addAction(ok)
                
                self.present(alertError, animated: false)
                
                NombreDepartamentoLabel.text = ""
                IdAreaLabel.text = ""
                
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
