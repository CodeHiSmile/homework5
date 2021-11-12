//
//  ResultViewController.swift
//  baitap_buoi5
//
//  Created by thanmanhvinh on 12/11/2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    var score: Int?
    var totalScore: Int?
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text="Điểm của bạn"
        lbl.textColor=UIColor.darkGray
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 40)
        lbl.numberOfLines=2
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblScore: UILabel = {
        let lbl=UILabel()
        lbl.text="0 / 0"
        lbl.textColor=UIColor.black
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblRating: UILabel = {
        let lbl=UILabel()
        lbl.text="Tốt"
        lbl.textColor=UIColor.black
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let btnRestart: UIButton = {
        let btn = UIButton()
        btn.setTitle("Trở về", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor=UIColor.orange
        btn.layer.cornerRadius=5
        btn.clipsToBounds=true
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.view.backgroundColor=UIColor.white
        self.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        lblTitle.widthAnchor.constraint(equalToConstant: 250).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.view.addSubview(lblScore)
        lblScore.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 0).isActive = true
        lblScore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        lblScore.widthAnchor.constraint(equalToConstant: 150).isActive = true
        lblScore.heightAnchor.constraint(equalToConstant: 60).isActive = true
        lblScore.text = "\(score!) / \(totalScore!)"
        
        self.view.addSubview(lblRating)
        lblRating.topAnchor.constraint(equalTo: lblScore.bottomAnchor, constant: 40).isActive = true
        lblRating.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        lblRating.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        lblRating.heightAnchor.constraint(equalToConstant: 60).isActive = true
        showRating()
        
        self.view.addSubview(btnRestart)
        btnRestart.topAnchor.constraint(equalTo: lblRating.bottomAnchor, constant: 40).isActive = true
        btnRestart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnRestart.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btnRestart.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnRestart.addTarget(self, action: #selector(btnRestartAction), for: .touchUpInside)
    }
    
    @objc func btnRestartAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showRating() {
        var rating = ""
        var color = UIColor.black
        guard let sc = score, let tc = totalScore else { return }
        let s = sc * 100 / tc
        if s < 10 {
            rating = "Bạn muốn thử sức lần nữa không?"
            color = UIColor.darkGray
        }  else if s < 40 {
            rating = "Bạn cũng bình thường thôi!"
            color = UIColor.blue
        } else if s < 60 {
            rating = "Bạn thông minh đấy chứ?"
            color = UIColor.yellow
        } else if s < 80 {
            rating = "Bạn thật là tuyệt vời!"
            color = UIColor.red
        } else if s <= 100 {
            rating = "Quá đỉnh! Bạn thật là giỏi!"
            color = UIColor.orange
        }
        lblRating.text = "\(rating)"
        lblRating.textColor=color
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
