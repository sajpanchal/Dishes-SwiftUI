//
//  Dish.swift
//  Dishes
//
//  Created by saj panchal on 2021-10-31.
//

import Foundation

struct Dish: Identifiable, Codable {
    var name: String
    var id = UUID()
}
