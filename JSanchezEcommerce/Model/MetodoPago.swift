//
//  MetodoPago.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 26/01/23.
//

import Foundation

struct MetodoPago {
    
    var IdMetodoPago : Int
    var Metodo : String
    
    init(IdMetodoPago: Int, Metodo: String) {
        self.IdMetodoPago = IdMetodoPago
        self.Metodo = Metodo
    }
    
    init(){
        self.IdMetodoPago = 0
        self.Metodo = ""
    }
}
