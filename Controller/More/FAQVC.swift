//
//  FAQVC.swift
//  E4 Patient
//
//  Created by Nada on 2/28/22.
//

import UIKit

class FAQVC: UIViewController {

    var faqData: [FAQData]?
    
    @IBOutlet weak var faqTB: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.title = "FAQ"
       getData()
        
        faqTB.delegate = self
        faqTB.dataSource = self
        faqTB.separatorStyle = .none
        faqTB.rowHeight = 44
        faqTB.estimatedRowHeight = UITableView.automaticDimension
        faqTB.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")
        
    }
    
    func getData() {
        showUniversalLoadingView(true)
        NetworkClient.performRequest(_type: FAQModel.self, router: .faq) { result in
            showUniversalLoadingView(false)
            switch result{
            case .success(let model):
                print(model)
                if model.successtate == 200{
                    self.faqData = model.message
                    self.faqTB.reloadData()
                }else{

                }
            case .failure(let model):
                self.showMessage(title: "", sub: "error connecting to server. please try again", type: .error, layout: .messageView)
                print("failure: \(model)")
            
            }
        }
    }

}

extension FAQVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as! FAQCell
        
        cell.questionLbl.text = faqData?[indexPath.row].nameLocalized ?? ""
        cell.answerLbl.text = faqData?[indexPath.row].helpsupportAnswerLocalized ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

