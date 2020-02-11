import UIKit
import NVActivityIndicatorView
class ItemListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titleLabel: UILabel!
    let colors: [UIColor] = [.green, .blue, .red, .black, .purple, .cyan, .magenta, .brown]
    lazy var colorCount = colors.count
    var randomOffset = Int(arc4random_uniform(8))
    var listOfItems: [Item] = []{
        didSet{
            self.tableOfItems.reloadData()
        }
    }
    var tableOfItems: UITableView!
    var activityIndicator: NVActivityIndicatorView!
    let reuseIdentifier = "ItemCellIdentifier"


    override func viewDidLoad() {
        super.viewDidLoad()
        customizeSubviews()
        constrainSubviews()
        loadDataToUI()
        
    }
    
    private func loadDataToUI(){
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.getSortedData { [weak self](items) -> (Void) in
                DispatchQueue.main.async {
                    self?.listOfItems = items
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func customizeSubviews(){
        customizeTitleLabel()
        customizeTableView()
    }
    
    private func constrainSubviews(){
        constrainTitleLabel()
        constrainTableView()
        constrainIndicatorView()
    }
    
    
    private func customizeTitleLabel(){
        let titleSize = UIScreen.main.bounds.width * 0.125
        let backgroundColor = UIColor.init(red: 255/255, green: 174/255, blue: 66/255, alpha: 1)
        let text = "Items"
        titleLabel = UILabel(frame: .zero)
        titleLabel.text = text
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.init(name: "HelveticaNeue-Bold", size: titleSize)
        titleLabel.backgroundColor = backgroundColor
    }
    
    private func customizeTableView(){
        let backgroundColor = UIColor.init(red: 255/255, green: 196/255, blue: 117/255, alpha: 1)
        tableOfItems = UITableView(frame: .zero, style: .plain)
        tableOfItems.delegate = self
        tableOfItems.dataSource = self
        tableOfItems.backgroundColor = .clear
        tableOfItems.separatorColor = .clear
        view.backgroundColor = backgroundColor
        tableOfItems.register(ItemCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableOfItems.isScrollEnabled = true
    }
    
    private func constrainTitleLabel(){
        self.view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, height: view.heightAnchor, sizeMultiplier: .init(width: 0, height: 0.125))
    }
    
    private func constrainTableView(){
        let verticalPadding = UIScreen.main.bounds.height * 0.025
        let horizantalPadding = UIScreen.main.bounds.width * 0.025
        let padding = UIEdgeInsets.init(top: verticalPadding, left: horizantalPadding, bottom: verticalPadding, right: horizantalPadding)
        self.view.addSubview(tableOfItems)
        tableOfItems.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: padding)
    }
    
    
    private func constrainIndicatorView(){
        let verticalPadding = UIScreen.main.bounds.height * 0.025
        let horizantalPadding = UIScreen.main.bounds.width * 0.35
        let padding = UIEdgeInsets.init(top: verticalPadding, left: horizantalPadding, bottom: verticalPadding, right: horizantalPadding)
        activityIndicator = NVActivityIndicatorView(frame: .zero, type: .ballPulse, color: .black, padding: 0)
        tableOfItems.addSubview(activityIndicator)

        activityIndicator.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: padding)
        activityIndicator.startAnimating()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ItemCell
        let item = listOfItems[indexPath.row]
        if let name = item.name{
            let color_index = (item.listId + randomOffset) % colorCount
            let color = colors[color_index]
            itemCell.configure(name: name, color: color)
        }
        return itemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UIScreen.main.bounds.height * 0.1
        return height
    }
    
    
}


