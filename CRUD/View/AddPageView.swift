//
//  AddPageView.swift
//  CRUD
//
//  Created by Udin Rajkarnikar on 1/13/21.
//

import SwiftUI

struct AddPageView: View {
    @EnvironmentObject var modeldata : DBViewModel
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Title")) {
                    TextField("", text: $modeldata.title)
                }
                
                Section(header: Text("Details")) {
                    TextField("", text: $modeldata.detail)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Add Your Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        modeldata.addData()
                        modeldata.openNewPage.toggle()
                    }, label: {
                        Text("Done")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {modeldata.openNewPage.toggle()}, label: {
                        Text("Cancel")
                    })
                }
            }
        }
        
    }
}

struct AddPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddPageView()
    }
}
