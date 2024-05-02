//
//  FoodDatabase.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/2/24.
//

import Foundation

class Food {
    let name: String
    let macros: [String: Double] // Assuming macros are stored as key-value pairs
    let calories: Double

    init(name: String, macros: [String: Double], calories: Double) {
        self.name = name
        self.macros = macros
        self.calories = calories
    }
}

class FoodDatabase {
    static var foods: [Food] = [
        Food(name: "Baked Potato", macros: ["carbs": 20.0, "protein": 3.0, "fat": 0.5], calories: 161.0),
        Food(name: "Crispy Chicken", macros: ["carbs": 0.0, "protein": 24.0, "fat": 10.0], calories: 220.0),
        Food(name: "Donut", macros: ["carbs": 25.0, "protein": 2.0, "fat": 11.0], calories: 195.0),
        Food(name: "Fries", macros: ["carbs": 29.0, "protein": 3.0, "fat": 12.0], calories: 312.0),
        Food(name: "Hot Dog", macros: ["carbs": 20.0, "protein": 7.0, "fat": 13.0], calories: 220.0),
        Food(name: "Sandwich", macros: ["carbs": 40.0, "protein": 15.0, "fat": 10.0], calories: 350.0),
        Food(name: "Taco", macros: ["carbs": 20.0, "protein": 10.0, "fat": 5.0], calories: 200.0),
        Food(name: "Taquito", macros: ["carbs": 15.0, "protein": 6.0, "fat": 8.0], calories: 180.0),
        Food(name: "Apple Pie", macros: ["carbs": 30.0, "protein": 2.0, "fat": 10.0], calories: 277.0),
        Food(name: "Burger", macros: ["carbs": 30.0, "protein": 25.0, "fat": 20.0], calories: 400.0),
        Food(name: "Butter Naan", macros: ["carbs": 50.0, "protein": 6.0, "fat": 10.0], calories: 350.0),
        Food(name: "Chai", macros: ["carbs": 5.0, "protein": 1.0, "fat": 3.0], calories: 50.0),
        Food(name: "Chapati", macros: ["carbs": 15.0, "protein": 3.0, "fat": 2.0], calories: 100.0),
        Food(name: "Cheesecake", macros: ["carbs": 30.0, "protein": 5.0, "fat": 20.0], calories: 300.0),
        Food(name: "Chicken Curry", macros: ["carbs": 15.0, "protein": 20.0, "fat": 12.0], calories: 250.0),
        Food(name: "Chole Bhature", macros: ["carbs": 40.0, "protein": 10.0, "fat": 15.0], calories: 400.0),
        Food(name: "Dal Makhani", macros: ["carbs": 20.0, "protein": 10.0, "fat": 8.0], calories: 250.0),
        Food(name: "Dhokla", macros: ["carbs": 25.0, "protein": 5.0, "fat": 3.0], calories: 180.0),
        Food(name: "Fried Rice", macros: ["carbs": 30.0, "protein": 6.0, "fat": 8.0], calories: 250.0),
        Food(name: "Ice Cream", macros: ["carbs": 20.0, "protein": 4.0, "fat": 10.0], calories: 250.0),
        Food(name: "Idli", macros: ["carbs": 10.0, "protein": 2.0, "fat": 1.0], calories: 60.0),
        Food(name: "Jalebi", macros: ["carbs": 40.0, "protein": 1.0, "fat": 15.0], calories: 250.0),
        Food(name: "Kathi Rolls", macros: ["carbs": 35.0, "protein": 10.0, "fat": 12.0], calories: 300.0),
        Food(name: "Kadai Paneer", macros: ["carbs": 15.0, "protein": 15.0, "fat": 20.0], calories: 300.0),
        Food(name: "Kulfi", macros: ["carbs": 20.0, "protein": 3.0, "fat": 8.0], calories: 200.0),
        Food(name: "Masala Dosa", macros: ["carbs": 30.0, "protein": 5.0, "fat": 10.0], calories: 250.0),
        Food(name: "Momos", macros: ["carbs": 20.0, "protein": 8.0, "fat": 5.0], calories: 150.0),
        Food(name: "Omelette", macros: ["carbs": 2.0, "protein": 15.0, "fat": 12.0], calories: 150.0)
    ]
    
    static func findFood(byName name: String) -> Food? {
        // Search for the food by its name
        for food in foods {
            if food.name.lowercased() == name.lowercased() {
                return food
            }
        }
        return nil // Return nil if the food is not found
    }
}
