//
//  OsobaListViewController.swift
//  ProjektnaEvidencija
//
//  Created by Dominik Petrović on 08/05/2020.
//  Copyright © 2020 Marin Smoljanic. All rights reserved.
//

import UIKit

class OsobaListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "cell"
    
    var db:DBHelper = DBHelper()
    var osobe:[Osoba] = []
    var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Lista osoba"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        osobe = db.readOsobe()
    }
    
    @IBAction func dodajOsobu(_ sender: UIButton) {
        let alert = UIAlertController(title: "Uneste novu osobu", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Prezime"}
        alert.addTextField { (tf) in tf.placeholder = "Ime"}
        alert.addTextField { (tf) in tf.placeholder = "OIB"}

        // tu na textfieldsima treba naci kako uzeti tocno po redoslijedu
        alert.addAction(UIAlertAction(title: "Povratak", style: .cancel, handler: nil))
        let action = UIAlertAction(title: "Pohrani", style: .default) { (_) in
            guard let ime = alert.textFields![0].text,
                let prezime = alert.textFields![1].text,
                let OIB = alert.textFields![2].text

                else { return }
            
            print(ime)
            print(prezime)
            print(OIB)
            
            let osoba = Osoba(idOsobe: 0,imeOsobe: ime, prezimeOsobe: prezime, OIB: OIB)
            self.db.insertOsoba(osoba: osoba)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return osobe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = String(osobe[indexPath.row].getIdOsobe()) + " " + String(osobe[indexPath.row].getPrezimeOsobe()) + " " + String(osobe[indexPath.row].getImeOsobe()) + " " +  String(osobe[indexPath.row].getOIBOsobe())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath )
    {
        myIndex = indexPath.row
        
        let alert = UIAlertController(title: "Uredi podatke osobe", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = String(self.osobe[indexPath.row].getPrezimeOsobe());
             tf.isSecureTextEntry = true
        }
        alert.addTextField { (tf) in tf.placeholder = String(self.osobe[indexPath.row].getImeOsobe())}
        alert.addTextField { (tf) in tf.placeholder =  String(self.osobe[indexPath.row].getOIBOsobe())}
        
        
       // tu na textfieldsima treba naci kako uzeti tocno po redoslijedu
        let action = UIAlertAction(title: "Pohrani", style: .default) { (_) in
            guard let ime = alert.textFields![0].text,
                let prezime = alert.textFields![1].text,
                let OIB = alert.textFields![2].text

                else { return }
           
            print(ime)
            print(prezime)
            print(OIB)
           
            let osoba = Osoba(idOsobe: 5,imeOsobe: ime, prezimeOsobe: prezime, OIB: OIB)
            // tu se zove zapravo update, a ne insert
            self.db.insertOsoba(osoba: osoba)
        }
        
        let delete = UIAlertAction(title: "Obrisi", style: .destructive) { (_) in
            self.db.deleteOsobaByID(id: self.osobe[indexPath.row].getIdOsobe())
        }
        
        let cancle = UIAlertAction(title: "Odustani", style: .cancel ) { (_) in
        }
        alert.addAction(action)
        alert.addAction(delete)
        alert.addAction(cancle)

        present(alert, animated: true, completion: nil)
    }
    
}
