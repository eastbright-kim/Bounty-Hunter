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

    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
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
