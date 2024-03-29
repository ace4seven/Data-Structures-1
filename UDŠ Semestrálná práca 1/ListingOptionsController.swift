import UIKit

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ListController, let regions = sender as? [Region] {
            let viewModel = ListViewModel(values: regions.map{ ListType.region($0) })
            vc.viewModel = viewModel
        }
    }
    
}

extension ListingOptionsController: ListingOptionsViewDelegate {
    
    func goToRegionList(regions: [Region]) {
        performSegue(withIdentifier: String(describing: ListController.self), sender: regions)
    }
    
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
        case .task3:
            performSegue(withIdentifier: String(describing: ListingPersonController.self), sender: nil)
        case .task7:
            performSegue(withIdentifier: String(describing: FormRegionNameController.self), sender: nil)
        case .task8:
            performSegue(withIdentifier: String(describing: FormOwnerPropertiesController.self), sender: nil)
        case .task9:
            performSegue(withIdentifier: String(describing: ListingOwnerPropertiesController.self), sender: nil)
        case .task15:
            viewModel.showRegionsOrderedByName()
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
