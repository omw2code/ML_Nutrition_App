//
//  User.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/2/24.
//

import Foundation
// MARK: - ENUM's
enum Gender {
    case male
    case female
}

enum Goal {
    case gainWeight
    case loseWeight
    case maintainWeight
}

// MARK: - User Class
class User {
    static let shared = User()
    
    private(set) var height: Int = 0
    private(set) var weight: Int = 0
    private(set) var weightHistory: [Int] = []
    private(set) var age: Int = 0
    private(set) var gender: Gender = .male
    private(set) var goal: Goal = .loseWeight
    private(set) var calories: Int = 0
    
    private(set) var totCarbs: Int = 0
    private(set) var totProtein: Int = 0
    private(set) var totFats: Int = 0
    
    private(set) var currCalCount: Int = 0
    private(set) var currCarbCount: Int = 0
    private(set) var currProteinCount: Int = 0
    private(set) var currFatsCount: Int = 0
    
    private init() {}

    func setHeight(_ height: Int) {
        self.height = height
    }

    func setWeight(_ weight: Int) {
        self.weight = weight
        self.weightHistory.append(weight)
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
    
    //MARK: - Personal Macro, calorie, daily intake Implementations (possibly move this to its own class)
    func calculateBMR() {
        var bmr: Double
        
        //weight from pounds to kilograms
        let weightInKilograms = Double(weight) * 0.453592
        
        //height from inches to centimeters
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
            return bmr + 600
        case .loseWeight:
            return bmr - 500
        case .maintainWeight:
            return bmr
        }
    }
    
    func calculateMacronutrientDistribution(calorieGoal: Double) {

        let carbsPercentage: Double = 50
        let proteinPercentage: Double = 25
        let fatsPercentage: Double = 25
        

        let carbsCalories = calorieGoal * (carbsPercentage / 100)
        let proteinCalories = calorieGoal * (proteinPercentage / 100)
        let fatsCalories = calorieGoal * (fatsPercentage / 100)
        

        self.totCarbs = Int(carbsCalories / 4)
        self.totProtein = Int(proteinCalories / 4)
        self.totFats = Int(fatsCalories / 9)
        
    }
    
    func addToDailyIntake(cal: Int, carb: Int, protein: Int, fats: Int) {
        self.currCalCount += cal
        self.currCarbCount += carb
        self.currProteinCount += protein
        self.currFatsCount += fats
    }
    
    func resetDailyIntake() {
        self.currCalCount = 0
        self.currCarbCount = 0
        self.currFatsCount = 0
        self.currProteinCount = 0
    }
}
