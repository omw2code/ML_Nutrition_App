//
//  SetUpViewController.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/1/24.
//

import UIKit

class SetUpViewController: UIViewController {
    // MARK: - Public Var's
    @IBOutlet weak var continue_button: UIButton!
    @IBOutlet weak var maintain_button: UIButton!
    @IBOutlet weak var lose_button: UIButton!
    @IBOutlet weak var gain_button: UIButton!
    @IBOutlet weak var maintain_imageview: UIImageView!
    @IBOutlet weak var lose_imageview: UIImageView!
    @IBOutlet weak var gain_imageview: UIImageView!
    @IBOutlet weak var weight_tf: UITextField!
    @IBOutlet weak var height_tf: UITextField!
    
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
    }
    
    @IBAction func continueButton_clicked(_ sender: Any) {
        //perform segue
        let viewController = self.storyboard?.instantiateViewController(identifier: "accountSetUp_ID") as! FraternitySororitySelectViewController
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
