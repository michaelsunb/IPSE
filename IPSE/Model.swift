//
//  Model.swift
//  SwiftCallURL
//
//  Created by Monster on 21/05/2015.
//  Copyright (c) 2015 Monster. All rights reserved.
//

import Foundation


class Model {
    private let masterDataAccessObject:MasterDAO
    private var productsArray = [Products]()
    
    private struct Static
    {
        static private var instance:Model?
    }
    
    class var sharedInstance: Model
    {
        if !(Static.instance != nil)
        {
            Static.instance = Model()
        }
        return Static.instance!
    }
    
    private init(){
        masterDataAccessObject = MasterDAO()
    }
    
    func getString() -> String{
        return "Testing the model --> GetString Method"
    }
    
    func loginRequest() -> Bool{
        return masterDataAccessObject.loginRequest()
    }
    
    func getAllProducts() -> NSArray?{
        return masterDataAccessObject.getAllProducts()
    }
    
    func addProductToArray(product:Products) {
        productsArray.append(product)
    }
    
    func getAllProductsFromArray() -> [Products] {
        return productsArray
    }
    
    func iterateProducts() {
        println("productArray size is ")
        println(productsArray.count)
        for var i=0; i < productsArray.count; i++ {
            println(productsArray[i].getName())
        }
    }
//    
//    func getProductResult() {
//        println("This is the product Result")
//    }
}