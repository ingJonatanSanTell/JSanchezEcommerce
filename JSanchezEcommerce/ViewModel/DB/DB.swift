//
//  DB.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 27/12/22.
//

import Foundation
import SQLite3

class DB{
    let path : String = "Document.JSanchezEcommerce"
    var db : OpaquePointer? = nil
    
    init(){
        db = OpenConexion()
    }
    
    func OpenConexion() -> OpaquePointer? {
        
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension(self.path)
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) == SQLITE_OK{
            print("CONEXION CORRECTA")
            print(filePath)
            return db
        }
        else{
            print("ERROR AL CONECTAR")
            return nil
        }
    }
}
