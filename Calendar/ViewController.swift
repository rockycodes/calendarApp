//
//  ViewController.swift
//  Calendar
//
//  Created by Rachel Fine on 6/23/18.
//  Copyright © 2018 Rachel Fine. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    var db:Firestore!
    
    var nums : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20, 21, 22, 23, 24, 25, 26, 27, 28]
    //initialized empty array expecting type of data to be Float
//    var days: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    //MAYBE TAKE OUT COLLECTION VIEW FOR DAYS OF WEEK
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //ADD FETCH DATA FUNCTION HERE?
        db = Firestore.firestore()
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
        
        //create eventsArr in dayCell and then set dayCell.eventsArr = data fetch with document look up by date
        dayCell.eventDescriptions.isEditable = false;
        let date = String(self.nums[indexPath.item])
        db.collection(date).getDocuments(){
            querySnapshot, error in
            if let error = error {
                print("in error statement")
                
                print("\(error.localizedDescription)")
            }else{
                let eventArr = querySnapshot!.documents.map{document in document.data()}
                let descriptionArr = eventArr.map{event in event["description"]!} as! [String]
                let truncatedDescArr:[String] = descriptionArr.map{description in
                    if description.count > 3 {
                        let idx = description.index(description.startIndex, offsetBy: 2)
                        let truncatedDesc = "\(String(description[...idx]))..."
                        return truncatedDesc
                    }
                    return description
                }
                
                //event["description"].slice(0,4) += "..."
                
                //must explicitly insert descriptions as strings for joined member to work
                
                //if array is more than three items, add a +(num) more at the bottom
                var returnArr = [String]()
                
                if truncatedDescArr.count > 3 {
                    let idx = truncatedDescArr.index(truncatedDescArr.startIndex, offsetBy: 2)
                    returnArr = Array(truncatedDescArr[...idx])
                    let num = truncatedDescArr.count - 3
                    returnArr.append("+ \(num) more")
                }
                else {
                    returnArr = truncatedDescArr
                }
                let descriptionStr = returnArr.joined(separator: "\n")
                
                //if eventArr.count > 3 descriptionStr += "\n+\(eventArr.count-3) more"
                dayCell.eventDescriptions.text = descriptionStr
            }
        }
        dayCell.dateLabel.text = date
        dayCell.backgroundColor = UIColor.cyan
        return dayCell
    }
    
    //this is for the delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let dayDetailsViewPage:DayDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DayDetailsViewController") as! DayDetailsViewController
        let date = self.nums[indexPath.item]
        dayDetailsViewPage.selectedDay = String(date)
        self.navigationController?.pushViewController(dayDetailsViewPage, animated: true)
        
    }
    //this is an optional function for the Delegate class - need it so users can interact with items
    
}

