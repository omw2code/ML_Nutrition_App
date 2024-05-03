//
//  SetUpViewController.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/1/24.
//

import UIKit

class SetUpViewController: UIViewController {
    // MARK: - Public Var's
    @IBOutlet weak var age_tf: UITextField!
    @IBOutlet weak var female_button: UIButton!
    @IBOutlet weak var male_button: UIButton!
    @IBOutlet weak var continue_button: UIButton!
    @IBOutlet weak var maintain_button: UIButton!
    @IBOutlet weak var lose_button: UIButton!
    @IBOutlet weak var gain_button: UIButton!
    @IBOutlet weak var maintain_imageview: UIImageView!
    @IBOutlet weak var lose_imageview: UIImageView!
    @IBOutlet weak var gain_imageview: UIImageView!
    @IBOutlet weak var weight_tf: UITextField!
    @IBOutlet weak var height_tf: UITextField!
    
    //temp user for testing
//    User.currentUser = User(height: 0, weight: 0, age: 0, gender: .male, goal: .loseWeight, calories: 0)
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configButtonStyle()
        setUnfilledImage()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Image Behavior
    
    func setUnfilledImage(){
        guard let image = UIImage(systemName: "chart.line.flattrend.xyaxis.circle") else {
            maintain_imageview.image = nil
            return
        }
        maintain_imageview.image = image
        
        guard let image = UIImage(systemName: "chart.line.downtrend.xyaxis.circle") else {
            lose_imageview.image = nil
            return
        }
        lose_imageview.image = image
        
        guard let image = UIImage(systemName: "chart.line.uptrend.xyaxis.circle") else {
            gain_imageview.image = nil
            return
        }
        gain_imageview.image = image
    }
    
    // MARK: - Button Behavior
    
    func configButtonStyle() {
        continue_button.isEnabled   = false
        maintain_button.tintColor   = UIColor.opaqueSeparator
        lose_button.tintColor       = UIColor.opaqueSeparator
        gain_button.tintColor       = UIColor.opaqueSeparator
    }

    @IBAction func gainButton_clicked(_ sender: Any) {
        configButtonStyle()
        setUnfilledImage()
        gain_button.tintColor = UIColor.link
        continue_button.isEnabled = true
        
        guard let image = UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill") else {
            gain_imageview.image = nil
            return
        }
        gain_imageview.image = image
        User.shared.setGoal(.gainWeight)
    }
    
    @IBAction func loseButton_clicked(_ sender: Any) {
        configButtonStyle()
        setUnfilledImage()
        lose_button.tintColor = UIColor.link
        continue_button.isEnabled = true
        
        guard let image = UIImage(systemName: "chart.line.downtrend.xyaxis.circle.fill") else {
            lose_imageview.image = nil
            return
        }
        lose_imageview.image = image
        User.shared.setGoal(.loseWeight)
        
    }
    @IBAction func maintainButton_clicked(_ sender: Any) {
        configButtonStyle()
        setUnfilledImage()
        maintain_button.tintColor = UIColor.link
        continue_button.isEnabled = true
        
        guard let image = UIImage(systemName: "chart.line.flattrend.xyaxis.circle.fill") else {
            maintain_imageview.image = nil
            return
        }
        maintain_imageview.image = image
        User.shared.setGoal(.maintainWeight)
    }
    
    
    @IBAction func maleButton_clicked(_ sender: Any) {
        male_button.tintColor = UIColor.link
        female_button.tintColor = UIColor.opaqueSeparator
        User.shared.setGender(.male)
    }
    
    @IBAction func femaleButton_clicked(_ sender: Any) {
        female_button.tintColor = UIColor.link
        male_button.tintColor = UIColor.opaqueSeparator
        User.shared.setGender(.female)
    }
    
    
    
    
    
    @IBAction func continueButton_clicked(_ sender: Any) {
        if let heightText = height_tf.text,
           let heightInInches = convertHeightToInches(from: heightText),
           let weightText = weight_tf.text,
           let weight = Double(weightText),
           let ageText = age_tf.text,
           let age = Int(ageText) {
            User.shared.setHeight(Int(heightInInches))
            User.shared.setWeight(Int(weight))
            User.shared.setAge(age)
            User.shared.calculateBMR()
            User.shared.calculateMacronutrientDistribution(calorieGoal: Double(User.shared.calories))
        } else {
            // Display an alert or error message to inform the user about the invalid input
            print("Please enter valid height, weight, and age.")
        }
        //perform segue
        let viewController = self.storyboard?.instantiateViewController(identifier: "testID") as! UITabBarController
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    //MARK: - Utils
    func convertHeightToInches(from heightString: String) -> Double? {

        let components = heightString.components(separatedBy: "'")
        

        guard components.count == 2 else { return nil }
        

        guard let feet = Double(components[0]), let inches = Double(components[1]) else { return nil }
        

        let heightInInches = (feet * 12) + inches
        
        return heightInInches
    }

}
