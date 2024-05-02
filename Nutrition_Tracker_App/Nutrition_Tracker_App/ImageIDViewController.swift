//
//  ImageIDViewController.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/1/24.
//

import UIKit
import CoreML
class ImageIDViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var feature_label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
    /*
    // MARK: - Model Classification

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
    
    
    
    
    
//    func sceneLabel (forImage image:UIImage) -> String? {
//        do {
//            let config = MLModelConfiguration()
//            let model = try Nutrition_Food_Classifier(configuration: config)
//            if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image.cgImage!) {
//                guard let scene = try? model.prediction(image: pixelBuffer) else {fatalError("Unexpected runtime error")}
//                return scene.target
//                
//            }
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
    
    
        func sceneLabel(forImage image: UIImage) -> String? {
            guard let model = try? Nutrition_Food_Classifier(configuration: MLModelConfiguration()) else {
                print("Failed to create ML model.")
                return nil
            }

            guard let pixelBuffer = image.pixelBuffer(width: 224, height: 224) else {
                print("Failed to convert UIImage to CVPixelBuffer.")
                return nil
            }

            do {
                let input = Nutrition_Food_ClassifierInput(image: pixelBuffer)
                let output = try model.prediction(input: input)
                return output.target
            } catch {
                print("Error during prediction: \(error.localizedDescription)")
                return nil
            }
        }
    
    
    
    
    //Image
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
                        feature_label.text = sceneLabelString
                    }
        //analyze(image: image)
    }
}
