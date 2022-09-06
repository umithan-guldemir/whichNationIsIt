//
//  MainTableViewController.swift
//  whichNationIsIt
//
//  Created by Umithan  on 15.08.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var response: NamesResponse? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()

    }
    
    private func setupSearchController() {
        let search = UISearchController()
        
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Enter name"
        navigationItem.searchController = search
        
    }
    
    
    // MARK: - Country Flags and Round Methods for Cells
    
    private func flag(country: String) -> String {
        if country == "" {
            return "🏴‍☠️"
        }
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    private func roundDouble(double: Double) -> String {
        let roundedDouble = round(double * 100) / 100.0
        var percentage = String(roundedDouble).dropFirst(2)
        if percentage.first == "0" {
            percentage = percentage.dropFirst()
        }
        return "\(percentage)%"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.country?.count ?? .zero
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellCountry = response?.country![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.countryFlag.text = flag(country: cellCountry?.country_id ?? "null")
        cell.countryProbability.text = roundDouble(double: (cellCountry?.probability) ?? 0.0)


        return cell
    }
    
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 2 {
            NetworkManager.shared.searchNames(with: text) { res in
                self.response = res
                self.title = self.response?.name?.capitalized ?? "Which Nationality Is It?"
            }
        }
    }
    
    
}
