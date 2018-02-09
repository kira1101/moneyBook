//
//  CalendarViewController.swift
//  moneyBook
//
//  Created by p14822 on 2017/12/29.
//  Copyright © 2017年 p14822. All rights reserved.
//

import Foundation
import UIKit
import Charts
import RealmSwift

class CalendarViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate{


    @IBOutlet weak var BarView: BarChartView!
    @IBOutlet weak var calendar: FSCalendar!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    var selectedDates:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentdate = Date()
        selectedDates.append(dateFormatter.string(from: currentdate))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateChartWithData()
        BarView.animate(xAxisDuration: 0.2)
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let record = getRecordFromDatabase()
        for i in 0..<record.count {
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double( record[i].Amount) )
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        chartDataSet.colors = [
            UIColor(red: 256/256,green:180/256,blue:180/256,alpha:1),
            UIColor(red: 220/256,green:220/256,blue:256/256,alpha:1),
            UIColor(red: 195/256,green:224/256,blue:256/256,alpha:1),
            UIColor(red: 220/256,green:256/256,blue:256/256,alpha:1),
            UIColor(red: 225/256,green:256/256,blue:225/256,alpha:1),
            UIColor(red: 256/256,green:220/256,blue:185/256,alpha:1),
            UIColor(red: 216/256,green:216/256,blue:235/256,alpha:1),
            UIColor(red: 233/256,green:256/256,blue:195/256,alpha:1),
            UIColor(red: 241/256,green:241/256,blue:241/256,alpha:1),
        ]
        let chartData = BarChartData(dataSet: chartDataSet)
        BarView.data = chartData
        BarView.chartDescription?.text = selectedDates[0]
        
    }
    
    func getRecordFromDatabase() -> Results<Record> {
        do {
            let realm = try Realm()
            return realm.objects(Record.self).filter("date = '\(selectedDates[0])'")
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        updateChartWithData()
    }

    
}
