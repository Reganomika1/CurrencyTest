
import UIKit

class ViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppearance()
        errorHandling()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    //MARK: - Appearance
    
    func setAppearance() {
        
        tableView.tableFooterView = UIView()
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
    }
    
    //MARK: - Error Handler
    
    func errorHandling() {
        
        if !ReachabilityManager.isConnectedToNetwork() {
            Navigation.showAlert(title: "Error", message: "No internet connection", viewController: self)
        } else if ParserManager.shared.currencies.count == 0 {
            Navigation.showAlert(title: "Error", message: "No data", viewController: self)
        }
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ParserManager.shared.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
        
        let currency = ParserManager.shared.currencies[indexPath.row]
        
        cell.charCodeLabel.text = "\(currency.charCode) \(currency.rate)"
        cell.scaleLabel.text = "\(currency.name) \(currency.scale)"
        
        return cell
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let movedObject = ParserManager.shared.currencies[sourceIndexPath.row]
        
        ParserManager.shared.currencies.remove(at: sourceIndexPath.row)
        ParserManager.shared.currencies.insert(movedObject, at: destinationIndexPath.row)
    }
}

extension ViewController :UITableViewDelegate {

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

