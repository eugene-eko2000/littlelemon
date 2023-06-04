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
            VStack {
                HStack {
                    Spacer()
                        .frame(width: 15)
                    Text("Little lemon")
                        .foregroundColor(Color("Yellow"))
                        .font(Font.custom("MarkaziText-Regular", size: 64))
                        .fontWeight(.medium)
                    Spacer()
                }
                .frame(height: 60)
                HStack {
                    Spacer()
                        .frame(width: 15)
                    Text("Chicago")
                        .foregroundColor(Color("TextForeground"))
                        .font(Font.custom("MarkaziText-Regular", size: 40))
                    Spacer()
                }
                .frame(height: 40)
                HStack {
                    Spacer().frame(width: 15)
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes server with a modern twist.")
                        .foregroundColor(Color("TextForeground"))
                        .font(Font.custom("Karla-Regular", size: 18))
                        .fontWeight(.regular)
                    Spacer()
                    Image("Hero image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130, height: 130)
                        .cornerRadius(16)
                    Spacer().frame(width: 15)
                }
                .frame(height: 110)
                HStack {
                    Spacer()
                        .frame(width: 15)
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                        .frame(width: 15)
                }
                .frame(height: 70)
            }
            .background(Color("Green"))
            VStack {
                HStack {
                    Spacer()
                        .frame(width: 15)
                    Text("ORDER FOR DELIVERY!")
                        .font(Font.custom("Karla-Bold", size: 18))
                        .bold()
                }
                HStack {
                    Spacer()
                        .frame(width: 15)
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Categories.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized)
                        }
                    }
                    Spacer()
                        .frame(width: 15)
                }
                .pickerStyle(.segmented)
                .foregroundColor(Color("Green"))
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
