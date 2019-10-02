//
//  EmpCoreDataView.swift
//  EmployeeManager
//
//  Created by Huy Ong on 9/30/19.
//  Copyright © 2019 Huy Ong. All rights reserved.
//

import SwiftUI

struct EmpCoreDataView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: EmpItem.getAllToDoItem()) var empItems: FetchedResults<EmpItem>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.empItems) { item in
                    NavigationLink(destination: Text("\(item.firstName ?? "None")")) {
                        EmpDetailView(firstName: item.firstName ?? "None", lastName: item.lastName ?? "None", jobTitle: item.jobTitle ?? "None", isMale: item.isMale)
                    }
                }.onDelete { index in
                    let deleteItem = self.empItems[index.first!]
                    self.managedObjectContext.delete(deleteItem)
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                }
            }.navigationBarTitle(Text("Employees"))
        }
    }
}

struct EmpCoreDataView_Previews: PreviewProvider {
    static var previews: some View {
        EmpCoreDataView()
    }
}

struct EmpDetailView: View {
    var firstName: String
    var lastName: String
    var jobTitle: String
    var isMale: Bool
    var body: some View {
        return VStack {
            HStack(alignment: .top) {
                Image(isMale ? "maleEmp" : "femaleEmp")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    .overlay(Circle().stroke(lineWidth: 1))
                    .shadow(radius: 3.5)
                VStack(alignment: .leading) {
                    HStack(spacing: 3) {
                        Text("\(firstName)").font(.headline)
                        Text("\(lastName)").font(.headline)
                    }
                    Text("\(jobTitle)").font(.subheadline)
                }
            }
        }
    }
}
