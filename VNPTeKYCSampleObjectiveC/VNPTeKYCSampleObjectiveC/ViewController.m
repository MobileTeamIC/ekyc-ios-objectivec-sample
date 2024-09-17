//
//  ViewController.m
//  VNPTeKYCSampleObjectiveC
//
//  Created by MinhMinhMinh on 17/09/2024.
//

#import "ViewController.h"
#import "VNPTeKYCSampleObjectiveC-Swift.h"
@import ICSdkEKYC;

@interface ViewController ()<ICEkycCameraDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UIButton *buttonFullEkyc;
@property (weak, nonatomic) IBOutlet UIButton *buttonOCR;
@property (weak, nonatomic) IBOutlet UIButton *buttonFace;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.labelTitle.text = @"Tích hợp SDK VNPT eKYC";
    
    [self.buttonFullEkyc setTitle:@"eKYC luồng đầy đủ" forState:UIControlStateNormal];
    [self.buttonFullEkyc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buttonFullEkyc.layer.cornerRadius = 6.0f;
    [self.buttonFullEkyc addTarget:self action:@selector(actionFullEkyc) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonOCR setTitle:@"Thực hiện OCR giấy tờ" forState:UIControlStateNormal];
    [self.buttonOCR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buttonOCR.layer.cornerRadius = 6.0f;
    [self.buttonOCR addTarget:self action:@selector(actionOCR) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonFace setTitle:@"Thực hiện kiểm tra khuôn mặt" forState:UIControlStateNormal];
    [self.buttonFace setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buttonFace.layer.cornerRadius = 6.0f;
    [self.buttonFace addTarget:self action:@selector(actionFace) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Nhập thông tin bộ mã truy cập. Lấy tại mục Quản lý Token https://ekyc.vnpt.vn/admin-dashboard/console/project-manager
    [ICEKYCSavedData shared].tokenId = [NSString string];
    [ICEKYCSavedData shared].tokenKey = [NSString string];
    [ICEKYCSavedData shared].authorization = [NSString string];
    
    // Hiển thị LOG các request được gọi trong SDK
    [ICEKYCSavedData shared].isPrintLogRequest = true;
    
}


// Phương thức thực hiện eKYC luồng đầy đủ bao gồm: Chụp ảnh giấy tờ và chụp ảnh chân dung
// Bước 1 - chụp ảnh giấy tờ
// Bước 2 - chụp ảnh chân dung xa gần
// Bước 3 - hiển thị kết quả
- (void) actionFullEkyc {
    ICEkycCameraViewController *objCamera = (ICEkycCameraViewController *)[ICEkycCameraRouter createModule];
    objCamera.cameraDelegate = self;
    
    // Giá trị này xác định phiên bản khi sử dụng Máy ảnh tại bước chụp ảnh chân dung luồng full. Mặc định là Normal ✓
    // - Normal: chụp ảnh chân dung 1 hướng
    // - ProOval: chụp ảnh chân dung xa gần
    objCamera.versionSdk = ProOval;
    
    // Giá trị xác định luồng thực hiện eKYC
    // - full: thực hiện eKYC đầy đủ các bước: chụp mặt trước, chụp mặt sau và chụp ảnh chân dung
    // - ocrFront: thực hiện OCR giấy tờ một bước: chụp mặt trước
    // - ocrBack: thực hiện OCR giấy tờ một bước: chụp mặt trước
    // - ocr: thực hiện OCR giấy tờ đầy đủ các bước: chụp mặt trước, chụp mặt sau
    // - face: thực hiện so sánh khuôn mặt với mã ảnh chân dung được truyền từ bên ngoài
    objCamera.flowType = full;
    
    // Giá trị này xác định kiểu giấy tờ để sử dụng:
    // - IdentityCard: Chứng minh thư nhân dân, Căn cước công dân
    // - IDCardChipBased: Căn cước công dân gắn Chip
    // - Passport: Hộ chiếu
    // - DriverLicense: Bằng lái xe
    // - MilitaryIdCard: Chứng minh thư quân đội
    objCamera.documentType = IdentityCard;
    
    // Giá trị này dùng để đảm bảo mỗi yêu cầu (request) từ phía khách hàng sẽ không bị thay đổi.
    objCamera.challengeCode = @"INNOVATIONCENTER";
    
    // Bật/Tắt Hiển thị màn hình hướng dẫn
    objCamera.isShowTutorial = true;
    
    // Bật/Tắt chức năng So sánh ảnh trong thẻ và ảnh chân dung
    objCamera.isEnableCompare = true;
    
    // Bật/Tắt chức năng kiểm tra che mặt
    objCamera.isCheckMaskedFace = true;
    
    // Lựa chọn chức năng kiểm tra ảnh chân dung chụp trực tiếp (liveness face)
    // - NoneCheckFace: Không thực hiện kiểm tra ảnh chân dung chụp trực tiếp hay không
    // - IBeta: Kiểm tra ảnh chân dung chụp trực tiếp hay không iBeta (phiên bản hiện tại)
    // - Standard: Kiểm tra ảnh chân dung chụp trực tiếp hay không Standard (phiên bản mới)
    objCamera.checkLivenessFace = IBeta;
    
    // Bật/Tắt chức năng kiểm tra ảnh giấy tờ chụp trực tiếp (liveness card)
    objCamera.isCheckLivenessCard = true;
    
    // Lựa chọn chế độ kiểm tra ảnh giấy tờ ngay từ SDK
    // - None: Không thực hiện kiểm tra ảnh khi chụp ảnh giấy tờ
    // - Basic: Kiểm tra sau khi chụp ảnh
    // - MediumFlip: Kiểm tra ảnh hợp lệ trước khi chụp (lật giấy tờ thành công → hiển thị nút chụp)
    // - Advance: Kiểm tra ảnh hợp lệ trước khi chụp (hiển thị nút chụp)
    objCamera.validateDocumentType = Basic;
    
    // Bật chức năng hiển thị nút bấm "Bỏ qua hướng dẫn" tại các màn hình hướng dẫn bằng video
    objCamera.isEnableGotIt = true;
    
    // Ngôn ngữ sử dụng trong SDK
    objCamera.languageSdk = @"icekyc_vi";
    
    // Bật/Tắt Hiển thị ảnh thương hiệu
    objCamera.isShowTrademark = true;
    
    objCamera.modalPresentationStyle = UIModalPresentationFullScreen;
    objCamera.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:objCamera animated:YES completion:nil];
}


// Phương thức thực hiện eKYC luồng "Chụp ảnh giấy tờ"
// Bước 1 - chụp ảnh giấy tờ
// Bước 2 - hiển thị kết quả
- (void) actionOCR {
    ICEkycCameraViewController *objCamera = (ICEkycCameraViewController *)[ICEkycCameraRouter createModule];
    objCamera.cameraDelegate = self;
    
    // Giá trị xác định luồng thực hiện eKYC
    // - full: thực hiện eKYC đầy đủ các bước: chụp mặt trước, chụp mặt sau và chụp ảnh chân dung
    // - ocrFront: thực hiện OCR giấy tờ một bước: chụp mặt trước
    // - ocrBack: thực hiện OCR giấy tờ một bước: chụp mặt trước
    // - ocr: thực hiện OCR giấy tờ đầy đủ các bước: chụp mặt trước, chụp mặt sau
    // - face: thực hiện so sánh khuôn mặt với mã ảnh chân dung được truyền từ bên ngoài
    objCamera.flowType = ocr;
    
    // Giá trị này xác định kiểu giấy tờ để sử dụng:
    // - IdentityCard: Chứng minh thư nhân dân, Căn cước công dân
    // - IDCardChipBased: Căn cước công dân gắn Chip
    // - Passport: Hộ chiếu
    // - DriverLicense: Bằng lái xe
    // - MilitaryIdCard: Chứng minh thư quân đội
    objCamera.documentType = IdentityCard;
    
    // Giá trị này dùng để đảm bảo mỗi yêu cầu (request) từ phía khách hàng sẽ không bị thay đổi.
    objCamera.challengeCode = @"INNOVATIONCENTER";
    
    // Bật/Tắt Hiển thị màn hình hướng dẫn
    objCamera.isShowTutorial = true;
    
    // Bật/Tắt chức năng kiểm tra ảnh giấy tờ chụp trực tiếp (liveness card)
    objCamera.isCheckLivenessCard = true;
    
    // Lựa chọn chế độ kiểm tra ảnh giấy tờ ngay từ SDK
    // - None: Không thực hiện kiểm tra ảnh khi chụp ảnh giấy tờ
    // - Basic: Kiểm tra sau khi chụp ảnh
    // - MediumFlip: Kiểm tra ảnh hợp lệ trước khi chụp (lật giấy tờ thành công → hiển thị nút chụp)
    // - Advance: Kiểm tra ảnh hợp lệ trước khi chụp (hiển thị nút chụp)
    objCamera.validateDocumentType = Basic;
    
    // Ngôn ngữ sử dụng trong SDK
    objCamera.languageSdk = @"icekyc_vi";
    
    // Bật/Tắt Hiển thị ảnh thương hiệu
    objCamera.isShowTrademark = true;
    
    objCamera.modalPresentationStyle = UIModalPresentationFullScreen;
    objCamera.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:objCamera animated:YES completion:nil];
}


// Phương thức thực hiện eKYC luồng đầy đủ bao gồm: Chụp ảnh giấy tờ và chụp ảnh chân dung
// Bước 1 - chụp ảnh chân dung xa gần
// Bước 2 - hiển thị kết quả
- (void) actionFace {
    ICEkycCameraViewController *objCamera = (ICEkycCameraViewController *)[ICEkycCameraRouter createModule];
    objCamera.cameraDelegate = self;
    
    // Giá trị này xác định phiên bản khi sử dụng Máy ảnh tại bước chụp ảnh chân dung luồng full. Mặc định là Normal ✓
    // - Normal: chụp ảnh chân dung 1 hướng
    // - ProOval: chụp ảnh chân dung xa gần
    objCamera.versionSdk = ProOval;
    
    // Giá trị xác định luồng thực hiện eKYC
    // - full: thực hiện eKYC đầy đủ các bước: chụp mặt trước, chụp mặt sau và chụp ảnh chân dung
    // - ocrFront: thực hiện OCR giấy tờ một bước: chụp mặt trước
    // - ocrBack: thực hiện OCR giấy tờ một bước: chụp mặt trước
    // - ocr: thực hiện OCR giấy tờ đầy đủ các bước: chụp mặt trước, chụp mặt sau
    // - face: thực hiện so sánh khuôn mặt với mã ảnh chân dung được truyền từ bên ngoài
    objCamera.flowType = face;
    
    // Giá trị này dùng để đảm bảo mỗi yêu cầu (request) từ phía khách hàng sẽ không bị thay đổi.
    objCamera.challengeCode = @"INNOVATIONCENTER";
    
    // Bật/Tắt Hiển thị màn hình hướng dẫn
    objCamera.isShowTutorial = true;
    
    // Bật/[Tắt] chức năng So sánh ảnh trong thẻ và ảnh chân dung
    objCamera.isEnableCompare = false;
    
    // Bật/Tắt chức năng kiểm tra che mặt
    objCamera.isCheckMaskedFace = true;
    
    // Lựa chọn chức năng kiểm tra ảnh chân dung chụp trực tiếp (liveness face)
    // - NoneCheckFace: Không thực hiện kiểm tra ảnh chân dung chụp trực tiếp hay không
    // - IBeta: Kiểm tra ảnh chân dung chụp trực tiếp hay không iBeta (phiên bản hiện tại)
    // - Standard: Kiểm tra ảnh chân dung chụp trực tiếp hay không Standard (phiên bản mới)
    objCamera.checkLivenessFace = IBeta;
    
    // Bật chức năng hiển thị nút bấm "Bỏ qua hướng dẫn" tại các màn hình hướng dẫn bằng video
    objCamera.isEnableGotIt = false;
    
    
    // Ngôn ngữ sử dụng trong SDK
    objCamera.languageSdk = @"icekyc_vi";
    
    // Bật/Tắt Hiển thị ảnh thương hiệu
    objCamera.isShowTrademark = true;
    
    objCamera.modalPresentationStyle = UIModalPresentationFullScreen;
    objCamera.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:objCamera animated:YES completion:nil];
}



