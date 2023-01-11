//
//  DepartamentoViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 05/01/23.
//

import UIKit
import iOSDropDown

class DepartamentoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var NombreDepartamentoLabel: UITextField!
    @IBOutlet weak var ActionButton: UIButton!
    @IBOutlet weak var AreaDropDown: DropDown!
    
    var idDepartamento : Int? = nil
    var idArea : Int? = nil
    
    let departamentoViewModel = DepartamentoViewModel()
    let areaViewModel = AreaViewModel()
    var departamentoModel : Departamento? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AreaDropDown.optionArray = [String]()
        AreaDropDown.optionIds = [Int]()
        
        LoadData()
        
        AreaDropDown.didSelect { selectedText, index, id in
            self.idArea = id
        }

        
        Validar()
    }
    
    func LoadData(){
        let resultArea = areaViewModel.GetAll()
        if resultArea.Correct{
            for area in resultArea.Objects as! [Area]{
                AreaDropDown.optionArray.append(area.Nombre)
                AreaDropDown.optionIds?.append(area.IdArea)
            }
        }
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
                AreaDropDown.text = String(departamento.Area!.IdArea)
                
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
                
        guard let IdArea = AreaDropDown.text, IdArea != "" else{
            AreaDropDown.placeholder = "Coloca el Id del Area"
            return
        }
        
        
        departamentoModel = Departamento(IdDepartamento: 0, Nombre: Nombre, Area: Area(IdArea: self.idArea!, Nombre: ""))
        
        if (sender as AnyObject).currentTitle == "INSERT"{
            
            let result = departamentoViewModel.Add(departamento: departamentoModel!)
            
            if result.Correct{
                
                let alert  = UIAlertController(title: "CONFIRMACION", message: "AREA AGREGADA", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: false)
                
                NombreDepartamentoLabel.text = ""
                AreaDropDown.text = ""
                
            }
            else{
                let alertError  = UIAlertController(title: "ERROR", message: "AREA NO AGREGADA", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alertError.addAction(ok)
                
                self.present(alertError, animated: false)
                
                NombreDepartamentoLabel.text = ""
                AreaDropDown.text = ""
                
            }
        }
        else if (sender as AnyObject).currentTitle == "UPDATE"{
            
            departamentoModel = Departamento(IdDepartamento: self.idDepartamento!, Nombre: Nombre, Area: Area(IdArea: self.idArea!, Nombre: ""))
            
            let result = departamentoViewModel.Update(departamento: departamentoModel!)
            
            if result.Correct{
                
                let alert  = UIAlertController(title: "CONFIRMACION", message: "AREA ACTUALIZADA", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: false)
                
                NombreDepartamentoLabel.text = ""
                AreaDropDown.text = ""
                
            }
            else{
                let alertError  = UIAlertController(title: "ERROR", message: "AREA NO ACTUALIZADA", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alertError.addAction(ok)
                
                self.present(alertError, animated: false)
                
                NombreDepartamentoLabel.text = ""
                AreaDropDown.text = ""
                
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
