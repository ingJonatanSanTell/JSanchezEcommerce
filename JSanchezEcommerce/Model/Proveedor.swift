//
//  Proveedor.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 28/12/22.
//

import Foundation

struct Proveedor{
    
    var IdProveedor : Int
    var Nombre : String
    var Telefono : String
    
    init(IdProveedor: Int, Nombre: String, Telefono: String) {
        self.IdProveedor = IdProveedor
        self.Nombre = Nombre
        self.Telefono = Telefono
    }
    init(){
        self.IdProveedor = 0
        self.Nombre = ""
        self.Telefono =  ""
    }
}
