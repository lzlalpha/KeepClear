//
//  DetailViewController.swift
//  KeepClear
//
//  Created by lzlalpha on 15/12/21.
//  Copyright © 2015年 lzlalpha. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UITableViewController {

    var currTask : Task?
    
    @IBOutlet weak var memoText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var alertDateTimeCell: UITableViewCell!
    @IBOutlet weak var alertDateTimePickerCell: UITableViewCell!
    
    @IBOutlet weak var alertDateTimeText: UILabel!
    @IBOutlet weak var isAlertOnSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = currTask { // 更新时
            titleText.text = currTask!.title
            memoText.text = currTask!.memo
            if currTask?.isAlertOn == true {
                isAlertOnSwitch.on = true
                alertDateTimeCell.hidden = false
                alertDateTimePickerCell.hidden = true
                // 设置提醒日期
                let df = NSDateFormatter()
                df.dateFormat = Const.DATE_FORMAT
                alertDateTimeText.text = df.stringFromDate((currTask?.alertDateTime)!)
            } else {
                isAlertOnSwitch.on = false
                alertDateTimeCell.hidden = true
                alertDateTimePickerCell.hidden = true
            }
        } else { // 新建时
            titleText.text = ""
            memoText.text = ""
            alertDateTimeCell.hidden = true
            alertDateTimePickerCell.hidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 提醒开关显示/隐藏日期控件
    @IBAction func isAlertOnValueChange(sender: AnyObject) {
        let isAlertOn = sender as! UISwitch
        if(isAlertOn.on) {
            alertDateTimeCell.hidden = false
            alertDateTimePickerCell.hidden = true
            let df = NSDateFormatter()
            df.dateFormat = Const.DATE_FORMAT
            alertDateTimeText.text = df.stringFromDate(NSDate())
            
        } else {
            alertDateTimeCell.hidden = true
            alertDateTimePickerCell.hidden = true
            
        }
        tableView.reloadData()
    }
    
    // 日期选择控件值改变事件
    @IBAction func alertDateTimePickerValueChange(sender: AnyObject) {
        let datePicker = sender as! UIDatePicker
        let df = NSDateFormatter()
        df.dateFormat = Const.DATE_FORMAT
        alertDateTimeText.text = df.stringFromDate(datePicker.date)
    }
    // 根据单元格确定高度
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 // 提醒日期时间
            && indexPath.row == 1
            && alertDateTimeCell.hidden == true {
            return 0.0
        }
        if indexPath.section == 1 // 提醒日期时间选择控件
            && indexPath.row == 2
            && alertDateTimePickerCell.hidden == true {
                return 0.0
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    // 选择条目显示/隐藏日期选择控件
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1
            && indexPath.row == 1 {
                if alertDateTimePickerCell.hidden == true {
                    alertDateTimePickerCell.hidden = false
                    alertDateTimeText.textColor = alertDateTimeText.tintColor
                } else {
                    alertDateTimePickerCell.hidden = true
                    alertDateTimeText.textColor = UIColor.blackColor()
                }
                tableView.reloadData()
                
        }
    }
    
    // 页面跳转时验证数据并保存任务
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if titleText.text == "" {
            return false
        }
        let realm = try! Realm()
        
        if currTask == nil { // 新增
            currTask = Task()
            currTask!.id = realm.objects(Task).max("id")! + 1
        }
        realm.beginWrite()
        currTask!.title = titleText.text!
        currTask!.memo = memoText.text!
        
        currTask!.isAlertOn = isAlertOnSwitch.on
        let df = NSDateFormatter()
        df.dateFormat = Const.DATE_FORMAT
        currTask?.alertDateTime = df.dateFromString(alertDateTimeText.text!)
        realm.add(currTask!, update:true)
        try! realm.commitWrite()
        return true
    }

}
