//
//  TabBarVC.swift
//  E4 Patient
//
//  Created by mohab on 17/01/2021.
//

import UIKit

class TabbarManager: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
    }
    
    func setupTabbar(){
        let home = HomeVC()
        home.tabBarItem = UITabBarItem(title: AppString.TabHome,
                                       image:  AppImages.Home,
                                       selectedImage: AppImages.HomeSelected)
        setLogo(VC: home)

        let Appointment = AppointmentVC()
        Appointment.tabBarItem = UITabBarItem(title: AppString.Appointment,
                                           image: AppImages.Appointment,
                                           selectedImage: AppImages.AppointmentSelected)
        setLogo(VC: Appointment)
        let Pharmacy = PharmacyVC()
        Pharmacy.tabBarItem = UITabBarItem(title: AppString.Pharmacy,
                                               image: AppImages.Pharmacy,
                                               selectedImage: AppImages.PharmacySelected)
        setLogo(VC: Pharmacy)
        let Blog = BlogVC()
        Blog.tabBarItem = UITabBarItem(title: AppString.Blog,
                                               image: AppImages.Blog,
                                               selectedImage: AppImages.BlogSelected)
        setLogo(VC: Blog)
        let More = MoreVC()
        More.tabBarItem = UITabBarItem(title: AppString.More,
                                          image: AppImages.More,
                                          selectedImage: AppImages.MoreSelected)
        setLogo(VC: More)
        
        
        viewControllers = [setNav(VC: home),
                           setNav(VC: Appointment),
                           setNav(VC: Pharmacy),
                           setNav(VC: Blog),
                           setNav(VC: More)]
    }
    
    func setLogo(VC : UIViewController){
        let imagek = AppImages.BarLogo
        let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = imagek
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        let barButton = UIBarButtonItem(image: imagek, landscapeImagePhone: nil, style: .done, target: self, action: nil)
        barButton.isEnabled = false
        
        VC.navigationItem.leftBarButtonItem = barButton
       // setNavButtons()
    }
    
}
extension TabbarManager {
   
    func setNav(VC : UIViewController) -> UINavigationController {
        
        let Nav = UINavigationController.init(rootViewController: VC)
        //===titleLogoView===
        /*  let imagek = AppImages.whiteLogo?.resizeImage(newSize: CGSize.init(width: 150, height: 40))
         let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
         imageView.image = imagek
         imageView.contentMode = .scaleAspectFit
         VC.navigationItem.titleView = imageView*/
        
        return Nav
    }
    
    
}
extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 50
        return sizeThatFits
    }
}



