//
//  GetALLDepartamentoTableViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 05/01/23.
//

import UIKit
import SwipeCellKit

class GetALLDepartamentoTableViewController: UITableViewController {
    
    let departamentoViewModel = DepartamentoViewModel()
    var departamentos = [Departamento]()
    
    var idDepartamento = 0

    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden =  false
        super.viewDidLoad()

        tableView.register(UINib(nibName: "DepartamentoTableViewCell", bundle: nil), forCellReuseIdentifier: "DepartamentoCell")
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
        let result = departamentoViewModel.GetAll()
        
        if result.Correct{
            departamentos = result.Objects! as! [Departamento]
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
        return departamentos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartamentoCell", for: indexPath) as! DepartamentoTableViewCell
        
        cell.delegate = self
        cell.NombreDepartamentoLabel.text = departamentos[indexPath.row].Nombre
        cell.IdAreaLabel.text = String(departamentos[indexPath.row].Area!.IdArea)
        
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

extension GetALLDepartamentoTableViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right {
            
            //delete
            let deleteAction = SwipeAction(style: .destructive, title: "DELETE") { action, indexPath in
                
                self.idDepartamento = self.departamentos[indexPath.row].IdDepartamento
                let result = self.departamentoViewModel.Delete(idDepartamento: self.idDepartamento)
                self.loadData()
                
                //ALERT
                if result.Correct{
                    let alert  = UIAlertController(title: "CONFIRMACION", message: "DEPARTAMENTO ELIMINADO", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false)
                    
                }
                else{
                    let alertError  = UIAlertController(title: "ERROR", message: "DEPARTAMENTO NO ELIMINADO", preferredStyle: .alert)
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
                
                self.idDepartamento = self.departamentos[indexPath.row].IdDepartamento
                let result = self.performSegue(withIdentifier: "UpdateDepartamentoSegue", sender: self)
            }
            updateAction.image = UIImage(systemName: "repeat")
            updateAction.backgroundColor = .green
            return [updateAction]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UpdateDepartamentoSegue"{
            let departamentoForm = segue.destination as! DepartamentoViewController
            departamentoForm.idDepartamento = self.idDepartamento
        }
    }
}

