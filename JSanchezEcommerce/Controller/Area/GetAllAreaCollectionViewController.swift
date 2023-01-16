//
//  GetAllAreaCollectionViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 12/01/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class GetAllAreaCollectionViewController: UICollectionViewController {
    
    var areas = [Area]()
    var idArea : Int! = nil
    let areaViewModel = AreaViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        navigationController?.isNavigationBarHidden = false
        
        loadData()
        self.collectionView!.register(UINib(nibName: "AreasCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "AreaCard")

        // Do any additional setup after loading the view.
    }
    
    
    
    func loadData(){
        let result = areaViewModel.GetAll()
        
        if result.Correct{
            areas = result.Objects! as! [Area]
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
        return areas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCard", for: indexPath) as! AreasCollectionViewCell
        
        //cell.delegate = self
        cell.NombreAreaLabel.text = areas[indexPath.row].Nombre
        cell.ImagenArea.image = UIImage(systemName: "list.bullet.rectangle")
    
        return cell
    }
    
    //delegado segue
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.idArea = areas[indexPath.row].IdArea
        self.performSegue(withIdentifier: "GetByIdDepartamento", sender: self)
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

extension GetAllAreaCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    
    
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
    }
    
}
