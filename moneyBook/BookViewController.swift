//
//  ViewController.swift
//  moneyBook
//
//  Created by p14822 on 2017/12/27.
//  Copyright © 2017年 p14822. All rights reserved.
//

import UIKit
import RealmSwift

class Record: Object {
    @objc dynamic var Item: String? = nil
    @objc dynamic var Amount:Float = 0.0
    @objc dynamic var ItemType: String? = nil
    @objc dynamic var date = ""
}

class BookViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var Item: UITextField!
    @IBOutlet weak var Amount: UITextField!
    @IBOutlet weak var ItemType: UITextField!
    @IBOutlet weak var AmountPicker: UIPickerView!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var realm:Realm!
    var pickerData = [Int](1...100)
    var rotationAngle:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotationAngle = -90 * (.pi / 180)
        let frame = AmountPicker.frame
        AmountPicker.transform = CGAffineTransform(rotationAngle:rotationAngle)
        AmountPicker.frame = frame
        AmountPicker.dataSource = self
        AmountPicker.delegate = self
        localMigrations()
        realm = try! Realm()
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"3132.jpg")!)
//        self.view.backgroundColor?.setFill()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ItemTypeSelect.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return String(describing: pickerData[row])
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat{
        return CGFloat(ImageWidth)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return CGFloat(ImageHeight)
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        let view = UIView()

        
        view.addSubview((ItemTypeSelect(rawValue: row)?.setPickerView())!)
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180))
        
        return view
    }
    fileprivate func localMigrations() {
        // Do any additional setup after loading the view, typically from a nib.
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 3) {
                    migration.enumerateObjects(ofType: Record.className()) { oldObject, newObject in

                        newObject!["Item"] = oldObject!["Item"] as! String?
                    }
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        Item.resignFirstResponder()
        Amount.resignFirstResponder()
        ItemType.resignFirstResponder()
    }

    @IBAction func addRecord(_ sender: Any) {

        let newRecord = Record()
        if Amount.text != ""{
            newRecord.Item = Item.text
            newRecord.Amount = Float(Amount.text!)!
            newRecord.ItemType = ItemType.text
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy/MM/dd"
            newRecord.date = dateformatter.string(from: datePicker.date)
            try! realm.write {
                realm.add(newRecord)
                let alert = UIAlertController(title: "新增了一筆支出", message: "\(Item.text!)  \(Amount.text!)元", preferredStyle: .alert)
                let okAction = UIAlertAction(
                    title: "確認",
                    style: .default)
                alert.addAction(okAction)
                self.present(
                    alert,
                    animated: true,
                    completion: nil)
            }
            print(realm.objects(Record.self))
        }
        else{
            if Amount.text == ""{
                let alert = UIAlertController(title: "警告", message: "金額不能為空", preferredStyle: .alert)
                let okAction = UIAlertAction(
                    title: "確認",
                    style: .default)
                alert.addAction(okAction)
//                let firstView = alert.view.subviews.first
//                let backView = firstView?.subviews.first
//                let subview = (backView?.subviews.last)
//                subview?.backgroundColor = UIColor.lightGray
//                subview?.layer.cornerRadius = 10.0
//                subview?.alpha = 1
                
                self.present(
                    alert,
                    animated: true,
                    completion: nil)
            }
        }
    }
    


}

