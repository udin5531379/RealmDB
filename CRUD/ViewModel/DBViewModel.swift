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
    
    @Published var updateObject: Card?
    
    init() {
        fetchData()
    }
    
    
    
    //Now adding the data
    func addData(presentation: Binding<PresentationMode>) {
        
        if title == "" || detail == "" { return }

        let card = Card()
        card.title = title
        card.details = detail
        
        print(self.title, self.detail)
        
        //Getting referenc of database
        guard let dbRef = try? Realm() else { return }
        
        //writing data
        try? dbRef.write{
            guard let availableObject = updateObject else { //naya data aauda chahe updaet object nil huncha so false jasto bhaeyra else ko part ma jancha
                //new data thaapda exectur huncha and sidhai return bhayera fetchData ma jancha
                dbRef.add(card)
                print("11", updateObject)
                return
            }
            print("update onject ", updateObject)
            print("available object \(availableObject)")
            
            availableObject.title = title
            availableObject.details = detail
        }
        //updating the UI
        fetchData()
        
        presentation.wrappedValue.dismiss()
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
    
    
    
    //deletion of Data inside the ScrollView
    func deleteData(object: Card){
        guard let dbRef = try? Realm() else { return }
        
        try? dbRef.write{
            dbRef.delete(object)
            fetchData()
        }
        
    }
    
    func setUpInitialData() {
        //context menu bata update bhaneyra click garyobhaeny updateObject ma chahe "md" model data bascha md.title and md.detail
        //but if user clicks sidhai Plus button without updating then updateObject is nil and avialbelObject /= updateObject huncha....
        guard let updateData = updateObject else { return }
        title = updateData.title
        detail = updateData.details
        print("update data ", updateData)
     }
    
    //setting and clearing the data in the new textview
    func deInit() {
        updateObject = nil
        title = ""
        detail = ""
    }
}
