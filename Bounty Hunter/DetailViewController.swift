//
//  DetailViewController.swift
//  Bounty Hunter
//
//  Created by 김동환 on 2021/01/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MVVM
    
    //Model
    // BountyInfo
    
    //View
    // -아웃렛으로 이어져있는 변수들
    // -뷰들은 뷰모델을 통해서 구성되기
    
    //ViewModel
    // - 디테일뷰모델
    //> 뷰레이어에서 필요한 메서드 만들기
    // 모델 가지고 있기, 바운티 인포들

    @IBOutlet weak var selectedImg: UIImageView!
    @IBOutlet weak var selectedName: UILabel!
    @IBOutlet weak var selectedBounty: UILabel!

    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    
    
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //뷰가 보이는 시점은 아니고 , 메모리에 올라왔음
        updateUI()
        
        prepareAnimation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //실제로 뷰가 보이는 지점
        showAnimation()

    }
    
    private func prepareAnimation(){
        nameLabelCenterX.constant = view.bounds.width
        bountyLabelCenterX.constant = view.bounds.width
    }
    
    private func showAnimation(){
        nameLabelCenterX.constant = 0
        bountyLabelCenterX.constant = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {self.view.layoutIfNeeded()}, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {self.view.layoutIfNeeded()}, completion: nil)
        
        UIView.transition(with: selectedImg, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)

    }
    
    
    func updateUI(){

        if let bountyInfo = viewModel.bountyInfo{
            selectedImg.image = bountyInfo.image
            selectedName.text = bountyInfo.name
            selectedBounty.text = String(bountyInfo.bounty)
        }
    }
    
    @IBAction func xButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

class DetailViewModel {
    
    var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo?){
        bountyInfo = model
    }
    
}
