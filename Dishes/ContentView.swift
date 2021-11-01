//
//  ContentView.swift
//  Dishes
//
//  Created by saj panchal on 2021-10-31.
//

import SwiftUI

struct ContentView: View {
    @State var dishes: [Dish] = []
    @State var dishName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                        TextField("Enter Dish Name", text: $dishName)
                    Button("Add") {
                        let dish = Dish(name: dishName)
                        dishes.append(dish)
                        saveDishes()
                        dishName = ""
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .disabled(dishName.count < 2)
                    .opacity(dishName.count < 2 ? 0.6 : 1)
                  Spacer()
                   
                }
                           
                Text("List of Dishes")
                    .fontWeight(.bold)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                List {
                    ForEach(dishes) {
                        Text($0.name)
                    }
                    .onDelete(perform: { dish in
                        print(dish)
                        dishes.remove(atOffsets: dish)
                        saveDishes()
                        
                    })
                }
            }
            .onAppear(perform: loadDishes)
            .navigationTitle("Dishes App")
        }
        
    }
    func loadDishes() {
        if let data = UserDefaults.standard.data(forKey: "dishes") {
            let decoder = JSONDecoder()
            do {
                dishes = try decoder.decode([Dish].self, from: data)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    func saveDishes() {
       
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(dishes)
            UserDefaults.standard.set(data, forKey: "dishes")
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
