//
//  exTableView.swift
//  E4 Patient
//
//  Created by mohab on 13/03/2021.
//

import UIKit
extension UITableView {
    
   func reloadAnimationTable(){
    
    switch Int(arc4random_uniform(3)) {
    case 0:
        animateTable0()
        break
    case 1:
        animateTable1()
        break
    case 2 :
        animateTable2()
        break
        
    default:
        break
        }
    
    }
    
    func animateTableView0(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
        
    }
    func animateTableView1(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            if index % 2 == 0 {
                cell.transform = CGAffineTransform(translationX: 1000, y: tableViewHeight)
            } else {
                cell.transform = CGAffineTransform(translationX: -1000, y: tableViewHeight)
            }
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    
    func animateTableView2(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: -1000, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
    }
    
    func scrollToBottomTableView(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1 ) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    func scrollToTopTableView() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    
    
    func setEmptyView( messageImage: UIImage? = UIImage(named: "box-2"), title: String? = "Empty Data".localized, message: String? = "", withImage: Bool = true) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageImageView = UIImageView()
        messageImageView.contentMode = .scaleAspectFit
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = AppColor.Blue
        titleLabel.font = UIFont(name: AppFont.Cairo.regular.value, size: 18)
        
        messageLabel.textColor = UIColor.lightGray
       // messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
      //  messageLabel.font = UIFont(name: AppFont.STC.Bold.value, size: 17)

        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(messageLabel)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = messageImage
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        if withImage == true{
            messageImageView.isHidden = false
        }else{
            messageImageView.isHidden = true
        }
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
        func restore() {
            self.backgroundView = nil
            //self.separatorStyle = .singleLine
        }
    
    
    
}