- (void)icEkycGetResult {
    
    // Thông tin bóc tách OCR
    NSString *ocrResult = [ICEKYCSavedData shared].ocrResult;
    // Kết quả kiểm tra giấy tờ chụp trực tiếp (Liveness Card) mặt trước
    NSString *livenessCardFrontResult = [ICEKYCSavedData shared].livenessCardFrontResult;
    // Kết quả kiểm tra giấy tờ chụp trực tiếp (Liveness Card) mặt sau
    NSString *livenessCardBackResult = [ICEKYCSavedData shared].livenessCardBackResult;
    
    // Dữ liệu thực hiện SO SÁNH khuôn mặt (lấy từ mặt trước ảnh giấy tờ hoặc ảnh thẻ)
    NSString *compareFaceResult = [ICEKYCSavedData shared].compareFaceResult;
    
    // Dữ liệu kiểm tra ảnh CHÂN DUNG chụp trực tiếp hay không
    NSString *livenessFaceResult = [ICEKYCSavedData shared].livenessFaceResult;
    
    // Dữ liệu XÁC THỰC ảnh CHÂN DUNG và SỐ GIẤY TỜ
    NSString *verifyFaceResult = [ICEKYCSavedData shared].verifyFaceResult;
    
    // Dữ liệu kiểm tra ảnh CHÂN DUNG có bị che mặt hay không
    NSString *maskedFaceResult = [ICEKYCSavedData shared].maskedFaceResult;
    
    
    // Ảnh [chụp giấy tờ mặt trước] đã cắt được trả ra để ứng dụng hiển thị
    UIImage *imageFrontCroped = [ICEKYCSavedData shared].imageCropedFront;
    
    // Mã ảnh giấy tờ mặt trước sau khi tải lên máy chủ
    NSString *hashImageFront = [ICEKYCSavedData shared].hashImageFront;
    
    // Đường dẫn Ảnh đầy đủ khi chụp giấy tờ mặt trước
    NSURL *pathImageFront = [ICEKYCSavedData shared].pathImageFront;
    
    // Đường dẫn Ảnh [chụp giấy tờ mặt trước] đã cắt được trả ra để ứng dụng hiển thị
    NSURL *pathImageCropedFront = [ICEKYCSavedData shared].pathImageCropedFront;
    
    // Ảnh [chụp giấy tờ mặt sau] đã cắt được trả ra để ứng dụng hiển thị
    UIImage *imageBackCroped = [ICEKYCSavedData shared].imageCropedBack;
    
    // Mã ảnh giấy tờ mặt sau sau khi tải lên máy chủ
    NSString *hashImageBack = [ICEKYCSavedData shared].hashImageBack;
    
    // Đường dẫn Ảnh đầy đủ khi chụp giấy tờ mặt sau
    NSURL *pathImageBack = [ICEKYCSavedData shared].pathImageBack;
    
    // Đường dẫn Ảnh [chụp giấy tờ mặt sau] đã cắt được trả ra để ứng dụng hiển thị
    NSURL *pathImageCropedBack = [ICEKYCSavedData shared].pathImageCropedBack;
    
    // Ảnh chân dung chụp xa đã cắt được trả ra để ứng dụng hiển thị
    UIImage *imageFaceFarCroped = [ICEKYCSavedData shared].imageCropedFaceFar;
    // Mã ảnh chân dung chụp xa sau khi tải lên máy chủ
    NSString *hashImageFaceFar = [ICEKYCSavedData shared].hashImageFar;
    
    // Ảnh chân dung chụp gần đã cắt được trả ra để ứng dụng hiển thị
    UIImage *imageFaceNearCroped = [ICEKYCSavedData shared].imageCropedFaceNear;
    // Mã ảnh chân dung chụp gần sau khi tải lên máy chủ
    NSString *hashImageFaceNear = [ICEKYCSavedData shared].hashImageNear;
    
    // Dữ liệu để xác định cách giao dịch (yêu cầu) cùng nằm trong cùng một phiên
    NSString *clientSessionResult = [ICEKYCSavedData shared].clientSessionResult;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ResultEkycViewController *viewShowResult = [storyboard instantiateViewControllerWithIdentifier:@"ResultEkyc"];
        
        // Thông tin Giấy tờ
        viewShowResult.ocrResult = ocrResult;
        viewShowResult.livenessCardFrontResult = livenessCardFrontResult;
        viewShowResult.livenessCardBackResult = livenessCardBackResult;
        
        // Thông tin khuôn mặt
        viewShowResult.compareFaceResult = compareFaceResult;
        viewShowResult.livenessFaceResult = livenessFaceResult;
        viewShowResult.verifyFaceResult = verifyFaceResult;
        viewShowResult.maskedFaceResult = maskedFaceResult;
        
        // Ảnh giấy tờ Mặt trước
        viewShowResult.imageFrontCroped = imageFrontCroped;
        viewShowResult.hashImageFront = hashImageFront;
        
        // Ảnh giấy tờ Mặt sau
        viewShowResult.imageBackCroped = imageBackCroped;
        viewShowResult.hashImageBack = hashImageBack;
        
        // Ảnh chân dung xa
        viewShowResult.imageFaceFarCroped = imageFaceFarCroped;
        viewShowResult.hashImageFaceFar = hashImageFaceFar;
        
        // Ảnh chân dung gần
        viewShowResult.imageFaceNearCroped = imageFaceNearCroped;
        viewShowResult.hashImageFaceNear = hashImageFaceNear;
        
        viewShowResult.clientSession = clientSessionResult;
        //
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewShowResult];
        navigationController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:navigationController animated:YES completion:nil];
    });
}


@end
