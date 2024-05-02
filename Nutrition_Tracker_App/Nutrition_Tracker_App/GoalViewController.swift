//
//  ChartViewController.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/2/24.
//
import Charts
import UIKit

class GoalViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var calorieGoal_label: UILabel!
    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        lineChart.frame = CGRect(x: 0, y: 0,
                                 width: self.view.frame.size.width,
                                 height: self.view.frame.width)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        
        for x in 0..<10 {
            entries.append(ChartDataEntry(x: Double(x), 
                                          y: Double(x)))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        
        let data = LineChartData(dataSet: set)
        
        lineChart.data = data
        calorieGoal_label.text = String(User.shared.calories)
    }

}
