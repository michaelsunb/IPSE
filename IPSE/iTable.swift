//
//  iTable.swift
//  IPSE
//
//  Created by User on 18/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

class iTable : NSManagedObject{
    
    class var getTableName: String {
        preconditionFailure("This method must be overridden")
    }

    func getId() -> Int {
        preconditionFailure("This method must be overridden")
    }
    
    func newEntry(table:iTable) {
        preconditionFailure("This method must be overridden")
    }
}