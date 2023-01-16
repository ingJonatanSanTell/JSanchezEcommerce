//
//  GetAllDepartamentosCollectionViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 12/01/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class GetByIdDepartamentosCollectionViewController: UICollectionViewController {
    
    var departamentos = [Departamento]()
    var idArea : Int! = nil
    var idDepartamento : Int! = nil
    
    let departamentoViewModel = DepartamentoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false
        
        loadData()
        
        self.collectionView!.register(UINib(nibName: "DepartamentoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "DepartamentoCard")

        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        let result = departamentoViewModel.GetByIdArea(idArea)
        
        if result.Correct{
            departamentos = result.Objects! as! [Departamento]
            collectionView.reloadData()
        }
        else{
            //alerta
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return departamentos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DepartamentoCard", for: indexPath) as! DepartamentoCollectionViewCell
        
        cell.DepartamentoLabel.text = departamentos[indexPath.row].Nombre
        cell.ImagenDepartamento.image = UIImage(systemName: "tablecells")
    
        // Configure the cell
    
        return cell
    }
    
    //delegado segue
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.idDepartamento = departamentos[indexPath.row].IdDepartamento
        self.performSegue(withIdentifier: "GetByIdProducto", sender: self)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}

extension GetByIdDepartamentosCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: 150, height: 75)
        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsets(top: 10, left: 35, bottom: 0, right: 35)
        return sectionInset
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GetByIdProducto"{
            let productoById = segue.destination as! GetByIdProductosCollectionViewController
            productoById.idDepartamento = self.idDepartamento
        }
    }
}



