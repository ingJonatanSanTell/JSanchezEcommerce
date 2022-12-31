//
//  ViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 27/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var NombreTextField: UITextField!
    @IBOutlet weak var PrecioUnitarioTextField: UITextField!
    @IBOutlet weak var StockTextField: UITextField!
    @IBOutlet weak var DescripcionTextField: UITextField!
    @IBOutlet weak var IdProveddorTextField: UITextField!
    @IBOutlet weak var IdDepartamentoTextField: UITextField!
    @IBOutlet weak var IdProductoTextField: UITextField!
    
    let productoViewModel = ProductoViewModel()
    var productoModel : Producto? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //BOTON UPDATE
    @IBAction func UpdateButton(_ sender: UIButton) {
        
        guard let Nombre = NombreTextField.text, Nombre != "" else{
            NombreTextField.placeholder = "Coloca el Nombre"
            return
            
        }
        guard let PrecioUnitario = PrecioUnitarioTextField.text, PrecioUnitario != "" else{
            PrecioUnitarioTextField.placeholder = "Coloca el Precio Unitario"
            return
            
        }
                
        guard let Stock = StockTextField.text, Stock != "" else{
            StockTextField.placeholder = "Coloca el Stock"
            return
        }
                
        guard let Descripcion = DescripcionTextField.text, Descripcion != "" else{
            DescripcionTextField.placeholder = "Coloca una Descripcion"
            return
        }
                
        guard let IdProveedor = IdProveddorTextField.text, IdProveedor != "" else{
            IdProveddorTextField.placeholder = "Coloca el Id del Proveedor"
            return
        }
                
        guard let IdDepartamento = IdDepartamentoTextField.text, IdDepartamento != "" else{
            IdDepartamentoTextField.placeholder = "Coloca el Id del Departamento"
            return
        }
        
        guard let IdProducto = IdProductoTextField.text, IdProducto != "" else{
            IdProveddorTextField.placeholder = "Coloca el Id del Producto a ACTUALIZAR"
            return
        }
        
        productoModel = Producto(IdProducto: Int(IdProducto)!, Nombre: Nombre, PrecioUnitario: Double(PrecioUnitario)!, Stock: Int(Stock)!, Descripcion: Descripcion, Proveedor: Proveedor(IdProveedor: Int(IdProveedor)!, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: Int(IdDepartamento)!, Nombre: "", Area:Area(IdArea: 0, Nombre: "")))
        
        let result = productoViewModel.Update(producto: productoModel!)
        
        if result.Correct{
            let alert  = UIAlertController(title: "CONFIRMACION", message: "PRODUCTO ACTUALIZADO", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(ok)
            
            self.present(alert, animated: false)
            
        }
        else{
            let alertError  = UIAlertController(title: "ERROR", message: "PRODUCTO NO ACTUALIZADO", preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default)
    
    alertError.addAction(ok)
    
    self.present(alertError, animated: false)
            
        }
    }
    
    //BOTON ADD
    @IBAction func AddButton(_ sender: UIButton) {
        
        guard let Nombre = NombreTextField.text, Nombre != "" else{
            NombreTextField.placeholder = "Coloca el Nombre"
            return
            
        }
        guard let PrecioUnitario = PrecioUnitarioTextField.text, PrecioUnitario != "" else{
            PrecioUnitarioTextField.placeholder = "Coloca el Precio Unitario"
            return
            
        }
                
        guard let Stock = StockTextField.text, Stock != "" else{
            StockTextField.placeholder = "Coloca el Stock"
            return
        }
                
        guard let Descripcion = DescripcionTextField.text, Descripcion != "" else{
            DescripcionTextField.placeholder = "Coloca una Descripcion"
            return
        }
                
        guard let IdProveedor = IdProveddorTextField.text, IdProveedor != "" else{
            IdProveddorTextField.placeholder = "Coloca el Id del Proveedor"
            return
        }
                
        guard let IdDepartamento = IdDepartamentoTextField.text, IdDepartamento != "" else{
            IdDepartamentoTextField.placeholder = "Coloca el Id del Departamento"
            return
        }
        
        productoModel = Producto(IdProducto: 0, Nombre: Nombre, PrecioUnitario: Double(PrecioUnitario)!, Stock: Int(Stock)!, Descripcion: Descripcion, Proveedor: Proveedor(IdProveedor: Int(IdProveedor)!, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: Int(IdDepartamento)!, Nombre: "", Area:Area(IdArea: 0, Nombre: "")))
        
        let result = productoViewModel.Add(producto: productoModel!)
        
        if result.Correct{
            let alert  = UIAlertController(title: "CONFIRMACION", message: "PRODUCTO AGREGADO", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            
            
            
            alert.addAction(ok)
            
            self.present(alert, animated: false)
            
        }
        else{
            let alertError  = UIAlertController(title: "ERROR", message: "PRODUCTO NO AGREGADO", preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default)
    
    alertError.addAction(ok)
    
    self.present(alertError, animated: false)
            
        }
    }
    
    //BOTON DELETE
    @IBAction func DeleteButton(_ sender: UIButton) {
        
        guard let IdProducto = IdProductoTextField.text, IdProducto != "" else{
            IdProductoTextField.placeholder = "Coloca el Id del Producto a ELIMINAR"
            IdProductoTextField.backgroundColor = .red
            return
        }
        
        let result = productoViewModel.Delete(idProducto: Int(IdProducto)!)
        
        if result.Correct{
            let alert  = UIAlertController(title: "CONFIRMACION", message: "PRODUCTO ELIMINADO CORRECTAMENTE", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(ok)
            
            self.present(alert, animated: false)
            
        }
        else{
            let alertError  = UIAlertController(title: "ERROR", message: "PRODUCTO NO ELIMINADO", preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default)
    
    alertError.addAction(ok)
    
    self.present(alertError, animated: false)
            
        }
        
        
    }
    
    
    
}

