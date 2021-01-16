//
//  Home.swift
//  CRUD
//
//  Created by Udin Rajkarnikar on 1/13/21.
//

import SwiftUI

struct Home: View {
    @StateObject var modelData = DBViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 10){
                    ForEach(modelData.cards) { md in
                        VStack(alignment: .leading, spacing: 10){
                            Text(md.title)
                                .font(.title3)
                            Text(md.details)
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(15)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {modelData.deleteData(object: md)}, label: {
                                Text("Delete Item")
                            })
                            
                            Button(action: {
                                modelData.updateObject = md
                                modelData.openNewPage.toggle()
                            }, label: {
                                Text("Update Item")
                            })
                        }))
                        
                    }.padding(.horizontal)
                }
                
            }
            .navigationTitle("Realm DB")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { modelData.openNewPage.toggle()}, label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    })
                }
                
            })
            .sheet(isPresented: $modelData.openNewPage, content: {
                AddPageView()
                    .environmentObject(modelData)
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
