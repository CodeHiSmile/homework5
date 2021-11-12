//
//  QuizVC.swift
//  baitap_buoi5
//
//  Created by thanmanhvinh on 12/11/2021.
//

import UIKit

struct Question {
    let imgUrl: String
    let questionTitle: String
    let answers: [String]
    let correctAnswer: Int
    var wrongAnswer: Int
    var isAnswered: Bool
}

class QuizVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var myCollectionView: UICollectionView!

    var listQuestion = [Question]()
    var score: Int = 0
    var currentQuestionNumber = 1
    var window: UIWindow?

    let lblQuestionNumber: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 / 0"
        lbl.textColor = UIColor.gray
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let lblScore: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 / 0"
        lbl.textColor = UIColor.gray
        lbl.textAlignment = .right
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let btnPrev: UIButton = {
        let btn = UIButton()
        btn.setTitle("Trở về", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnPrevNextAction), for: .touchUpInside)
        return btn
    }()

    let btnNext: UIButton = {
        let btn = UIButton()
        btn.setTitle("Tiếp theo", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.purple
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnPrevNextAction), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Đố Vui"
        self.view.backgroundColor = UIColor.white

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1

        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(QuizCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.backgroundColor = UIColor.white
        myCollectionView.isPagingEnabled = true
        myCollectionView.isScrollEnabled = false

        self.view.addSubview(myCollectionView)

        let que1 = Question(imgUrl: "img1", questionTitle: "2 + 2 = ?", answers: ["2", "4", "8", "6"], correctAnswer: 1, wrongAnswer: -1, isAnswered: false)
        let que2 = Question(imgUrl: "img1", questionTitle: "3 x 2 = ?", answers: ["9", "4", "8", "6"], correctAnswer: 3, wrongAnswer: -1, isAnswered: false)
        let que3 = Question(imgUrl: "img1", questionTitle: "3 + 7 = ?", answers: ["2", "3", "10", "5"], correctAnswer: 2, wrongAnswer: -1, isAnswered: false)
        let que4 = Question(imgUrl: "img1", questionTitle: "4 + 5 = ?", answers: ["2", "4", "9", "0"], correctAnswer: 2, wrongAnswer: -1, isAnswered: false)
        let que5 = Question(imgUrl: "img1", questionTitle: "7 + 8 = ?", answers: ["15", "40", "26", "34"], correctAnswer: 0, wrongAnswer: -1, isAnswered: false)
        let que6 = Question(imgUrl: "img1", questionTitle: "3 + 1 = ?", answers: ["4", "5", "6", "7"], correctAnswer: 0, wrongAnswer: -1, isAnswered: false)
        let que7 = Question(imgUrl: "img1", questionTitle: "2 + 6 = ?", answers: ["4", "10", "6", "8"], correctAnswer: 3, wrongAnswer: -1, isAnswered: false)
        let que8 = Question(imgUrl: "img1", questionTitle: "4 x 5 = ?", answers: ["22", "20", "24", "26"], correctAnswer: 1, wrongAnswer: -1, isAnswered: false)
        let que9 = Question(imgUrl: "img1", questionTitle: "3 + 3 = ?", answers: ["4", "5", "6", "7"], correctAnswer: 2, wrongAnswer: -1, isAnswered: false)
        let que10 = Question(imgUrl: "img1", questionTitle: "1 + 8 = ?", answers: ["4", "9", "6", "7"], correctAnswer: 1, wrongAnswer: -1, isAnswered: false)

        listQuestion = [que1, que2, que3, que4, que5, que6, que7, que8, que9, que10]
        setupViews()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listQuestion.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuizCollectionViewCell
        cell.question = listQuestion[indexPath.row]
        cell.delegate = self
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setQuestionNumber()
    }

    func setQuestionNumber() {
        let x = myCollectionView.contentOffset.x
        let w = myCollectionView.bounds.size.width
        let currentPage = Int(ceil(x / w))
        if currentPage < listQuestion.count {
            lblQuestionNumber.text = "Câu hỏi: \(currentPage + 1) / \(listQuestion.count)"
            currentQuestionNumber = currentPage + 1
        }
    }

    func setupViews() {
        myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.view.addSubview(btnPrev)
        btnPrev.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnPrev.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        btnPrev.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        btnPrev.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        //self.view.safeAreaLayoutGuide.bottomAnchor

        self.view.addSubview(btnNext)
        btnNext.heightAnchor.constraint(equalTo: btnPrev.heightAnchor).isActive = true
        btnNext.widthAnchor.constraint(equalTo: btnPrev.widthAnchor).isActive = true
        btnNext.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        btnNext.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

        self.view.addSubview(lblQuestionNumber)
        lblQuestionNumber.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblQuestionNumber.widthAnchor.constraint(equalToConstant: 150).isActive = true
        lblQuestionNumber.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        lblQuestionNumber.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
        lblQuestionNumber.text = "Câu hỏi: \(1) / \(listQuestion.count)"

        self.view.addSubview(lblScore)
        lblScore.heightAnchor.constraint(equalTo: lblQuestionNumber.heightAnchor).isActive = true
        lblScore.widthAnchor.constraint(equalTo: lblQuestionNumber.widthAnchor).isActive = true
        lblScore.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        lblScore.bottomAnchor.constraint(equalTo: lblQuestionNumber.bottomAnchor).isActive = true
        lblScore.text = "Điểm: \(score) / \(listQuestion.count)"
    }

    @objc func btnPrevNextAction(sender: UIButton) {
        if sender == btnNext && currentQuestionNumber == listQuestion.count {
            let nv = ResultViewController()
            nv.score = score
            nv.totalScore = listQuestion.count
            self.navigationController?.pushViewController(nv, animated: false)
            return
        }

        let collectionBounds = self.myCollectionView.bounds
        var contentOffset: CGFloat = 0
        if sender == btnNext {
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x + collectionBounds.size.width))
            currentQuestionNumber += currentQuestionNumber >= listQuestion.count ? 0 : 1
        } else {
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x - collectionBounds.size.width))
            currentQuestionNumber -= currentQuestionNumber <= 0 ? 0 : 1
        }

        self.moveToFrame(contentOffset: contentOffset)

        lblQuestionNumber.text = "Câu hỏi: \(currentQuestionNumber) / \(listQuestion.count)"
    }

    func moveToFrame(contentOffset: CGFloat) {
        let frame: CGRect = CGRect(x: contentOffset, y: self.myCollectionView.contentOffset.y, width: self.myCollectionView.frame.width, height: self.myCollectionView.frame.height)
        self.myCollectionView.scrollRectToVisible(frame, animated: true)
    }

}

extension QuizVC: QuizCollectionViewCellDelegate {

    func didChooseAnswer(btnIndex: Int) {

        let centerIndex = getCenterIndex()

        guard let index = centerIndex else { return }

        listQuestion[index.item].isAnswered = true

        if listQuestion[index.item].correctAnswer != btnIndex {
            listQuestion[index.item].wrongAnswer = btnIndex
        } else {
            score += 1
        }
        lblScore.text = "Điểm: \(score) / \(listQuestion.count)"
        myCollectionView.reloadItems(at: [index])
    }

    func getCenterIndex() -> IndexPath? {
        let center = self.view.convert(self.myCollectionView.center, to: self.myCollectionView)
        let index = myCollectionView!.indexPathForItem(at: center)
        return index
    }
}
