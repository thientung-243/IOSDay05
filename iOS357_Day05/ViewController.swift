//
//  ViewController.swift
//  iOS357_Day05
//
//  Created by Thien Tung on 31/03/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var timer: Timer?
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set ảnh cho UIImageView
        contentImageView.image = UIImage(named: "image")
        // Set ảnh cho UIImageView bằng ảnh default Xcode
        contentImageView.image = UIImage(systemName: "pencil")
        
        // Set ảnh từ URL
        guard let urlImage = URL(string: "https://img5.thuthuatphanmem.vn/uploads/2021/08/25/background-3d-4k_085529380.jpg") else {
            return
        }
        
        do {
            let imageData = try Data(contentsOf: urlImage)
            contentImageView.image = UIImage(data: imageData)
        } catch {
            print("Error when get image: \(error.localizedDescription)")
        }
        
        // Content Mode
        contentImageView.contentMode = .scaleAspectFill
        
        // Alpha: độ đậm của view (0 -> 1)
        contentImageView.alpha = 1
        
        // Hidden: Hiển thị view (true/false)
        contentImageView.isHidden = false
        
        // ClipToBounds: hiển thị view đè ra ngoài khung
        contentImageView.clipsToBounds = true
        
        // CornerRadius: Bo góc
        contentImageView.layer.cornerRadius = 16
        
        // MARK: Progress:
        // Hiển thị tiến độ Float 0.0 -> 1.0
        progressBar.progress = 0.9
        // Set màu của thanh bar đằng sau
        progressBar.trackTintColor = UIColor.brown
        // Set màu của thanh progress
        progressBar.progressTintColor = .green
        
//        setUpTimer()
//        setProgress()
        
        // MARK: Activity Indicator
        // Kiểm tra indicatỏ đang chạy hay không
        print(activityIndicator.isAnimating)
        // Cho indicator chạy hoạt ảnh
        activityIndicator.startAnimating()
        // Dừng hoạt ảnh
//        activityIndicator.stopAnimating()
        // Ẩn indicator khi đã dừng hoạt cảnh
        activityIndicator.hidesWhenStopped = false
        // Set màu indicator
        activityIndicator.color = .red // Màu của vòng loading
        activityIndicator.backgroundColor = .black // Màu background
        
    }
    
    func setProgress() {
        progressBar.progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            self.progressBar.progress += 0.01 // Mỗi 0.01 giây tăng progress lên 0.01
            if self.progressBar.progress >= 1 { //Nếu progress >=1 thì dừng timer, set timer mới
                self.timer?.invalidate()
                self.timer? = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
                    self.progressBar.progress -= 0.01 // Mỗi 0.01 giây trừ progress đi 0.01
                    if self.progressBar.progress <= 0 { // Nếu progress <= 0
                        self.timer?.invalidate() // Dừng timer
//                        self.setProgress()
                        // Xoá view progressBar ra khỏi SuperView
                        self.progressBar.removeFromSuperview()
                    }
                })
            }
        })
    }
    
    func setUpTimer() {
        // timeInterval: là thời gian để lặp lại khối lệnh trong Timer
        // repeats: true/false => có lặp lại khối lệnh hay không
        // block: khối lệnh để timer thực hiện lặp lại
        var i: Float = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { _ in
            i += 0.5
            print(i)
            
            // Kiểm tra timer có đang chạy
            print(self.timer?.isValid)
            
            if i >= 50 {
                // Cho dừng timer
                self.timer?.invalidate()
                print(self.timer?.isValid)
            }
        })
    }


}

