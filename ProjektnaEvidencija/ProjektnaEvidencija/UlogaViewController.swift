//
//  OsobaListViewController.swift
//  ProjektnaEvidencija
//
//  Created by Dominik Petrović on 08/05/2020.
//  Copyright © 2020 Marin Smoljanic. All rights reserved.
//

import UIKit

class UlogaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "cell"

    var db:DBHelper = DBHelper()
    var uloge:[Uloga] = []
    var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Lista uloga"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        uloge = db.readUloge()
    }
    
    
    @IBAction func dodajNovuUlogu(_ sender: UIButton) {
        let alert = UIAlertController(title: "Uneste novu ulogu", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Naziv uloge"}

        // tu na textfieldsima treba naci kako uzeti tocno po redoslijedu
        alert.addAction(UIAlertAction(title: "Povratak", style: .cancel, handler: nil))
        let action = UIAlertAction(title: "Pohrani", style: .default) { (_) in
            guard let nazivUloge = alert.textFields![0].text

                else { return }
           
            print("")
            print("")
            print("____________________________________________________")
            print(nazivUloge)
            print("____________________________________________________")
            print("")
            print("")

            let uloga = Uloga(IdUloge: 0, NazUloge: nazivUloge)
            self.db.insertUloga(uloga: uloga)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return uloge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = String(format: "%5@ %15@ ", arguments: [
            String(uloge[indexPath.row].getIdUloge()),
            String(uloge[indexPath.row].getNazUloge())
            ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath )
    {
        myIndex = indexPath.row
        
        let alert = UIAlertController(title: "Uredi podatke uloga", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = String(self.uloge[indexPath.row].getNazUloge())}
        
        
        let action = UIAlertAction(title: "Pohrani", style: .default) { (_) in
            guard let nazUloge = alert.textFields![0].text
               
                else { return }
           
            // let uloga = Uloga(SifProjekta: <#T##Int#>, NazProjekta: <#T##String#>, OpisProjekta: <#T##String#>, DatPocetka: <#T##Int#>, DatZavrsetka: <#T##Int#>)
            // tu se zove zapravo update, a ne insert
            // self.db.insertUloga(uloga: uloga)
        }
        
        let delete = UIAlertAction(title: "Obrisi", style: .destructive) { (_) in
            self.db.deleteUlogaByID(id: self.uloge[indexPath.row].getIdUloge())
        }
        
        let cancle = UIAlertAction(title: "Odustani", style: .cancel ) { (_) in
        }
        alert.addAction(action)
        alert.addAction(delete)
        alert.addAction(cancle)

        present(alert, animated: true, completion: nil)
    }
    
}

