//
//  Card.swift
//  CRUD
//
//  Created by Udin Rajkarnikar on 1/13/21.
//

import SwiftUI
import RealmSwift

//creatinf Realm Objects

class Card: Object, Identifiable{
    
    @objc dynamic var id : Date = Date()
    @objc dynamic var title = ""
    @objc dynamic var details = ""
    
}
