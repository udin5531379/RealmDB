//
//  DBViewModel.swift
//  CRUD
//
//  Created by Udin Rajkarnikar on 1/13/21.
//

import SwiftUI
import RealmSwift

class DBViewModel: ObservableObject {
    @Published var title = ""
    @Published var detail = ""
    
    @Published var openNewPage = false
    
    
    @Published var cards: [Card] = []
    
    init() {
        fetchData()
    }
    
    //Now adding the data
    func addData() {
        let card = Card()
        card.title = title
        card.details = detail
        
        //Getting referenc of database
        guard let dbRef = try? Realm() else { return }
        
        //writing data
        try? dbRef.write{
            dbRef.add(card)
            
            //updating the UI
            fetchData()
        }
    }
    
    //fetch the entered data
    func fetchData(){
        guard let dbRef = try? Realm() else { return }
        
        let fetchedData = dbRef.objects(Card.self)
        
        //Displaying results
        self.cards = fetchedData.compactMap({ (card) -> Card? in
            return card
        })
    }
    
}
