//
//  ChartCell.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation
import UIKit
import Charts

class ChartCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ChartCell.self)
    
    private lazy var pieChart: PieChartView = {
        let segmented = PieChartView()
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    private lazy var lbltitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = ColorCatalog.text
        lbl.font = UIFont.systemFont(ofSize: 22.0)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeChart(title: String, dataPoints: [String], values: [Double]) {

        lbltitle.text = title
        
         var dataEntries: [ChartDataEntry] = []
         for i in 0..<dataPoints.count {
           let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
           dataEntries.append(dataEntry)
         }
         // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: nil)
         pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
       
         // 3. Set ChartData
         let pieChartData = PieChartData(dataSet: pieChartDataSet)
         let format = NumberFormatter()
         format.numberStyle = .none
         let formatter = DefaultValueFormatter(formatter: format)
         pieChartData.setValueFormatter(formatter)
        
         // 4. Assign it to the chart’s data
        pieChart.data = pieChartData
        pieChart.chartDescription?.text = ""
        setupview()
    }
    
    
}

private extension ChartCell
{
    func setupview() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(lbltitle)
        addSubview(pieChart)
        
        setConstraints()
    }
    
    func setConstraints() {
        let constraintsArray = [
            
            lbltitle.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            lbltitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lbltitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            pieChart.topAnchor.constraint(equalTo: lbltitle.bottomAnchor, constant: 16),
            pieChart.centerXAnchor.constraint(equalTo: centerXAnchor),
            pieChart.widthAnchor.constraint(equalToConstant: 250),
            pieChart.heightAnchor.constraint(equalToConstant: 300),
            pieChart.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ]
        
        NSLayoutConstraint.activate(constraintsArray)
        
    }
    
    func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
    
        return colors
    }
}
