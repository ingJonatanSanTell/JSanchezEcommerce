//
//  Producto.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 28/12/22.
//

import Foundation

struct Producto{
    var IdProducto : Int
    var Nombre : String
    var PrecioUnitario : Double
    var Stock : Int
    var Descripcion : String
    var Proveedor : Proveedor?
    var Departamento : Departamento?
    var Imagen : String
    
    init(IdProducto: Int, Nombre: String, PrecioUnitario: Double, Stock: Int, Descripcion: String, Proveedor: Proveedor? = nil, Departamento: Departamento? = nil, Imagen: String, productos: [Producto]) {
        self.IdProducto = IdProducto
        self.Nombre = Nombre
        self.PrecioUnitario = PrecioUnitario
        self.Stock = Stock
        self.Descripcion = Descripcion
        self.Proveedor = Proveedor
        self.Departamento = Departamento
        self.Imagen = Imagen
    }
    
    init(){
        
        self.IdProducto = 0
        self.Nombre = ""
        self.PrecioUnitario = 0.0
        self.Stock = 0
        self.Descripcion = ""
        self.Proveedor = nil
        self.Departamento = nil
        self.Imagen = ""
        
    }
}

