//
//  User.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/2/24.
//

import Foundation

enum Gender {
    case male
    case female
}

enum Goal {
    case gainWeight
    case loseWeight
    case maintainWeight
}

class User {
    static let shared = User()
    
    private(set) var height: Int = 0
    private(set) var weight: Int = 0
    private(set) var age: Int = 0
    private(set) var gender: Gender = .male
    private(set) var goal: Goal = .loseWeight
    private(set) var calories: Int = 0
    
    private(set) var remainingCarbs: Int = 0
    private(set) var remainingProtein: Int = 0
    private(set) var remainingFats: Int = 0

    private init() {}

    func setHeight(_ height: Int) {
        self.height = height
    }

    func setWeight(_ weight: Int) {
        self.weight = weight
    }

    func setAge(_ age: Int) {
        self.age = age
    }

    func setGender(_ gender: Gender) {
        self.gender = gender
    }

    func setGoal(_ goal: Goal) {
        self.goal = goal
    }

    func setCalories(_ calories: Int) {
        self.calories = calories
    }

    func calculateBMR() {
        var bmr: Double
        
        // Convert weight from pounds to kilograms
        let weightInKilograms = Double(weight) * 0.453592
        
        // Convert height from inches to centimeters
        let heightInCentimeters = Double(height) * 2.54
        
        switch gender {
        case .male:
            bmr = 10 * weightInKilograms + 6.25 * heightInCentimeters - 5 * Double(age) + 5
        case .female:
            bmr = 10 * weightInKilograms + 6.25 * heightInCentimeters - 5 * Double(age) - 161
        }
        
        self.calories = Int(adjustCaloriesForGoal(bmr: bmr))
    }

    func adjustCaloriesForGoal(bmr: Double) -> Double {
        switch goal {
        case .gainWeight:
            return bmr + 500
        case .loseWeight:
            return bmr - 500
        case .maintainWeight:
            return bmr
        }
    }
    
    func calculateMacronutrientDistribution(calorieGoal: Double) {
        // Determine macronutrient distribution percentages (you can adjust these percentages based on guidelines)
        let carbsPercentage: Double = 50
        let proteinPercentage: Double = 25
        let fatsPercentage: Double = 25
        
        // Calculate calories from each macronutrient
        let carbsCalories = calorieGoal * (carbsPercentage / 100)
        let proteinCalories = calorieGoal * (proteinPercentage / 100)
        let fatsCalories = calorieGoal * (fatsPercentage / 100)
        
        // Convert calories to grams (4 calories per gram for carbs and protein, 9 calories per gram for fats)
        self.remainingCarbs = Int(carbsCalories / 4)
        self.remainingProtein = Int(proteinCalories / 4)
        self.remainingFats = Int(fatsCalories / 9)
        
        
    }
}
