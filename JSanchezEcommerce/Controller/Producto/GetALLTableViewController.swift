//
//  GetALLTableViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 30/12/22.
//

import UIKit
import SwipeCellKit

enum ProviderType: String{
    case basic
}

class GetALLTableViewController: UITableViewController {
    
    

    let productoViewModel = ProductoViewModel()
    var productos = [Producto]()
    
    var idProducto = 0
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden =  false
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ProductoTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductoCell")
        loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewWillAppear")
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("ViewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("ViewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("ViewDidDisappear")
    }
    
    func loadData(){
        let result = productoViewModel.GetAll()
        
        if result.Correct{
            productos = result.Objects! as! [Producto]
            tableView.reloadData()
            
        }
        else{
            //alerta
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoTableViewCell
        
        cell.delegate = self
        cell.NombreLabel.text = productos[indexPath.row].Nombre
        cell.PrecioUnitarioLabel.text = String(productos[indexPath.row].PrecioUnitario)
        cell.StockLabel.text = String(productos[indexPath.row].Stock)
        cell.DescripcionLabel.text = productos[indexPath.row].Descripcion
        
        if productos[indexPath.row].Imagen == ""{
            cell.ImageProductoLabel.image = UIImage(named: "imgProducto")
        }
        else{
            cell.ImageProductoLabel.image = UIImage(data: Data(base64Encoded: productos[indexPath.row].Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)
        }
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}



extension GetALLTableViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
     
        
        if orientation == .right {
            
            //delete
            let deleteAction = SwipeAction(style: .destructive, title: "DELETE") { action, indexPath in
                
                self.idProducto = self.productos[indexPath.row].IdProducto
                let result = self.productoViewModel.Delete(idProducto: self.idProducto)
                self.loadData()
                
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
            
            
        }else{
            
            //update
            let updateAction = SwipeAction(style: .default, title: "UPDATE") { action, indexPath in
                
                self.idProducto = self.productos[indexPath.row].IdProducto
                let result = self.performSegue(withIdentifier: "UpdateSegue", sender: self)
            }
            
            updateAction.image = UIImage(systemName: "repeat")
            updateAction.backgroundColor = .green
            return [updateAction]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UpdateSegue"{
            let productoForm = segue.destination as! ProductoViewController
            productoForm.idProducto = self.idProducto
        }
    }
}
