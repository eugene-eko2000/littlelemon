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
    @State var selectedCategory: Categories = .mains
    
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
                        dish.category = menuItem.category
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
        var subPredicates = [
            NSPredicate(format: "category == %@", selectedCategory.rawValue),
        ]
        if !searchText.isEmpty {
            subPredicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        return NSCompoundPredicate(
            type: .and,
            subpredicates: subPredicates
        )
    }
    
    var body: some View {
        VStack {
            Hero()
            HStack {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(Categories.allCases, id: \.self) { category in
                        Text(category.rawValue.capitalized)
                    }
                }
            }
            .pickerStyle(.segmented)
            TextField("Search...", text: $searchText).padding(.leading)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) {(dishes: [Dish]) in
                List {
                    ForEach(dishes) {dish in
                        HStack {
                            Text(dish.title!)
                                .frame(width: 120, alignment: .leading)
                            Text("\(dish.price!) $")
                            Spacer()
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 120, height: 70)
                        }
                    }
                }
            }
        }
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
