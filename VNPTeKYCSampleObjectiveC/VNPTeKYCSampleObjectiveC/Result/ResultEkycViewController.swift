//
//  ResultEkycViewController.swift
//  VNPTeKYCSampleObjectiveC
//
//  Created by Minh Nguyễn Minh on 04/01/2023.
//

import UIKit

class ResultEkycViewController: UIViewController {

    @objc var scanQRCodeResult: String = ""
    @objc var ocrResult: String = ""
    @objc var compareFaceResult: String = ""
    @objc var livenessFaceResult: String = ""
    @objc var verifyFaceResult: String = ""
    @objc var maskedFaceResult: String = ""
    @objc var livenessCardFrontResult: String = ""
    @objc var livenessCardBackResult: String = ""
    @objc var addFaceResult: String = ""
    @objc var searchFaceResult: String = ""
    
    @objc var imageQRCodeCroped: UIImage = UIImage()
    @objc var hashImageQRCode: String = ""
    
    @objc var imageFrontCroped: UIImage = UIImage()
    @objc var hashImageFront: String = ""
    
    @objc var imageBackCroped: UIImage = UIImage()
    @objc var hashImageBack: String = ""
    
    @objc var imageFaceCroped: UIImage = UIImage()
    @objc var hashImageFace: String = ""
    
    @objc var imageFaceLeftCroped: UIImage = UIImage()
    @objc var hashImageFaceLeft: String = ""
    
    @objc var imageFaceRightCroped: UIImage = UIImage()
    @objc var hashImageFaceRight: String = ""
    
    @objc var imageFaceFarCroped: UIImage = UIImage()
    @objc var hashImageFaceFar: String = ""
    
    @objc var imageFaceNearCroped: UIImage = UIImage()
    @objc var hashImageFaceNear: String = ""
    
    @objc var urlRecordVideoDocument: NSURL = NSURL()
    @objc var urlRecordVideoScanQRCode: NSURL = NSURL()
    @objc var urlRecordVideoFace: NSURL = NSURL()
    
    @objc var clientSession: String = ""
    
    @IBOutlet weak var tableViewResult: UITableView!
    
