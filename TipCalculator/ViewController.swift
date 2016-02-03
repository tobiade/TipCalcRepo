//
//  ViewController.swift
//  TipCalculator
//
//  Created by Main Account on 12/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class UIViewController {
}
 
class ViewController: UIKit.UIViewController, UITableViewDataSource {

  @IBOutlet var totalTextField : UITextField!
  @IBOutlet var taxPctSlider : UISlider!
  @IBOutlet var taxPctLabel : UILabel!
  @IBOutlet var resultsTextView : UITextView!
  let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
    var possibleTips = Dictionary<Int, (tipAmt:Double, total:Double)>()
    var sortedKeys:[Int] = []
  
    //table view
    @IBOutlet weak var tableView: UITableView!
  func refreshUI() {
    // 1
    totalTextField.text = String(format: "%0.2f", tipCalc.total)
    // 2
    taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
    // 3
    taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
    // 4
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    refreshUI()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func calculateTapped(sender : AnyObject) {
    // 1
    tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)
    // 2
    possibleTips = tipCalc.returnPossibleTips()
    sortedKeys = Array(possibleTips.keys).sort()
    tableView.reloadData()
    var results = ""
    // 3
    for (tipPct, tipValue) in possibleTips {
      // 4
      results += "\(tipPct)%: \(tipValue)\n"
    }
    // 5
    resultsTextView.text = results
  }

  @IBAction func taxPercentageChanged(sender : AnyObject) {
    tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
    refreshUI()
  }
  
  @IBAction func viewTapped(sender : AnyObject) {
    totalTextField.resignFirstResponder()
  }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        let tipPct = sortedKeys[indexPath.row]
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.total
        cell.textLabel?.text="\(tipPct)%"
        cell.detailTextLabel?.text=String(format:"Tip: $%0.2f, Total: $%0.2f", tipAmt, total)
        return cell
    }
    
    

}

