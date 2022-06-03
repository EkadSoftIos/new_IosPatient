//
//  LoginVC.swift
//  E4 Patient
//
//  Created by mohab on 16/01/2021.
//

import UIKit
import SKCountryPicker
import TransitionButton
import FacebookCore
import FacebookLogin
import GoogleSignIn


class LoginVC: UIViewController ,UITextFieldDelegate,GIDSignInDelegate{
    
    var agree = false
    var socialName = ""
    var socialUserName = ""
    var socialEmail = ""
    var socialPassword = ""
    var social_id = ""
    var socialImage = ""
    var socialPhone = ""
    var isSocial = false

    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet var countryImage: UIImageView!
    @IBOutlet var countryNameLbl: UILabel!
    @IBOutlet var phoneTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var loginBtn: TransitionButton!
    
    
    @IBOutlet weak var loginTitltLBL: UILabel!
    @IBOutlet weak var welcomeBackLBL: UILabel!
    @IBOutlet weak var mobileLBL: UILabel!
    @IBOutlet weak var passwordLBL: UILabel!
    @IBOutlet weak var forgetPassBTN: UIButton!
    @IBOutlet weak var orLoginLBL: UILabel!
    @IBOutlet weak var dontHaveAccountLBL: UILabel!
    @IBOutlet weak var signupBTN: UIButton!
    @IBOutlet weak var bySigningLBL: UILabel!
    @IBOutlet weak var termsBTN: UIButton!
    var digitalCountryCode = "+20"
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.ShadowView(view: mainView, radius: 20, opacity: 0.4, shadowRadius: 4, color: UIColor.black.cgColor)
        agreeBtn.layer.cornerRadius = 7
        agreeBtn.layer.borderColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
        agreeBtn.layer.borderWidth = 1
        phoneTxt.delegate = self
    }
    func setLocalization(){
        loginTitltLBL.text = "Login".localized
        welcomeBackLBL.text = "Welcome Back".localized
        mobileLBL.text = "Mobile".localized
        passwordLBL.text = "Password".localized
        passwordTxt.placeholder = "Password".localized
        forgetPassBTN.setTitle("Forget Password?".localized, for: .normal)
        loginBtn.setTitle("Login".localized, for: .normal)
        orLoginLBL.text = "Or Login With".localized
        dontHaveAccountLBL.text = "Don't have an account ?".localized
        signupBTN.setTitle("SignUp", for: .normal)
        bySigningLBL.text = "By signing up you agree to E4 clinic".localized
        termsBTN.setTitle("Terms, Condition".localized, for: .normal)
    }
    func setAlignement(){
        if Languagee.language == .arabic {
            phoneTxt.textAlignment = .right
            passwordTxt.textAlignment = .right
        }else{
            phoneTxt.textAlignment = .left
            passwordTxt.textAlignment = .left
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self

        setLocalization()
        setAlignement()
        self.phoneTxt.placeholder = "+2 000 00000 000"
    }
    @IBAction func agreeBtnPressed(_ sender: Any) {
        agree = !agree
        if agree {
            agreeBtn.layer.cornerRadius = 7
            agreeBtn.layer.borderColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
            agreeBtn.layer.borderWidth = 1
            agreeBtn.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
        } else {
            agreeBtn.layer.cornerRadius = 7
            agreeBtn.layer.borderColor = #colorLiteral(red: 0.07058823529, green: 0.4666666667, blue: 0.8196078431, alpha: 1)
            agreeBtn.layer.borderWidth = 1
            agreeBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    @IBAction func chooseCountry_Click(_ sender: Any) {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
            guard let self = self else { return }
            self.countryImage.image = country.flag
            self.countryNameLbl.text = country.countryCode
            self.digitalCountryCode = country.digitCountrycode ?? ""
            self.phoneTxt.placeholder = "\("+")\(country.digitCountrycode ?? "")"
        }
//        countryController.detailColor = UIColor.blue
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.phoneTxt.text = self.digitalCountryCode
        return true
    }
    @IBAction func login_Click(_ sender: Any) {
        validationinput()
    }
    @IBAction func register_Click(_ sender: Any) {
            registerClick()
        }
    @IBAction func ForgetPass_Click(_ sender: Any) {
            forgetPassClick()
        }
    @IBAction func ShowPass_Click(_ sender: Any) {
        if passwordTxt.isSecureTextEntry == false {
            passwordTxt.isSecureTextEntry = true
        }else{
            passwordTxt.isSecureTextEntry = false
        }
        
    }
    @IBAction func google_Click(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func didTappedFaceBook(_ sender: Any) {
        loginWithFacebook()
    }
    
    @IBAction func didTappedGoogle(_ sender: Any) {
        
    }
    
    func loginWithFacebook() {
      let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
        print(result)
          switch result {
          case .cancelled:
              print("User cancelled login process")
              break
          case .failed(let error) :
              print("Login failed with error = \(error.localizedDescription)")
              break
          case .success(_, _, let accessToken):
              
              print("access token == \(accessToken)")
              self.getUserProfile()
          }
      }
    }
    func getUserProfile() {
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields" : "id,name,about,birthday, email, picture.width(480).height(480)"], httpMethod: .get)) { (connection, response, error) in
            if let error = error {
                print("Error getting user info = \(error.localizedDescription)")
            } else {
                guard let userInfo = response as? Dictionary<String,Any> else {
                    return
                }
                print(userInfo)
                var userId: String?
                var username: String?
                var email: String?
                var imgUrl: String?
                var phone: String?
                
                if let userID = userInfo["id"] as? String {
                    print("Logged in user facebook id == \(userID)")
                    userId = userID
                    self.social_id = userID
                }

                if let userName = userInfo["name"] as? String {
                    print("Logged in user facebook name == \(userName)")
                    self.socialUserName = userName
                }
                if let userEmail = userInfo["email"] as? String {
                    print("Logged in user facebook name == \(userEmail)")
                    self.socialEmail = userEmail
                }
                if let userPhone = userInfo["phone"] as? String {
                    print("Logged in user facebook name == \(userPhone)")
                    self.socialPhone = userPhone
                }
                if let imageURL = ((userInfo["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                    self.socialImage = imageURL
                }
                self.socialName = "Facebook"
                // signIn
                self.checkEmailApi()
//                self.loginViewModel.login(provider_id: userId ?? "0", provider_name: "facebook", name: username ?? "", email: email ?? "", profile_image: imgUrl ?? "")
            }
        }
        connection.start()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
      if let error = error {
        print("We have error sign user", error.localizedDescription)
      } else {
        if let gmailUser = user {
        socialEmail = gmailUser.profile.email ?? ""
            socialUserName = gmailUser.profile.name ?? ""
            social_id = gmailUser.userID!
            
          print("You are signed in with id", gmailUser.userID!)
          print("You are signed in with idToken", gmailUser.authentication.idToken!)
          print("You are signed in with email", gmailUser.profile.email!)
          print("You are signed in with name", gmailUser.profile.name!)
            let imageUrl = signIn.currentUser.profile.imageURL(withDimension: 150)
            let image = (imageUrl?.absoluteString)!
            
            isSocial = true
            socialName = "Google"
            checkEmailApi()
//            presenter.login(phone: gmailUser.profile.email ?? "" , password: passTXT.text! , socialId: gmailUser.userID ?? "", SocialName: "google")
        }
      }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    
          print("Sign in dismissed")
    }


    


}
