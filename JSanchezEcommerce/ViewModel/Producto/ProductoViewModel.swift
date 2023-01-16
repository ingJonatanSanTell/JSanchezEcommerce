//
//  ProductoViewModel.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 28/12/22.
//

import Foundation
import SQLite3

class ProductoViewModel{
    
    let productoModel : Producto? = nil
    
    //ADD
    func Add(producto : Producto) -> Result {
        
        var result = Result()
        let context = DB.init()
        
        let query = "INSERT INTO Producto(Nombre, PrecioUnitario, Stock, Descripcion, IdProveedor, IdDepartamento, Imagen) VALUES (?,?,?,?,?,?,?)"
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, (producto.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_double(statement, 2, Double(producto.PrecioUnitario))
                sqlite3_bind_int(statement, 3, Int32(producto.Stock))
                sqlite3_bind_text(statement, 4, (producto.Descripcion as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 5, Int32(producto.Proveedor!.IdProveedor))
                sqlite3_bind_int(statement, 6, Int32(producto.Departamento!.IdDepartamento))
                sqlite3_bind_text(statement, 7, (producto.Imagen as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    
                }
                else
                {
                    result.Correct = false
                }
            }
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    //UPDATE
    func Update(producto : Producto) -> Result {
        
        var result = Result()
        let context = DB.init()
        
        let query = "UPDATE Producto SET Nombre = ?, PrecioUnitario = ?, Stock = ?, Descripcion = ? , IdProveedor = ?, IdDepartamento = ?, Imagen = ? WHERE IdProducto = ?"
        
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, (producto.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_double(statement, 2, Double(producto.PrecioUnitario))
                sqlite3_bind_int(statement, 3, Int32(producto.Stock))
                sqlite3_bind_text(statement, 4, (producto.Descripcion as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 5, Int32(producto.Proveedor!.IdProveedor))
                sqlite3_bind_int(statement, 6, Int32(producto.Departamento!.IdDepartamento))
                sqlite3_bind_text(statement, 7, (producto.Imagen as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 8, Int32(producto.IdProducto))
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    
                }
                else
                {
                    result.Correct = false
                }
            }
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    //DELETE
    func Delete(idProducto : Int) -> Result{
        
        var result = Result()
        let context = DB.init()
        
        let query = "DELETE FROM Producto WHERE IdProducto = \(idProducto)"
        
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                let producto = Producto()
                sqlite3_bind_int(statement, 1, Int32(producto.IdProducto))
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    
                }
                else
                {
                    result.Correct = false
                }
            }
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
            
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
        
    }
    
    //GETALL
    func GetAll() -> Result{
        
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdProducto, Nombre, PrecioUnitario, Stock, Descripcion, IdProveedor, IdDepartamento, Imagen FROM Producto"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var producto = Producto()
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement, 2))
                    producto.Stock = Int(sqlite3_column_int(statement, 3))
                    producto.Descripcion = String(cString: sqlite3_column_text(statement, 4))
                    producto.Proveedor = Proveedor()
                    producto.Proveedor?.IdProveedor = Int(sqlite3_column_int(statement, 5))
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 6))
                    
                    if sqlite3_column_text(statement, 7) != nil{
                        producto.Imagen = String(cString: sqlite3_column_text(statement, 7))
                    }
                    else{
                        producto.Imagen = ""
                    }
                    
                    result.Objects?.append(producto)
                }
                result.Correct = true
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    
    //GETBYID
    func GetById(idProducto : Int) -> Result{
        
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdProducto, Nombre, PrecioUnitario, Stock, Descripcion, IdProveedor, IdDepartamento, Imagen FROM Producto WHERE IdProducto = \(idProducto)"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var producto = Producto()
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement, 2))
                    producto.Stock = Int(sqlite3_column_int(statement, 3))
                    producto.Descripcion = String(cString: sqlite3_column_text(statement, 4))
                    producto.Proveedor = Proveedor()
                    producto.Proveedor?.IdProveedor = Int(sqlite3_column_int(statement, 5))
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 6))
                    
                    if sqlite3_column_text(statement, 7) != nil{
                        producto.Imagen = String(cString: sqlite3_column_text(statement, 7))
                    }
                    else{
                        producto.Imagen = ""
                    }
                    
                    result.Object = producto
                }
                result.Correct = true
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
        
    }
    
    //GETBYID POR DEPARTAMENTO
    func GetByIdDepartamento(_ idDepartamento : Int) -> Result{
        
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdProducto, Nombre, PrecioUnitario, Stock, Descripcion, IdProveedor, IdDepartamento, Imagen FROM Producto WHERE IdDepartamento = \(idDepartamento)"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var producto = Producto()
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement, 2))
                    producto.Stock = Int(sqlite3_column_int(statement, 3))
                    producto.Descripcion = String(cString: sqlite3_column_text(statement, 4))
                    producto.Proveedor = Proveedor()
                    producto.Proveedor?.IdProveedor = Int(sqlite3_column_int(statement, 5))
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 6))
                    
                    if sqlite3_column_text(statement, 7) != nil{
                        producto.Imagen = String(cString: sqlite3_column_text(statement, 7))
                    }
                    else{
                        producto.Imagen = ""
                    }
                    
                    result.Objects?.append(producto)
                }
                result.Correct = true
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
        
    }
    
    //GETBYID POR DEPARTAMENTO
    func GetByNombreProducto(_ nombreProducto : String) -> Result{
        
        var result = Result()
        let context = DB.init()
        let query = "SELECT IdProducto, Nombre, PrecioUnitario, Stock, Descripcion, IdProveedor, IdDepartamento, Imagen FROM Producto WHERE Nombre LIKE '%'||ltrim(rtrim('\(nombreProducto)'))||'%'"
        
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var producto = Producto()
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(cString: sqlite3_column_text(statement, 1))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement, 2))
                    producto.Stock = Int(sqlite3_column_int(statement, 3))
                    producto.Descripcion = String(cString: sqlite3_column_text(statement, 4))
                    producto.Proveedor = Proveedor()
                    producto.Proveedor?.IdProveedor = Int(sqlite3_column_int(statement, 5))
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 6))
                    
                    if sqlite3_column_text(statement, 7) != nil{
                        producto.Imagen = String(cString: sqlite3_column_text(statement, 7))
                    }
                    else{
                        producto.Imagen = ""
                    }
                    
                    result.Objects?.append(producto)
                }
                result.Correct = true
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
        
    }
    
}
