//
//  Test.swift
//  EmployeeManager
//
//  Created by Huy Ong on 9/29/19.
//  Copyright © 2019 Huy Ong. All rights reserved.
//

import SwiftUI

struct AddEmpView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: EmpItem.getAllToDoItem()) var empItems: FetchedResults<EmpItem>
    
    @State private var newEmpFirstName = ""
    @State private var newEmpLastName = ""
    @State private var newJobTitle = ""
    @State private var isMale = false
    @State private var alertFinished = false
    @State private var alertShow = false
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("First name")
                        TextField("First name", text: self.$newEmpFirstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text("Last name")
                        TextField("Last name", text: self.$newEmpLastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Job title")
                    TextField("Input what they do at work", text: self.$newJobTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding()
                
                VStack(alignment: .leading) {
                    Text("Gender")
                    Toggle(isOn: self.$isMale) {
                        Text("Toggle if male").font(.subheadline)
                    }
                }.padding()
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                        if (self.newEmpFirstName != "" && self.newJobTitle != "" && self.newEmpLastName != "") {
                            let empItem = EmpItem(context: self.managedObjectContext)
                            
                            empItem.firstName = self.newEmpFirstName
                            empItem.lastName = self.newEmpLastName
                            empItem.jobTitle = self.newJobTitle
                            empItem.isMale = self.isMale
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                            self.newEmpFirstName = ""
                            self.newEmpLastName = ""
                            self.newJobTitle = ""
                            self.alertFinished = true
                            self.endEditing(true)
                        } else {
                            self.alertFinished = false
                        }
                        
                        self.alertShow = true
                        
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(30)
                    }.alert(isPresented: $alertShow) {
                        if (self.alertFinished == true) {
                            return Alert(title: Text("Done"), message: Text("Successful added employee"), dismissButton: .cancel())
                        } else {
                            return Alert(title: Text("Uncorrect!"), message: Text("Check your input"), dismissButton: .cancel())
                        }
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text("Adding"))
        }
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        AddEmpView()
    }
}

extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.keyWindow?.endEditing(force)
    }
}
