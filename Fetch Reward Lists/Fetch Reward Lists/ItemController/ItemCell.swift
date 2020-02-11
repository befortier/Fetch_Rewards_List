import Foundation
import UIKit


class ItemCell: UITableViewCell {
    var name: UILabel!
    var idIndicator: CircleView!
    var container: UIView!
    private let cornerRadius = UIScreen.main.bounds.width * 0.03

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customizeSubviews()
        constrainSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customizeSubviews(){
        customizeContainerView()
        customizeNameLabel()
    }
    
    private func constrainSubviews(){
        constrainContainerView()
        constrainIdIndicator()
        constrainNameLabel()
    }
    
    private func customizeContainerView(){
        container = UIView(frame: .zero)
        container.backgroundColor = .white
        container.layer.cornerRadius = cornerRadius
        container.layer.masksToBounds = true
        self.backgroundColor = .clear
        self.selectionStyle = .none;

    }
    
    private func customizeNameLabel(){
        let fontSize = UIScreen.main.bounds.width * 0.075
        name = UILabel(frame: .zero)
        name.font = UIFont.init(name: "HelveticaNeue", size: fontSize)
    }


    private func constrainNameLabel(){
        let leftPadding = UIScreen.main.bounds.width * 0.1
        let namePadding = UIEdgeInsets.init(top: 0, left: leftPadding, bottom: 0, right: 0)
        container.addSubview(name)
        name.anchor(top: self.topAnchor, leading: idIndicator.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: namePadding)
    }
    
    private func constrainIdIndicator(){
        idIndicator = CircleView(color: .black)
        self.container.addSubview(idIndicator)
        let leftPadding = UIScreen.main.bounds.width * 0.04
        let indicatorPadding = UIEdgeInsets.init(top: 0, left: leftPadding, bottom: 0, right: 0)
        idIndicator.anchor(top: nil, leading: container.leadingAnchor, bottom: nil, trailing: nil, height: container.heightAnchor, width: idIndicator.heightAnchor, sizeMultiplier: .init(width: 1, height: 0.2), padding: indicatorPadding)
        idIndicator.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    }
    
    private func constrainContainerView(){
        let verticalPadding = UIScreen.main.bounds.height * 0.01
        let containerPadding = UIEdgeInsets.init(top: verticalPadding, left: 0, bottom: verticalPadding, right: 0)
        self.addSubview(container)
        self.container.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: containerPadding)
    }
    
    
    func configure(name: String, color: UIColor) {
        DispatchQueue.main.async {
            self.name.text = name
            self.idIndicator.backgroundColor = color
        }
    }
}

