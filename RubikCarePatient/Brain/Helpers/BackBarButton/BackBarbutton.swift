//
//  BackBarbutton.swift
//  OneTwo
//
//  Created by Mohamed Lotfy on 9/18/18.
//  Copyright © 2018 com.OneTwo. All rights reserved.
//
import UIKit


class BackBarButtonItem: UIBarButtonItem {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if L102Language.currentAppleLanguage() == arabicLang {
            self.image = #imageLiteral(resourceName: "backArabic")
        }
    }
}

class BackBarButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if L102Language.currentAppleLanguage() == arabicLang {
            self.setImage(#imageLiteral(resourceName: "backArabic"),for: .normal)
            self.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}

class GoldBackBarBtnItem: UIBarButtonItem {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if L102Language.currentAppleLanguage() == arabicLang {
            self.image = #imageLiteral(resourceName: "ar back")
            self.tintColor = #colorLiteral(red: 0.840886116, green: 0.6630725861, blue: 0.2519706488, alpha: 1)
        }
    }
}

class BackItemImage: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if L102Language.currentAppleLanguage() == arabicLang {
            self.image = #imageLiteral(resourceName: "arrow_left")
        }
    }
}

class BackArrowOrangeImage: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if L102Language.currentAppleLanguage() == arabicLang {
            self.image = #imageLiteral(resourceName: "arrow_left_orange")
        }
    }
}

class BackArrowBlueImage: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if L102Language.currentAppleLanguage() == arabicLang {
            self.image = #imageLiteral(resourceName: "arrow_left_blue")
        }
    }
}
class BackArrowGreenImage: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if L102Language.currentAppleLanguage() == arabicLang {
            self.image = #imageLiteral(resourceName: "arrow_left_green")
        }
    }
}
class LabelItem: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if L102Language.currentAppleLanguage() == arabicLang {
            self.textAlignment = .left
        }
    }
}

class SunImage: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        print(hour)
        if hour >= 6 && hour  <= 17 {
            self.image = #imageLiteral(resourceName: "Sun")
        }else  {
            self.image = #imageLiteral(resourceName: "Night")

        }
    }
}

class SunLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        print(hour)
        if hour >= 6 && hour  <= 17 {
            self.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else  {
            self.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}
