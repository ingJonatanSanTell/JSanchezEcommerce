//
//  GetAllProductCollectionViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 12/01/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class GetByIdProductosCollectionViewController: UICollectionViewController {
    
    var idDepartamento : Int! = nil
    var busquedaProducto : String! = nil
    
    var productos = [Producto]()
    let productoViewModel = ProductoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        navigationController?.isNavigationBarHidden = false
        
        loadData()
        
        self.collectionView!.register(UINib(nibName: "ProductosCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ProductoCard")
        
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        
        if self.idDepartamento == nil {
            
            let result = productoViewModel.GetByNombreProducto(self.busquedaProducto)
            
            if result.Correct{
                productos = result.Objects! as! [Producto]
                collectionView.reloadData()
            }
            
        }
        else if self.busquedaProducto == nil {
            
            let result = productoViewModel.GetByIdDepartamento(self.idDepartamento)
            
            if result.Correct{
                productos = result.Objects! as! [Producto]
                collectionView.reloadData()
            }
            
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
        return productos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductoCard", for: indexPath) as! ProductosCollectionViewCell
        
        cell.NombreProductoLabel.text = productos[indexPath.row].Nombre
        cell.PrecioProductolabel.text = "$"+(String(productos[indexPath.row].PrecioUnitario))
        
        if productos[indexPath.row].Imagen == ""{
            cell.ImagenProducto.image = UIImage(named: "imgProducto")
        }
        else{
            cell.ImagenProducto.image = UIImage(data: Data(base64Encoded: productos[indexPath.row].Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)
        }
    
        cell.AgregarCarritoButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        // agregando como `tag` el indice del `row`...
        cell.AgregarCarritoButton.tag = indexPath.row
    
        return cell
    }
    
    
    @objc func buttonAction(sender : UIButton){
        
        let index = IndexPath(row: sender.tag, section: 0)
        sender.backgroundColor = UIColor.red
        
        self.performSegue(withIdentifier: "carritoSegue", sender: self)
        
        let alertController  = UIAlertController(title: "Agregado a tu Carrito", message: "Nombre: \(productos[index.row].Nombre) \n IdProducto: \(productos[index.row].IdProducto)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
        
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

extension GetByIdProductosCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: 500, height: 300)
        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        return sectionInset
    }
    
    
}
