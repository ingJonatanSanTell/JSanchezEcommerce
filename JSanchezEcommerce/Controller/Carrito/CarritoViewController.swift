//
//  CarritoViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 25/01/23.
//

import UIKit
import SwipeCellKit

class CarritoViewController: UIViewController {

    @IBOutlet weak var TableViewCarrito: UITableView!
    @IBOutlet weak var TotalCarritoLabel: UILabel!
    
    var idProducto : Int = 0
    var totalTotal : Double = 0
    var ventaProductos = [VentaProductos]()
    
    let ventaProductoViewModel = VentaProductosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.TableViewCarrito.delegate = self
        self.TableViewCarrito.dataSource = self
        
        loadData()

        self.TableViewCarrito.register(UINib(nibName: "CarritoTableViewCell", bundle: nil), forCellReuseIdentifier: "CarritoCell")
    }
    
    func loadData(){
        
            let result = ventaProductoViewModel.GetAll()
            
            if result.Correct{
                ventaProductos = result.Objects! as! [VentaProductos]
            
                TableViewCarrito.reloadData()
                
                
            }
    }
    
    
    @IBAction func ButtonComprarCarrito(_ sender: UIButton) {
        
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

extension CarritoViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ventaProductos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoTableViewCell
        
        cell.delegate = self
        
        cell.NombreProductoCarritoLabel.text = ventaProductos[indexPath.row].Producto.Nombre
        //cell.PrecioProductoCarritoLabel.text = "$ "+String(ventaProductos[indexPath.row].Producto!.PrecioUnitario)
        cell.CantidadProductoCarritoField.text = String(ventaProductos[indexPath.row].Cantidad)
        
        let totalCarrito =  ventaProductos[indexPath.row].Producto.PrecioUnitario * Double(ventaProductos[indexPath.row].Cantidad)
        totalTotal += totalCarrito
        
        cell.PrecioProductoCarritoLabel.text = "$ "+String(totalCarrito)
        
        cell.ImageProductoCarrito.image = UIImage(data: Data(base64Encoded: ventaProductos[indexPath.row].Producto.Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)
        
        TotalCarritoLabel.text = "$ "+String(totalTotal)
        
        return cell
    }
}

extension CarritoViewController : SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        
        return options
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        //delete
        self.idProducto = indexPath.row
        
        let deleteAction = SwipeAction(style: .destructive, title: "DELETE") { [self] action, indexPath in
            
            let totalTotal2 = totalTotal - Double(self.ventaProductos[indexPath.row].Cantidad) * self.ventaProductos[indexPath.row].Producto.PrecioUnitario
            TotalCarritoLabel.text = "$ "+String(totalTotal2)
            ventaProductos.remove(at: indexPath.row)
            
            let result = ventaProductoViewModel.Delete(idProducto: indexPath.row)


            //ALERT
            if result.Correct{
                let alert  = UIAlertController(title: "CONFIRMACION", message: "PRODUCTO ELIMINADO", preferredStyle: .alert)
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
        deleteAction.image = UIImage(systemName: "trash")
        return [deleteAction]

        
    }
}
