//
//  ChartViewController.swift
//  Nutrition_Tracker_App
//
//  Created by Brennan Rivera on 5/2/24.
//
import Charts
import UIKit

class GoalViewController: UIViewController, ChartViewDelegate {
    
    // MARK: - UI Component variables
    @IBOutlet weak var lastThirty_button: UIButton!
    @IBOutlet weak var lastSeven_button: UIButton!
    @IBOutlet weak var allTime_button: UIButton!
    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        lineChart.animate(xAxisDuration: 0.7, yAxisDuration: 0.7)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lineChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    // MARK: - Graph Implementation
    override func viewDidLayoutSubviews() {
        lineChart.clear()
        lineChart.frame = CGRect(x: 0, y: 0,
                                 width: self.view.frame.size.width,
                                 height: self.view.frame.width)
        lineChart.center = view.center
        view.addSubview(lineChart)

        for _ in 0..<10 {
            //generate a weight change between -2 and 2 pounds
            let weightChange = Int.random(in: -2...2)
            

            let previousWeight = User.shared.weightHistory.last ?? 150
            let newWeight = max(0, previousWeight + weightChange) 
            User.shared.setWeight(newWeight)
        }
        
        let weightHistory = User.shared.weightHistory
        
        var entries = [ChartDataEntry]()
        

        for (index, weight) in weightHistory.enumerated() {
            entries.append(ChartDataEntry(x: Double(index), y: Double(weight)))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.pastel()
        
        let data = LineChartData(dataSet: set)
        
        lineChart.data = data
        let xAxis = lineChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = IndexAxisValueFormatter(values: weightHistory.map { String($0) })

    }

}
