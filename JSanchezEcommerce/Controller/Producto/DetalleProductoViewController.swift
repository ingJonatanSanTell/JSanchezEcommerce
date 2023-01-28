//
//  DetalleProductoViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 23/01/23.
//

import UIKit

class DetalleProductoViewController: UIViewController {

    @IBOutlet weak var ImageProducto: UIImageView!
    
    @IBOutlet weak var TableViewProducto: UITableView!
    @IBOutlet weak var CantidadProductoField: UITextField!
    
    
    var idProducto : Int! = nil
    var productos = [Producto]()
    var departamento = [Departamento]()
    var proveedor = [Proveedor]()
    let productoViewModel = ProductoViewModel()
    let departamentoViewModel = DepartamentoViewModel()
    let proveedorViewModel = ProveedorViewModel()
    
    let ventaProductoViewModel = VentaProductosViewModel()
    
    var ventaProductos = [VentaProductos]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.TableViewProducto.delegate = self
        self.TableViewProducto.dataSource = self
        
        loadData()

        self.TableViewProducto.register(UINib(nibName: "DetalleProductoTableViewCell", bundle: nil), forCellReuseIdentifier: "DetalleCell")
    }
    
    func loadData(){
        
        if self.idProducto != nil{
            
            let result = productoViewModel.GetById(idProducto: idProducto)
            
            if result.Correct{
                productos = result.Objects! as! [Producto]
                
                
                TableViewProducto.reloadData()
            }
            else{
                //alerta
            }
            
        }
    }
    
    
    @IBAction func AddCarritoButton(_ sender: UIButton) {
        
        let index = IndexPath(row: sender.tag, section: 0)
        sender.backgroundColor = UIColor.red
        
        guard let Cantidad = CantidadProductoField.text, Cantidad != "" else{
            
            //alert
            let alertController  = UIAlertController(title: "ERROR", message: "Coloca Una Cantidad", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
            return
            
        }
        
        //AGREGAR EL ID A LA TABLA CARRITO(VENTAPRODUCTO)
        if ventaProductoViewModel.Add(idProducto: productos[index.row].IdProducto, cantidad: Int(Cantidad) ?? 1).Correct {
            
            //alert
            let alertController  = UIAlertController(title: "Agregado a tu Carrito", message: "Nombre: \(productos[index.row].Nombre) \n Cantidad: \(Cantidad)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ir a mi Carrito", style: .default) { (action) in
               
                self.performSegue(withIdentifier: "carritoSegue", sender: self)
            }
            
            alertController.addAction(ok)
            alertController.addAction(UIAlertAction(title: "Seguir Comprando", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
            CantidadProductoField.text = ""
        }
        else{
            //alert error
            let alertController  = UIAlertController(title: "ERROR", message: "No se pudo agregar el producto a tu carrito", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
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

extension DetalleProductoViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetalleCell", for: indexPath) as! DetalleProductoTableViewCell
        
        cell.NombreProductoLabel.text = productos[indexPath.row].Nombre
        cell.PrecioUnitarioProductoLabel.text = "$"+String(productos[indexPath.row].PrecioUnitario)
        cell.StockProductoLabel.text = String(productos[indexPath.row].Stock)
        cell.DescripcionProductoLabel.text = productos[indexPath.row].Descripcion
        
        //cell proveedor
        let resultProveedor = proveedorViewModel.GetById(idProveedor: productos[indexPath.row].Proveedor!.IdProveedor)
        if resultProveedor.Correct {
            
            proveedor = resultProveedor.Objects! as! [Proveedor]
            cell.ProveedorProductoLabel.text = proveedor[indexPath.row].Nombre
        }
        
        //cell departamento
        let resultDepartamento = departamentoViewModel.GetById(idDepartamento: productos[indexPath.row].Departamento!.IdDepartamento)
        if resultDepartamento.Correct {
            
            departamento = resultDepartamento.Objects! as! [Departamento]
            cell.DepartamentoProductoLabel.text = departamento[indexPath.row].Nombre
        }
        
        ImageProducto.image = UIImage(data: Data(base64Encoded: productos[indexPath.row].Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)
            
//            let producto = Producto()
//
//            if producto.Imagen == ""{
//                ImageProducto.image = UIImage(named: "imgProducto")
//            }
//            else{
//                ImageProducto.image = UIImage(data: Data(base64Encoded: producto.Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)
//            }
        
        return cell
    }
    
}
