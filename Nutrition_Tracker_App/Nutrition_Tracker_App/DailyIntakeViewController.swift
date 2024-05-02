//
//  DailyIntakeViewController.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/2/24.
//

import Charts
import UIKit

class DailyIntakeViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var fatsCount_label: UILabel!
    @IBOutlet weak var proteinCount_label: UILabel!
    @IBOutlet weak var carbCount_label: UILabel!
    @IBOutlet weak var calorieCount_label: UILabel!
    let pieChart = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
        calorieCount_label.text = String(User.shared.calories)
        carbCount_label.text = String(User.shared.remainingCarbs)
        proteinCount_label.text = String(User.shared.remainingProtein)
        fatsCount_label.text = String(User.shared.remainingFats)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        pieChart.frame = CGRect(x: 0, y: 0,
                                 width: self.view.frame.size.width,
                                 height: self.view.frame.width)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var entries = [ChartDataEntry]()
        
        for x in 0..<10 {
            entries.append(ChartDataEntry(x: Double(x),
                                          y: Double(x)))
        }
        
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        
        let data = PieChartData(dataSet: set)
        
        pieChart.data = data
    }

}
