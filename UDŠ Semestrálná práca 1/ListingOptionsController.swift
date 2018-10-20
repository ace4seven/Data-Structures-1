import UIKit
import GoodSwift

class ListingOptionsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var items = [OptionType]()
    fileprivate var viewModel = ListingOptionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        setupView()
        
        viewModel.setup(delegate: self)
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerCell(fromClass: OptionCell.self)
        
        tableView.contentInset.top = 20
    }
    
    private func setupView() {
        title = "Výpisy"
    }
    
}

extension ListingOptionsController: ListingOptionsViewDelegate {
    
    func showOptions(tasks: [OptionType]) {
        self.items = tasks
        
        tableView.reloadData()
    }
    
}

extension ListingOptionsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case .task3(let option), .task7(let option), .task8(let option), .task9(let option), .task15(let option):
            let cell = tableView.dequeueReusableCell(fromClass: OptionCell.self, for: indexPath)
            cell?.setupCell(option: option)
            return cell ?? UITableViewCell()
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch items[indexPath.row] {
        case .task7:
            performSegue(withIdentifier: String(describing: FormRegionNameController.self), sender: nil)
        default: break
        }
    }
    
}
