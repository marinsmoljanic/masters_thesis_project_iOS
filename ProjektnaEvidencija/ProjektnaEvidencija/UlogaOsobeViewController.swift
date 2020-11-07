//
//  OsobaListViewController.swift
//  ProjektnaEvidencija
//
//  Created by Dominik Petrović on 08/05/2020.
//  Copyright © 2020 Marin Smoljanic. All rights reserved.
//

import UIKit

class UlogaOsobeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "cell"

    var db:DBHelper = DBHelper()
    var ulogeOsoba:[UlogaOsobe] = []
    
    // var choices = ["Toyota","Honda","Chevy","Audi","BMW"]
    
    var choices = ["Marin", "Klara", "Dominik", "Dusko"]
    var projekti = ["Puntijarka", "Pleternica", "Diplomski", "Prevoditelj"]
    var uloge = ["Arhitekt", "Ilustrator", "Dizajner", "Programer"]
    
    //var pickerView = UIPickerView()
    var typeValue = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Lista uloga osoba"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        ulogeOsoba = db.readAllUlogaOsoba()
    }
    
    @IBAction func showChoices(_ sender: Any) {
        let alert = UIAlertController(title: "Car Choices", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addTextField { (tf) in tf.placeholder = "Sifra projekta"}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            
            print("You selected " + self.typeValue )
        
        }))
        self.present(alert,animated: true, completion: nil )
        
    }
    
    @IBAction func dodajNovuUlogu(_ sender: UIButton) {
        let alert = UIAlertController(title: "Unesite ulogu osobe", message: "", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        // alert.addTextField { (tf) in tf.placeholder = "Sifra projekta"}
        // alert.addTextField { (tf) in tf.placeholder = "Datum dodjele uloge"}

        // alert.addTextField { (textfield) in
            // let datepicker = UIDatePicker()
            // add delegate ... here

        //    textfield.inputView = datepicker
        //}
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 50, width: 270, height: 100))
        datePicker.datePickerMode = UIDatePicker.Mode.date

        //add target
        datePicker.addTarget(self, action: #selector(dateSelected(datePicker:)), for: UIControl.Event.valueChanged)

        alert.view.addSubview(datePicker)//a
        
        let _listPickerObj = ListPicker(elements: uloge, alert: alert)
        // let _listPicker = _listPickerObj.getListPicker()


        
        let osobaPicker = UIPickerView(frame: CGRect(x: 0, y: 230, width: 270, height: 100))
        alert.view.addSubview(osobaPicker)
        osobaPicker.dataSource = self
        osobaPicker.delegate = self

        //let label = UILabel(frame: CGRect(x: 0, y: 100, width: 250, height: 50))
        //label.text = "Probni tekst"
        //alert.view.addSubview(label)
        
        let ulogaPicker = UIPickerView(frame: CGRect(x: 0, y: 330, width: 270, height: 100))
        alert.view.addSubview(ulogaPicker)
        ulogaPicker.dataSource = self
        ulogaPicker.delegate = self

 
        //alert.view.addSubview(testTextField)
        // alert.addTextField { (tf) in tf.placeholder = "Id osobe"}
        // alert.addTextField { (tf) in tf.placeholder = "Id uloge"}
        
        alert.addAction(UIAlertAction(title: "Povratak", style: .cancel, handler: nil))
        let action = UIAlertAction(title: "Pohrani", style: .default) { (_) in
            guard let sifraProjekta = alert.textFields![0].text,
                let idOsobe = alert.textFields![1].text,
                let idUloge = alert.textFields![2].text,
                let datDodjele = alert.textFields![3].text
                
                else { return }
           
            print("")
            print("")
            print("____________________________________________________")
            print(sifraProjekta)
            print(idOsobe)
            print(idUloge)
            print(datDodjele)
            print("____________________________________________________")
            print("")
            print("")

            let _sifraProjekta = Int(sifraProjekta)
            let _idOsobe = Int(idOsobe)
            let _idUloge = Int(idUloge)
            let _datDodjele = Int(datDodjele)

            let ulogaOsobe = UlogaOsobe(SifProjekta: _sifraProjekta!, IdOsobe: _idOsobe!, IdUloge: _idUloge!, DatDodjele: _datDodjele!)
            self.db.insertUlogaOsobe(ulogaOsobe: ulogaOsobe)
        }
        alert.addAction(action)
        
        var height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 2, constant: self.view.frame.height * 0.72)
        alert.view.addConstraint(height);
        
        self.present(alert, animated: true, completion: nil)    }
    
    
    
    //selected date func
    @objc func dateSelected(datePicker:UIDatePicker) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short

        let currentDate = datePicker.date

        print(currentDate)

    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ulogeOsoba.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = String(format: "%5@ %15@ %20@", arguments: [
            String(ulogeOsoba[indexPath.row].getSifProjekta()),
            String(ulogeOsoba[indexPath.row].getIdOsobe()),
            String(ulogeOsoba[indexPath.row].getIdUloge()),
            String(ulogeOsoba[indexPath.row].getIdUloge()),
            String(ulogeOsoba[indexPath.row].getDatDodjele())

            ])
        
        return cell
    }
    
    
    // new picker options
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
     
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return projekti.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projekti[row]
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
    
    func listPicker(elements: [String]) -> UIPickerView {
        
        let _listPicker = UIPickerView(frame: CGRect(x: 0, y: 130, width: 270, height: 100))
        
        // new picker options
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
         
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return elements.count
        }
            
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return elements[row]
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
        
        return _listPicker
    }
    
}