    private var listInformation: [[String : Any]] = [[String : Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Thông tin mã QR
        if self.scanQRCodeResult != "" {
            self.listInformation.append(["title" : "Scan QR Code", "content" : self.scanQRCodeResult, "image" : UIImage(), "isVideo" : false])
        }
        
        // Thông tin OCR
        if self.ocrResult != "" {
            self.listInformation.append(["title" : "OCR", "content" : self.ocrResult, "image" : UIImage(), "isVideo" : false])
        }
        
        // Thông tin COMPARE FACE
        if self.compareFaceResult != "" {
            self.listInformation.append(["title" : "Compare face", "content" : self.compareFaceResult, "image" : UIImage(), "isVideo" : false])
        }
        
        // Thông tin LIVENESS FACE
        if self.livenessFaceResult != "" {
            self.listInformation.append(["title" : "Liveness Face", "content" : self.livenessFaceResult, "image" : UIImage(), "isVideo" : false])
        }
        
        // Thông tin VERIFY FACE
        if self.verifyFaceResult != "" {
            self.listInformation.append(["title" : "Verify Face", "content" : self.verifyFaceResult, "image" : UIImage(), "isVideo" : false])
        }
        
        // Thông tin MASK FACE
        if self.maskedFaceResult != "" {
            self.listInformation.append(["title" : "Masked Face", "content" : self.maskedFaceResult, "image" : UIImage(), "isVideo" : false])
        }
        
        // Thông tin LIVENESS FACE FRONT
        if self.livenessCardFrontResult != "" {
            self.listInformation.append(["title" : "Liveness Card Front", "content" : self.livenessCardFrontResult, "image" : UIImage(), "isVideo" : false])
        }
        
        // Thông tin LIVENESS FACE BACK
        if self.livenessCardBackResult != "" {
            self.listInformation.append(["title" : "Liveness Card Back", "content" : self.livenessCardBackResult, "image" : UIImage(), "isVideo" : false])
        }
        
        // Thông tin ADD FACE
        if self.addFaceResult != "" {
            self.listInformation.append(["title" : "Add Face", "content" : self.addFaceResult, "image" : UIImage(), "isVideo" : false])
        }
        
        // Thông tin SEARCH FACE
        if self.searchFaceResult != "" {
            self.listInformation.append(["title" : "Search Face", "content" : self.searchFaceResult, "image" : UIImage(), "isVideo" : false])
        }
        
        
        // Thông tin ẢNH MÃ QR
        if self.hashImageQRCode != "" || (self.imageQRCodeCroped.size.width != 0 && self.imageQRCodeCroped.size.height != 0) {
            self.listInformation.append(["title" : "Image QR Code", "content" : self.hashImageQRCode, "image" : self.imageQRCodeCroped, "isVideo" : false])
        }
        
        // Thông tin ẢNH MẶT TRƯỚC
        if self.hashImageFront != "" || (self.imageFrontCroped.size.width != 0 && self.imageFrontCroped.size.height != 0) {
            self.listInformation.append(["title" : "Image Front", "content" : self.hashImageFront, "image" : self.imageFrontCroped, "isVideo" : false])
        }
        
        // Thông tin ẢNH MẶT SAU
        if self.hashImageBack != "" || (self.imageBackCroped.size.width != 0 && self.imageBackCroped.size.height != 0) {
            self.listInformation.append(["title" : "Image Back", "content" : self.hashImageBack, "image" : self.imageBackCroped, "isVideo" : false])
        }
        
        // Thông tin ẢNH FACE THẲNG
        if self.hashImageFace != "" || (self.imageFaceCroped.size.width != 0 && self.imageFaceCroped.size.height != 0) {
            self.listInformation.append(["title" : "Image Face", "content" : self.hashImageFace, "image" : self.imageFaceCroped, "isVideo" : false])
        }
        
        // Thông tin ẢNH FACE TRÁI
        if self.hashImageFaceLeft != "" || (self.imageFaceLeftCroped.size.width != 0 && self.imageFaceLeftCroped.size.height != 0) {
            self.listInformation.append(["title" : "Image Face Left", "content" : self.hashImageFaceLeft, "image" : self.imageFaceLeftCroped, "isVideo" : false])
        }
        
        // Thông tin ẢNH FACE PHẢI
        if self.hashImageFaceRight != "" || (self.imageFaceRightCroped.size.width != 0 && self.imageFaceRightCroped.size.height != 0) {
            self.listInformation.append(["title" : "Image Face Right", "content" : self.hashImageFaceRight, "image" : self.imageFaceRightCroped, "isVideo" : false])
        }
        
        // Thông tin ẢNH FACE XA CẮT
        if self.hashImageFaceFar != "" || (self.imageFaceFarCroped.size.width != 0 && self.imageFaceFarCroped.size.height != 0) {
            self.listInformation.append(["title" : "Image Face Far", "content" : self.hashImageFaceFar, "image" : self.imageFaceFarCroped, "isVideo" : false])
        }
        
        // Thông tin ẢNH FACE GẦN CẮT
        if self.hashImageFaceNear != "" || (self.imageFaceNearCroped.size.width != 0 && self.imageFaceNearCroped.size.height != 0) {
            self.listInformation.append(["title" : "Image Face Near", "content" : self.hashImageFaceNear, "image" : self.imageFaceNearCroped, "isVideo" : false])
        }
        
        // Thông tin ĐƯỜNG DẪN RECORD DOCUMENT
        if self.urlRecordVideoDocument.path ?? "" != "" {
            self.listInformation.append(["title" : "Video Document", "content" : self.urlRecordVideoDocument, "image" : UIImage(), "isVideo" : true])
        }

        // Thông tin ĐƯỜNG DẪN RECORD SCAN QR
        if self.urlRecordVideoScanQRCode.path ?? "" != "" {
            self.listInformation.append(["title" : "Video Scan QR Code", "content" : self.urlRecordVideoScanQRCode, "image" : UIImage(), "isVideo" : true])
        }

        // Thông tin ĐƯỜNG DẪN RECORD FACE
        if self.urlRecordVideoFace.path ?? "" != "" {
            self.listInformation.append(["title" : "Video Face", "content" : self.urlRecordVideoFace, "image" : UIImage(), "isVideo" : true])
        }

        // Thông tin ĐƯỜNG DẪN RECORD FACE
        if self.clientSession != "" {
            self.listInformation.append(["title" : "Client Session", "content" : self.clientSession, "image" : UIImage(), "isVideo" : false])
        }

        
        self.title = "Hiển thị kết quả"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Đóng", style: .plain, target: self, action: #selector(self.closeViewController))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Copy All", style: .plain, target: self, action: #selector(self.actionCopyAll))


        // register customize cell (CheckinHistoryCell) is the children tableViewCheckinHistory
        self.tableViewResult.register(UINib(nibName: "ResultEkycCell", bundle: Bundle.main), forCellReuseIdentifier: "ResultEkycCell")
        self.tableViewResult.register(UINib(nibName: "ResultEkycHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "ResultEkycHeader")
        // setup tableView Checkin History
        self.tableViewResult.delegate = self
        self.tableViewResult.dataSource = self
        self.tableViewResult.backgroundColor = UIColor.white
        self.tableViewResult.separatorStyle = .none

    }
    

    // Called when the view is about to made visible. Default does nothing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Called when the view has been fully transitioned onto the screen. Default does nothing
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // Called after the view was dismissed, covered or otherwise hidden. Default does nothing
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    // Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    
    
    @objc private func closeViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func actionCopyAll() {
        // copy text
        var text = ""
        for information in self.listInformation {
            let title: String = information["title"] as? String ?? ""
            let content: String = information["content"] as? String ?? ""
            
            text = text + "\(title) = \(content)\n\n"
        }
        UIPasteboard.general.string = ""
        UIPasteboard.general.string = text
    }
    
    @objc private func actionPlayVideo(sender: UIButton) {
        
    }
    
    
    @objc private func actionCopy(sender: UIButton) {
        let tagView = sender.tag
        
        let item = self.listInformation[tagView]
        // let title: String = item["title"] as? String ?? ""
        let content: String = item["content"] as? String ?? ""
        
        UIPasteboard.general.string = ""
        UIPasteboard.general.string = content
    }

}

extension ResultEkycViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listInformation.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ResultEkycHeader") as! ResultEkycHeader
        headerView.backgroundColor = UIColor(red: 24.0/255.0, green: 214.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        headerView.contentView.backgroundColor = UIColor(red: 24.0/255.0, green: 214.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        
        let item = self.listInformation[section]
        let title: String = item["title"] as? String ?? ""
        let isVideo: Bool = item["isVideo"] as? Bool ?? false

        headerView.labelTitle.text = title
        headerView.labelTitle.textColor = UIColor(red: 20.0/255.0, green: 39.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        headerView.labelTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        headerView.buttonCopy.setTitleColor(UIColor(red: 20.0/255.0, green: 39.0/255.0, blue: 48.0/255.0, alpha: 1.0), for: .normal)
        headerView.buttonCopy.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        headerView.buttonCopy.tag = section
        if isVideo {
            headerView.buttonCopy.setTitle("Xem video", for: .normal)
            headerView.buttonCopy.addTarget(self, action: #selector(self.actionPlayVideo(sender:)), for: .touchUpInside)
        } else {
            headerView.buttonCopy.setTitle("Sao chép", for: .normal)
            headerView.buttonCopy.addTarget(self, action: #selector(self.actionCopy(sender:)), for: .touchUpInside)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultEkycCell", for: indexPath) as! ResultEkycCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.contentView.backgroundColor = UIColor.white
        
        let item = self.listInformation[indexPath.section]
        let content: String = item["content"] as? String ?? ""
        let image: UIImage = item["image"] as? UIImage ?? UIImage()
        let widthImage = image.size.width
        let heightImage = image.size.height
        if widthImage != 0 && heightImage != 0 {
            // hiển thị ảnh
            let widthImageView = UIScreen.main.bounds.size.width - 16.0
            let heightImageView = (widthImageView * heightImage) / widthImage
            cell.imageViewCapture.isHidden = false
            cell.imageViewCapture.image = image
            cell.widthImageView.constant = widthImageView
            cell.heightImageView.constant = heightImageView
        } else {
            // ẩn ảnh
            cell.imageViewCapture.isHidden = true
            cell.widthImageView.constant = 0.0
            cell.heightImageView.constant = 0.0
        }
        cell.labelContent.text = content
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
}
