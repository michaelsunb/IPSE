//
//  Model.swift
//  SwiftCallURL
//
//  Created by Monster on 21/05/2015.
//  Copyright (c) 2015 Monster. All rights reserved.
//

import Foundation


class Model {
    private let dataAccessObject:BlueMixDAO
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
        dataAccessObject = BlueMixDAO()
    }
    
    func getString() -> String{
        return "Testing the model --> GetString Method"
    }
    
    func login() -> Bool{
        return dataAccessObject.loginRequest()
    }
}