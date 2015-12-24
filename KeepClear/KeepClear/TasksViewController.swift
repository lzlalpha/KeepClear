//
//  ViewController.swift
//  KeepClear
//
//  Created by lzlalpha on 15/12/21.
//  Copyright © 2015年 lzlalpha. All rights reserved.
//

import UIKit
import RealmSwift

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    var tasks : Results<Task>?
    var selectedTask : Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // 取得数据
        let realm = try! Realm()
        tasks = realm.objects(Task)
        
    }

    // 编辑按钮
    @IBAction func edit(sender: AnyObject) {
        if editButton.tag == 100 { // 开始编辑
            editButton.tag = 200
            editButton.title = "Done"
            tableView.setEditing(true, animated: true)
            navigationItem.rightBarButtonItem?.enabled = false
        } else { // 完成编辑
            editButton.tag = 100
            editButton.title = "Edit"
            tableView.setEditing(false, animated: true)
            navigationItem.rightBarButtonItem?.enabled = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 转移界面前，设置数据
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDetailSegue") {
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.currTask = selectedTask
        }
        
    }
    
    // 点击添加任务转移到详细界面
    @IBAction func addTask(sender: AnyObject) {
        selectedTask = nil
        performSegueWithIdentifier("showDetailSegue", sender: nil)
    }
    
    // 反转场景事件
    @IBAction func unwind(unwindSegue : UIStoryboardSegue) {
        let realm = try! Realm()
        tasks = realm.objects(Task)
        tableView.reloadData()
    }

}

extension TasksViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // 设置表格行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks!.count
    }
    // 设置单元格聂荣
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let titleText = cell.viewWithTag(100) as! UILabel
        let alertDateTimeText = cell.viewWithTag(200) as! UILabel
        
        titleText.text = tasks![indexPath.row].title
        // 设置提醒日期
        if tasks![indexPath.row].isAlertOn == true {
            let df = NSDateFormatter()
            df.dateFormat = Const.DATE_FORMAT_YEAR
            // 如果是今年，则不显示年份
            if df.stringFromDate(NSDate()) != df.stringFromDate(tasks![indexPath.row].alertDateTime!) {
                df.dateFormat = Const.DATE_FORMAT
            } else {
                df.dateFormat = Const.DATE_FORMAT_NOYEAR
            }
            alertDateTimeText.text = df.stringFromDate(tasks![indexPath.row].alertDateTime!)
        } else {
            alertDateTimeText.text = ""
        }
        return cell
    }
    // 设置条目高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    // 选择某一个条目转移到详细界面
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTask = tasks![indexPath.row]
        performSegueWithIdentifier("showDetailSegue", sender: indexPath)
    }
    
    // 删除某一条目
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let realm = try! Realm()
        realm.beginWrite()
        realm.delete(tasks![indexPath.row])
        try! realm.commitWrite()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        
    }
    
    // 设置可以排序
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
    }
    
}

