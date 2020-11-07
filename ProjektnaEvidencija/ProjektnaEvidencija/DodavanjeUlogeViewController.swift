//
//  DodavanjeUlogeViewController.swift
//  ProjektnaEvidencija
//
//  Created by Dominik Petrović on 05/06/2020.
//  Copyright © 2020 Marin Smoljanic. All rights reserved.
//

import UIKit

class DodavanjeUlogeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var osobaPicker: UIPickerView!
    @IBOutlet weak var projektPicker: UIPickerView!
    @IBOutlet weak var ulogaPicker: UIPickerView!
    @IBOutlet weak var datumZaduzenjaPicker: UIDatePicker!
    
    @IBOutlet weak var pohraniButton: UIButton!
        
    var osobe = ["Marin", "Klara", "Dominik", "Dusko"]
    var projekti = ["Puntijarka", "Pleternica", "Diplomski", "Prevoditelj"]
    var uloge = ["Arhitekt", "Ilustrator", "Dizajner", "Programer"]
    
    override func viewDidLoad() {
        self.title = "Dodavanje uloge"

        // Connect data:
        self.osobaPicker.delegate = self
        self.osobaPicker.dataSource = self
        
        self.projektPicker.delegate = self
        self.projektPicker.dataSource = self
        
        self.ulogaPicker.delegate = self
        self.ulogaPicker.dataSource = self
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == osobaPicker {
            return osobe.count
        }
        else if pickerView == projektPicker{
            return projekti.count
        }
        else {
            return uloge.count
        }
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == osobaPicker {
            return osobe[row]
        }
        else if pickerView == projektPicker{
            return projekti[row]
        }
        else {
            return uloge[row]
        }
    }

}
