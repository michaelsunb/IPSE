//
//  MasterDAO.swift
//  IPSE
//
//  Created by Monster on 22/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//
//  This Class provides a layer of abstraction to decouple DAO from the model.
//  This allows DAO to be changed without affecting the model.

import Foundation

class MasterDAO {
    private let dataAccessObject:BlueMixDAO
    init (){
        dataAccessObject = BlueMixDAO()
    }
    
    func loginRequest() -> Bool{
        return dataAccessObject.loginRequest()
    }
    
    func getAllProducts() -> NSArray?{
        return dataAccessObject.getAllProducts()
    }
}