//
//  UsuarioViewModel.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 05/01/23.
//

import Foundation
import CoreData
import UIKit

class UsuarioViewModel{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(usuario : User) -> Result{
        
        var result = Result()
        
        do{
            let context = appDelegate.persistentContainer.viewContext
            
            
            let entidad = NSEntityDescription.entity(forEntityName: "Usuario", in: context)
            let usuarioCoreData = NSManagedObject(entity: entidad!, insertInto: context)
            
            usuarioCoreData.setValue(usuario.UserName, forKey: "userName")
            usuarioCoreData.setValue(usuario.Nombre, forKey: "nombre")
            usuarioCoreData.setValue(usuario.ApellidoPaterno, forKey: "apellidoPaterno")
            usuarioCoreData.setValue(usuario.ApellidoMaterno, forKey: "apellidoMaterno")
            usuarioCoreData.setValue(usuario.Email, forKey: "email")
            usuarioCoreData.setValue(usuario.Password, forKey: "password")
            usuarioCoreData.setValue(usuario.FechaNacimiento, forKey: "fechaNacimiento")
            usuarioCoreData.setValue(usuario.Sexo, forKey: "sexo")
            usuarioCoreData.setValue(usuario.Telefono, forKey: "telefono")
            usuarioCoreData.setValue(usuario.Celular, forKey: "celular")
            usuarioCoreData.setValue(usuario.Curp, forKey: "curp")
            usuarioCoreData.setValue(usuario.Imagen, forKey: "imagen")
            
            try! context.save()
            
            result.Correct = true
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    func Update(usuario : User, idUsuario: Int) -> Result{
        
        var result = Result()
        
        do{
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            let usuarios = try context.fetch(request) as! [NSManagedObject]
            
            usuarios[idUsuario].setValue(usuario.UserName, forKey: "userName")
            usuarios[idUsuario].setValue(usuario.Nombre, forKey: "nombre")
            usuarios[idUsuario].setValue(usuario.ApellidoPaterno, forKey: "apellidoPaterno")
            usuarios[idUsuario].setValue(usuario.ApellidoMaterno, forKey: "apellidoMaterno")
            usuarios[idUsuario].setValue(usuario.Email, forKey: "email")
            usuarios[idUsuario].setValue(usuario.Password, forKey: "password")
            usuarios[idUsuario].setValue(usuario.FechaNacimiento, forKey: "fechaNacimiento")
            usuarios[idUsuario].setValue(usuario.Sexo, forKey: "sexo")
            usuarios[idUsuario].setValue(usuario.Telefono, forKey: "telefono")
            usuarios[idUsuario].setValue(usuario.Celular, forKey: "celular")
            usuarios[idUsuario].setValue(usuario.Curp, forKey: "curp")
            usuarios[idUsuario].setValue(usuario.Imagen, forKey: "imagen")
            
            try! context.save()
            result.Correct = true
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    func GetAll() -> Result{
        
        var result = Result()
        
        do{
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        let usuarios = try context.fetch(request) as! [NSManagedObject]
        
            result.Objects = []
            
            for usuario in usuarios{
            
            let user = User(IdUsuario: Int(usuario.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!,
                           UserName: usuario.value(forKey: "userName") as! String,
                           Nombre: usuario.value( forKey: "nombre") as! String,
                           ApellidoPaterno: usuario.value( forKey: "apellidoPaterno") as! String,
                           ApellidoMaterno: usuario.value( forKey: "apellidoMaterno") as! String,
                           Email: usuario.value( forKey: "email") as! String,
                           Password: usuario.value( forKey: "password") as! String,
                           FechaNacimiento: usuario.value( forKey: "fechaNacimiento") as! Date,
                            Sexo: usuario.value( forKey: "sexo") as! String,
                           Telefono: usuario.value(forKey: "telefono") as! String,
                           Celular: usuario.value(forKey: "celular") as! String,
                           Curp: usuario.value(forKey: "curp") as! String,
                           Imagen: usuario.value(forKey: "imagen") as! String)

                
            result.Objects?.append(user)
        }
            result.Correct = true
        
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
    
    func GetById(idUsuario : Int) -> Result{
        
        var result = Result()
        
        do{
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        let usuarios = try context.fetch(request) as! [NSManagedObject]
        
            let user = User(IdUsuario: Int(usuarios[idUsuario].objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!,
                           UserName: usuarios[idUsuario].value(forKey: "userName") as! String,
                           Nombre: usuarios[idUsuario].value( forKey: "nombre") as! String,
                           ApellidoPaterno: usuarios[idUsuario].value( forKey: "apellidoPaterno") as! String,
                           ApellidoMaterno: usuarios[idUsuario].value( forKey: "apellidoMaterno") as! String,
                           Email: usuarios[idUsuario].value( forKey: "email") as! String,
                           Password: usuarios[idUsuario].value( forKey: "password") as! String,
                           FechaNacimiento: usuarios[idUsuario].value( forKey: "fechaNacimiento") as! Date,
                           Sexo: usuarios[idUsuario].value( forKey: "sexo") as! String,
                           Telefono: usuarios[idUsuario].value(forKey: "telefono") as! String,
                           Celular: usuarios[idUsuario].value(forKey: "celular") as! String,
                           Curp: usuarios[idUsuario].value(forKey: "curp") as! String,
                           Imagen: usuarios[idUsuario].value(forKey: "imagen") as! String)
                
                //usuario.IdUsuario = objUsuario.objectID.uriRepresentation().absoluteString

                
            result.Object = user
            result.Correct = true
            
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }

        
    
    func Delete(idUsuario : Int) -> Result{
        
        var result = Result()
        
        do{
            
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            let usuarios = try context.fetch(request) as! [NSManagedObject]
            
            context.delete(usuarios[idUsuario])
            
            try context.save()
            result.Correct = true
            
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        
        return result
    }
}
