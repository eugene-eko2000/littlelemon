//
//  Menu.swift
//  Little Lemon
//
//  Created by Evgeny Koshelev on 02.06.23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    
    func getMenuData() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            PersistenceController.shared.clear()
            if let data {
                let decoder = JSONDecoder()
                if let menu = try? decoder.decode(MenuList.self, from: data) {
                    menu.menu.forEach() { menuItem in
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.descr = menuItem.description
                    }
                    try? viewContext.save()
                }
            }
        }
        task.resume()
    }

    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    var body: some View {
        VStack {
            Text("Little lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes server with a modern twist.")
            TextField("Search...", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) {(dishes: [Dish]) in
                List {
                    ForEach(dishes) {dish in
                        HStack {
                            Text(dish.title!)
                            Text(dish.price!)
                            AsyncImage(url: URL(string: dish.image!)) { phase in
                                if let image = phase.image {
                                    image.resizable().scaledToFit()
                                }
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
            }
        }
        .padding()
        .onAppear {
            getMenuData()
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
