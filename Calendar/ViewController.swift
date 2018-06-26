//
//  ViewController.swift
//  Calendar
//
//  Created by Rachel Fine on 6/23/18.
//  Copyright © 2018 Rachel Fine. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var sunday: UILabel!
    @IBOutlet weak var monday: UILabel!
    @IBOutlet weak var tuesday: UILabel!
    @IBOutlet weak var wednesday: UILabel!
    @IBOutlet weak var thursday: UILabel!
    @IBOutlet weak var friday: UILabel!
    @IBOutlet weak var saturday: UILabel!
    
    var nums : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20, 21, 22, 23, 24, 25, 26, 27, 28]
    //initialized empty array expecting type of data to be Float
//    var days: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    //MAYBE TAKE OUT COLLECTION VIEW FOR DAYS OF WEEK
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //ADD FETCH DATA FUNCTION HERE?
        self.monthLabel.text = "February"
        self.sunday.text = "Sun"
        self.monday.text = "Mon"
        self.tuesday.text = "Tues"
        self.wednesday.text = "Wed"
        self.thursday.text = "Thu"
        self.friday.text = "Fri"
        self.saturday.text = "Sat"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //the two functions below are required for the Data Source thing
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("nums.count is \(nums.count)")
        //return the number of items in the array...i think
        return self.nums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //create a cell and deqeue it from collection view so it's not created every time
        let dayCell:DayCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath as IndexPath) as! DayCollectionViewCell
        //i think this means that dayCell is of type (class) DayCollectionViewCell
        //I'm not sure what the indexPath or as! does
        let date = String(self.nums[indexPath.item])
        dayCell.dateLabel.text = date
        dayCell.backgroundColor = UIColor.cyan
        return dayCell
    }
    
    //this is for the delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("user tapped on \(indexPath.row)")
        let eventFormViewPage:EventFormViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventFormViewController") as! EventFormViewController
        let date = self.nums[indexPath.item]
        eventFormViewPage.selectedDay = String(date)
        self.navigationController?.pushViewController(eventFormViewPage, animated: true)
        
    }
    //this is an optional function for the Delegate class - need it so users can interact with items
    
}

