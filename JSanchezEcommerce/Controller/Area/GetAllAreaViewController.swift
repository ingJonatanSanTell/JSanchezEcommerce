//
//  GetAllAreaViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 13/01/23.
//

import UIKit

class GetAllAreaViewController: UIViewController{
    
    @IBOutlet weak var BuscarProductoLabel: UITextField!
    @IBOutlet weak var AreasCollectionView: UICollectionView!
    
    
    var areas = [Area]()
    var idArea : Int! = nil
    let areaViewModel = AreaViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        self.AreasCollectionView.delegate = self
        self.AreasCollectionView.dataSource = self
        
        loadData()
        
        self.AreasCollectionView.register(UINib(nibName: "AreasCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "AreaCard")
        
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        let result = areaViewModel.GetAll()
        
        if result.Correct{
            areas = result.Objects! as! [Area]
            AreasCollectionView.reloadData()
        }
        else{
            //alerta
        }
    }
    
    
    @IBAction func BuscarProductoButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "BuscarProductoSegue", sender: self)
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

extension GetAllAreaViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        areas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCard", for: indexPath) as! AreasCollectionViewCell
        
        cell.NombreAreaLabel.text = areas[indexPath.row].Nombre
        cell.ImagenArea.image = UIImage(systemName: "list.bullet.rectangle")
        
        return cell
    }
    
    //delegado segue
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.idArea = areas[indexPath.row].IdArea
        self.performSegue(withIdentifier: "GetByIdDepartamento", sender: self)
    }
    
    
    //diseño
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
        
        if segue.identifier == "GetByIdDepartamento"{
            
            let departamentoById = segue.destination as! GetByIdDepartamentosCollectionViewController
            departamentoById.idArea = self.idArea
        }
        else if segue.identifier == "BuscarProductoSegue"{
            
            let productoBusqueda = segue.destination as! GetByIdProductosCollectionViewController
            productoBusqueda.busquedaProducto = self.BuscarProductoLabel.text
        }
    }
    
    
    
}
