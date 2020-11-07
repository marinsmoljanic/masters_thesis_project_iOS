//
//  OsobaListViewController.swift
//  ProjektnaEvidencija
//
//  Created by Dominik Petrović on 08/05/2020.
//  Copyright © 2020 Marin Smoljanic. All rights reserved.
//

import UIKit

class ProjektViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "cell"

    var db:DBHelper = DBHelper()
    var projekti:[Projekt] = []
    var myIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Lista projekata"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        projekti = db.readProjekte()
    }
    
    @IBAction func dodajNoviProjekt(_ sender: UIButton) {
        let alert = UIAlertController(title: "Uneste novu osobu", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Naziv projekta"}
        alert.addTextField { (tf) in tf.placeholder = "Opis projekta"}
        alert.addTextField { (tf) in tf.placeholder = "Datum pocetka"}
        alert.addTextField { (tf) in tf.placeholder = "Datum zavrsetka"}

        // tu na textfieldsima treba naci kako uzeti tocno po redoslijedu
        alert.addAction(UIAlertAction(title: "Povratak", style: .cancel, handler: nil))
        let action = UIAlertAction(title: "Pohrani", style: .default) { (_) in
            guard let nazivProjekta = alert.textFields![0].text,
                let opisProjekta = alert.textFields![1].text,
                let datumPocetka = alert.textFields![2].text,
                let datumZavrsetka = alert.textFields![3].text
                
                else { return }
           
            print("")
            print("")
            print("____________________________________________________")
            print(nazivProjekta)
            print(opisProjekta)
            print(datumPocetka)
            print(datumZavrsetka)
            print("____________________________________________________")
            print("")
            print("")

            let _datumPocetka = Int(datumPocetka)
            let _datumZavrsetka = Int(datumZavrsetka)

            let projekt = Projekt(SifProjekta: 0, NazProjekta: nazivProjekta, OpisProjekta: opisProjekta, DatPocetka: _datumPocetka!, DatZavrsetka: _datumZavrsetka!)
            self.db.insertProjekt(projekt: projekt)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return projekti.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = String(format: "%5@ %15@ %20@", arguments: [
            String(projekti[indexPath.row].getSifProjekta()),
            String(projekti[indexPath.row].getNazivProjekta()),
            String(projekti[indexPath.row].getOpisProjekta())
            ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath )
    {
        myIndex = indexPath.row
        
        let alert = UIAlertController(title: "Uredi podatke projekta", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = String(self.projekti[indexPath.row].getSifProjekta())}
        alert.addTextField { (tf) in tf.placeholder = String(self.projekti[indexPath.row].getNazivProjekta())}
        alert.addTextField { (tf) in tf.placeholder =  String(self.projekti[indexPath.row].getDatPoceta())}
        alert.addTextField { (tf) in tf.placeholder =  String(self.projekti[indexPath.row].getDatZavrsetka())}
        
        
        let action = UIAlertAction(title: "Pohrani", style: .default) { (_) in
            guard let sifProjekta = alert.textFields![0].text,
                let nazProjekta = alert.textFields![1].text,
                let opisProjekta = alert.textFields![2].text,
                let datPocetka = alert.textFields![3].text,
                let datZavrsetka = alert.textFields![4].text

                else { return }
           
            // let projekt = Projekt(SifProjekta: <#T##Int#>, NazProjekta: <#T##String#>, OpisProjekta: <#T##String#>, DatPocetka: <#T##Int#>, DatZavrsetka: <#T##Int#>)
            // tu se zove zapravo update, a ne insert
            // self.db.insertProjekt(projekt: projekt)
        }
        
        let delete = UIAlertAction(title: "Obrisi", style: .destructive) { (_) in
            self.db.deleteProjektByID(id: self.projekti[indexPath.row].getSifProjekta())
        }
        
        let cancle = UIAlertAction(title: "Odustani", style: .cancel ) { (_) in
        }
        alert.addAction(action)
        alert.addAction(delete)
        alert.addAction(cancle)

        present(alert, animated: true, completion: nil)
    }
}
