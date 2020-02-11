import Foundation
import UIKit

struct Item: Decodable{
    var name: String?
    var id: Int
    var listId: Int
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                leading:NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                height: NSLayoutDimension? = nil,
                width: NSLayoutDimension? = nil,
                sizeMultiplier: CGSize = .zero,
                padding: UIEdgeInsets = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let height = height{
            if sizeMultiplier.height != 0{
                heightAnchor.constraint(equalTo: height, multiplier: sizeMultiplier.height).isActive = true
            }
        }
        if let width = width{
            if sizeMultiplier.width != 0{
                widthAnchor.constraint(equalTo: width, multiplier: sizeMultiplier.width).isActive = true
            }
        }
    }
    
    func anchor(height: UIView, width: UIView, sizeMultiplier: CGSize){
        self.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, height: height.heightAnchor, width: width.widthAnchor, sizeMultiplier: sizeMultiplier)
    }
}
