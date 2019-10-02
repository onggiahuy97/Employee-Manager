import SwiftUI

struct Search : View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: EmpItem.getAllToDoItem()) var empItems: FetchedResults<EmpItem>
    let array = ["John","Lena","Steve","Chris","Catalina"]
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView{
            List{
                TextField("Type your search",text: $searchText).textFieldStyle(RoundedBorderTextFieldStyle())
                ForEach(self.empItems.filter{($0.firstName?.hasPrefix(searchText))!
                    || ($0.lastName?.hasPrefix(searchText))!
                    || searchText == ""}, id:\.self) { item in
                    NavigationLink(destination: Text("\(item.firstName ?? "None")")) {
                        EmpDetailView(firstName: item.firstName ?? "None", lastName: item.lastName ?? "None",jobTitle: item.jobTitle ?? "None", isMale: item.isMale)
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
                
            }
            .navigationBarTitle(Text("Search"))
        }
    }
}

struct Search_Previews : PreviewProvider {
  static var previews: some View {
    Search()
  }
}


