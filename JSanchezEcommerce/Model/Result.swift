//
//  Result.swift
//  JSanchezEcommerce
//
//  Created by MacBookMBA4 on 28/12/22.
//

import Foundation

struct Result{
    var ErrorMessage : String
    var Object : Any?
    var Objects : [Any]?
    var Ex : Error?
    var Correct : Bool
    
    init(ErrorMessage: String, Object: Any? = nil, Objects: [Any]? = nil, Ex: Error? = nil, Correct: Bool) {
        self.ErrorMessage = ErrorMessage
        self.Object = Object
        self.Objects = Objects
        self.Ex = Ex
        self.Correct = Correct
    }
    
    init(){
        self.ErrorMessage = ""
        self.Object = nil
        self.Objects = nil
        self.Ex = nil
        self.Correct = false
    }
}
