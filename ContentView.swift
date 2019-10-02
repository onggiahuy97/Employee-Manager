//
//  ContentView.swift
//  EmployeeManager
//
//  Created by Huy Ong on 9/29/19.
//  Copyright © 2019 Huy Ong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EmpCoreDataView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.dash").imageScale(.large)
                        Text("List").font(.headline)
                    }
            }
            .tag(0)
            
            Search()
                .tabItem {
                    VStack {
                        Image(systemName: "list.dash").imageScale(.large)
                        Text("Search").font(.headline)
                    }
            }.tag(1)
            
            AddEmpView()
                .tabItem {
                    VStack {
                        Image(systemName: "plus.square").imageScale(.large)
                        Text("Add").font(.headline)
                    }
            }
            .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

