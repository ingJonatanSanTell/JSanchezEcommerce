//
//  VentaFinalViewController.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 27/01/23.
//

import UIKit
import iOSDropDown

class VentaFinalViewController: UIViewController {
    
    @IBOutlet weak var TableViewVentaFinal: UITableView!
    @IBOutlet weak var MetodoDePagoDropDown: DropDown!
    @IBOutlet weak var SubTotalLabel: UILabel!
    
    var idProducto : Int = 0
    var subTotal : Double = 0
    var ventaProductos = [VentaProductos]()
    var idMeotodoPago : Int = 0
    
    let ventaProductoViewModel = VentaProductosViewModel()
    
    let metodoPagoViewModel = MetodoPagoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //metodo de pago
        MetodoDePagoDropDown.optionArray = [String]()
        MetodoDePagoDropDown.optionIds = [Int]()
        
        MetodoDePagoDropDown.didSelect { selectedText, index, id in
            self.idMeotodoPago = id
        }
        
        
        
        self.TableViewVentaFinal.delegate = self
        self.TableViewVentaFinal.dataSource = self
        
        loadData()

        self.TableViewVentaFinal.register(UINib(nibName: "FinalVentaTableViewCell", bundle: nil), forCellReuseIdentifier: "VentaFinalCell")

        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        
        let resultMetodoPago = metodoPagoViewModel.GetAll()
        if resultMetodoPago.Correct{
            for metodopago in resultMetodoPago.Objects as! [MetodoPago]{
                MetodoDePagoDropDown.optionArray.append(metodopago.Metodo)
                MetodoDePagoDropDown.optionIds?.append(metodopago.IdMetodoPago)
            }
        }
        
            let result = ventaProductoViewModel.GetAll()
            
            if result.Correct{
                ventaProductos = result.Objects! as! [VentaProductos]
            
                TableViewVentaFinal.reloadData()
                
                
            }
    }
    

    @IBAction func FinalizarCompraButton(_ sender: UIButton) {
        
        
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

extension VentaFinalViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ventaProductos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VentaFinalCell", for: indexPath) as! FinalVentaTableViewCell
        
        
        cell.NombreProductoFinalLabel.text = ventaProductos[indexPath.row].Producto.Nombre
        //cell.PrecioProductoCarritoLabel.text = "$ "+String(ventaProductos[indexPath.row].Producto!.PrecioUnitario)
        cell.CantidadProductoFinalLabel.text = "Piezas "+String(ventaProductos[indexPath.row].Cantidad)
        
        let totalVenta =  ventaProductos[indexPath.row].Producto.PrecioUnitario * Double(ventaProductos[indexPath.row].Cantidad)
        subTotal += totalVenta
        
        cell.TotalProductoFinalLabel.text = "SubTotal: $ "+String(totalVenta)
        
        cell.ImagenProductoFinal.image = UIImage(data: Data(base64Encoded: ventaProductos[indexPath.row].Producto.Imagen, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!)
        
        SubTotalLabel.text = "$ "+String(subTotal)
        
        return cell
    }
}
