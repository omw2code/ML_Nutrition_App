//
//  DailyIntakeViewController.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/2/24.
//

import Charts
import UIKit

class DailyIntakeViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var fats_progressBar: UIProgressView!
    @IBOutlet weak var protein_progressBar: UIProgressView!
    @IBOutlet weak var carbs_progressBar: UIProgressView!
    @IBOutlet weak var cal_progressBar: UIProgressView!
    @IBOutlet weak var fatsCount_label: UILabel!
    @IBOutlet weak var proteinCount_label: UILabel!
    @IBOutlet weak var carbCount_label: UILabel!
    @IBOutlet weak var calorieCount_label: UILabel!
    let pieChart = PieChartView()
    
    override func viewDidLoad() {
        updateData()
        super.viewDidLoad()
        pieChart.delegate = self
        //fats_label.text = "Fats: \(fat)g"
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateData()
    }
    
    func updateData() {

        calorieCount_label.text = " \(User.shared.currCalCount)/\(User.shared.calories) Calories"
        carbCount_label.text = "\(User.shared.currCarbCount)/\(User.shared.totCarbs)g Carbs"
        proteinCount_label.text = "\(User.shared.currProteinCount)/\(User.shared.totProtein)g Protien"
        fatsCount_label.text = "\(User.shared.currFatsCount)/\(User.shared.totFats)g Fats"


        let calorieProgress = Float(User.shared.currCalCount) / Float(User.shared.calories)
        cal_progressBar.setProgress(calorieProgress, animated: true)
        

        let carbsProgress = Float(User.shared.currCarbCount) / Float(User.shared.totCarbs)
        carbs_progressBar.setProgress(carbsProgress, animated: true)
        

        let proteinProgress = Float(User.shared.currProteinCount) / Float(User.shared.totProtein)
        protein_progressBar.setProgress(proteinProgress, animated: true)
        

        let fatsProgress = Float(User.shared.currFatsCount) / Float(User.shared.totFats)
        fats_progressBar.setProgress(fatsProgress, animated: true)
        
        
        pieChart.frame = CGRect(x: 0, y: 0,
                                 width: self.view.frame.size.width,
                                 height: self.view.frame.width)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var entries = [PieChartDataEntry]()
        entries.append(PieChartDataEntry(value: Double(User.shared.currCarbCount), label: "Carbs"))
        entries.append(PieChartDataEntry(value: Double(User.shared.currProteinCount), label: "Protein"))
        entries.append(PieChartDataEntry(value: Double(User.shared.currFatsCount), label: "Fats"))

        let dataSet = PieChartDataSet(entries: entries, label: "Macro Distribution")
        dataSet.colors = ChartColorTemplates.material()
        
        let data = PieChartData(dataSet: dataSet)
        

        let centerText = NSMutableAttributedString(string: "Macro Distribution")
        centerText.setAttributes([.font: UIFont.boldSystemFont(ofSize: 16),
                                  .foregroundColor: UIColor.black], range: NSRange(location: 0, length: centerText.length))
        pieChart.centerAttributedText = centerText
        
        pieChart.data = data
        pieChart.animate(yAxisDuration: 1.5)
    }
    
}
