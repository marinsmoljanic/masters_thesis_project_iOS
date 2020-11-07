//
//  ListPicker.swift
//  ProjektnaEvidencija
//
//  Created by Dominik Petrović on 05/06/2020.
//  Copyright © 2020 Marin Smoljanic. All rights reserved.
//

import Foundation
import UIKit

class ListPicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    let elements: [String]
    var typeValue = String()
    let alert: UIAlertController
    
    init(elements: [String], alert: UIAlertController){
        self.elements = elements
        self.alert = alert
    }
    
    let _listPicker = UIPickerView(frame: CGRect(x: 0, y: 130, width: 270, height: 100))
    //self.alert.view.addSubview(_listPicker)
    //_listPicker.dataSource = self
    //_listPicker.delegate = self
    
    // new picker options
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
     
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.elements.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.elements[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            typeValue = "Toyota"
        } else if row == 1 {
            typeValue = "Honda"
        } else if row == 2 {
            typeValue = "Chevy"
        } else if row == 3 {
            typeValue = "Audi"
        } else if row == 4 {
            typeValue = "BMW"
        }
    }
    
    func getListPicker() -> UIPickerView {
        return self._listPicker
    }
}
