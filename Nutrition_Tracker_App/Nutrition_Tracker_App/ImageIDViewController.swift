//
//  ImageIDViewController.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/1/24.
//

import UIKit
import CoreML
class ImageIDViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - UI Components
    @IBOutlet weak var itemCount_textField: UITextField!
    @IBOutlet weak var intake_button: UIButton!
    @IBOutlet weak var fats_label: UILabel!
    @IBOutlet weak var protein_label: UILabel!
    @IBOutlet weak var carbs_label: UILabel!
    @IBOutlet weak var calories_label: UILabel!
    @IBOutlet weak var feature_label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var carbs: Int = 0
    var protein: Int = 0
    var fats: Int = 0
    var calories: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intake_button.isEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        
        tap.numberOfTapsRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func didTapImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }


//    private func analyze(image: UIImage?) {
//        
//        guard let buffer = image?.getCVPixelBuffer() else {
//            return
//        }
//        
//        do {
//            let config = MLModelConfiguration()
//            let model = try Nutrition_Food_Classifier(configuration: config)
//            let input = Nutrition_Food_ClassifierInput(image: buffer)
//            
//            let output = try model.prediction(image: buffer)
//            let text = output.target
//            print(output.targetProbability)
//            feature_label.text = text
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }
//    
    
    
    
    
    
    
    func sceneLabel (forImage image:UIImage) -> String? {
        do {
            let config = MLModelConfiguration()
            let model = try Nutrition_Food_Classifier(configuration: config)
            if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image.cgImage!) {
                guard let scene = try? model.prediction(image: pixelBuffer) else {fatalError("Unexpected runtime error")}
                return scene.target
                
            }
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    
    
    
    
    //MARK: - Image Picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageView.image = image
        if let sceneLabelString = sceneLabel(forImage: image) {
            if let foundFood = FoodDatabase.findFood(byName: sceneLabelString) {
                feature_label.text = foundFood.name
                
                carbs = Int(foundFood.macros["carbs"] ?? 0.0)
                protein = Int(foundFood.macros["protein"] ?? 0.0)
                fats = Int(foundFood.macros["fat"] ?? 0.0)
                calories = Int(foundFood.calories)
                
                carbs_label.text = "Carbs: \(carbs)g"
                protein_label.text = "Protein: \(protein)g"
                fats_label.text = "Fats: \(fats)g"
                calories_label.text = String(foundFood.calories)
                intake_button.isEnabled = true
                
                
            } else {
                print("Food not found in database")
            }
                    }
        //analyze(image: image)
    }
    //MARK: - Button Implementations
    @IBAction func intakeButton_clicked(_ sender: Any) {
            User.shared.addToDailyIntake(cal: calories, carb: carbs, protein: protein, fats: fats)
    }
    @IBAction func stepper_clicked(_ sender: UIStepper) {
        let temp = Int(itemCount_textField.text ?? "")
        
        itemCount_textField.text = String(Int(sender.value) + (temp ?? 1))
    }
}
