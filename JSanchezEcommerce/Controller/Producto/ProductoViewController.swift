//
//  ViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 27/12/22.
//

import UIKit

class ProductoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var ActionButton: UIButton!
    
    var idProducto : Int? = nil
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var ImageProducto: UIImageView!
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
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.isEditing = false
        
        Validar()
        
    }
    
    func Validar(){
        if self.idProducto == nil {
            
            ActionButton.setTitle("INSERT", for: .normal)
            ImageProducto.image = UIImage(named: "imgProducto")
        }
        else{
            ActionButton.setTitle("UPDATE", for: .normal)
            
            let result : Result = productoViewModel.GetById(idProducto: idProducto!)
            
            if result.Correct{
                let producto = result.Object as! Producto
                
                NombreTextField.text = producto.Nombre
                PrecioUnitarioTextField.text = String(producto.PrecioUnitario)
                StockTextField.text = String(producto.Stock)
                DescripcionTextField.text = producto.Descripcion
                IdProveddorTextField.text = String(producto.Proveedor!.IdProveedor)
                IdDepartamentoTextField.text = String(producto.Departamento!.IdDepartamento)
                
                if producto.Imagen == ""{
                    ImageProducto.image = UIImage(named: "imgProducto")
                }
                else{
                    ImageProducto.image = UIImage(data: Data(base64Encoded: producto.Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)
                }
                
            }
            else{
                print("ERROR")
            }
        }
        
    }
    
    //BOTON UPDATE
    /*@IBAction func UpdateButton(_ sender: UIButton) {
        
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
    }*/
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        ImageProducto.image = info[.originalImage] as? UIImage
        
        //convertir a base64
        
        dismiss(animated: true, completion: nil)
    }
    
    //BOTON IMAGEN
    @IBAction func ImageButton() {
        
        self.present(imagePicker, animated: true)
    }
    
    
    //BOTON ACTION
    @IBAction func ActionButton(_ sender: UIButton) {
        
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
        
        let image = ImageProducto.image!
        let imageString : String
        
        if ImageProducto.restorationIdentifier == "imgProducto"{
            imageString = ""
        }
        else{
            let imageData = image.pngData()! as NSData
            imageString = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        
        productoModel = Producto(IdProducto: 0, Nombre: Nombre, PrecioUnitario: Double(PrecioUnitario)!, Stock: Int(Stock)!, Descripcion: Descripcion, Proveedor: Proveedor(IdProveedor: Int(IdProveedor)!, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: Int(IdDepartamento)!, Nombre: "", Area:Area(IdArea: 0, Nombre: "")), Imagen: imageString)
        
        if sender.currentTitle == "INSERT"{
            
            let result = productoViewModel.Add(producto: productoModel!)
            
            if result.Correct{
                
                let alert  = UIAlertController(title: "CONFIRMACION", message: "PRODUCTO AGREGADO", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: false)
                
                NombreTextField.text = ""
                PrecioUnitarioTextField.text = ""
                StockTextField.text = ""
                DescripcionTextField.text = ""
                IdProveddorTextField.text = ""
                IdDepartamentoTextField.text = ""
                
            }
            else{
                let alertError  = UIAlertController(title: "ERROR", message: "PRODUCTO NO AGREGADO", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alertError.addAction(ok)
                
                self.present(alertError, animated: false)
                
                NombreTextField.text = ""
                PrecioUnitarioTextField.text = ""
                StockTextField.text = ""
                DescripcionTextField.text = ""
                IdProveddorTextField.text = ""
                IdDepartamentoTextField.text = ""
                ImageProducto.image = UIImage(named: "imgProducto")
                
            }
        }
        else if sender.currentTitle == "UPDATE"{
            
            productoModel = Producto(IdProducto: self.idProducto!, Nombre: Nombre, PrecioUnitario: Double(PrecioUnitario)!, Stock: Int(Stock)!, Descripcion: Descripcion, Proveedor: Proveedor(IdProveedor: Int(IdProveedor)!, Nombre: "", Telefono: ""), Departamento: Departamento(IdDepartamento: Int(IdDepartamento)!, Nombre: "", Area:Area(IdArea: 0, Nombre: "")), Imagen: imageString)
            
            let result = productoViewModel.Update(producto: productoModel!)
            
            if result.Correct{
                
                let alert  = UIAlertController(title: "CONFIRMACION", message: "PRODUCTO ACTUALIZADO", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: false)
                
                NombreTextField.text = ""
                PrecioUnitarioTextField.text = ""
                StockTextField.text = ""
                DescripcionTextField.text = ""
                IdProveddorTextField.text = ""
                IdDepartamentoTextField.text = ""
                ImageProducto.image = UIImage(named: "imgProducto")
                
            }
            else{
                let alertError  = UIAlertController(title: "ERROR", message: "PRODUCTO NO ACTUALIZADO", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alertError.addAction(ok)
                
                self.present(alertError, animated: false)
                
                NombreTextField.text = ""
                PrecioUnitarioTextField.text = ""
                StockTextField.text = ""
                DescripcionTextField.text = ""
                IdProveddorTextField.text = ""
                IdDepartamentoTextField.text = ""
                
            }
            
            }
    }
    
    //BOTON DELETE
    /*@IBAction func DeleteButton(_ sender: UIButton) {
        
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
        
        
    }*/
    
}

