//
//  YD_ProgressHUD.swift
//  YD_ProgressHUD
//
//  Created by alyadan on 2016/10/12.
//  Copyright © 2016年 alyadan. All rights reserved.
//

import Foundation
import SVProgressHUD

public enum ShowType {
    case info
    case success
    case error
    case progress
}

public protocol YD_ProgressHUDType {
    
    func showMessage(showType:ShowType, message:String)
    
    func showProgress(progress:Float, message:String)
    
    func hiddenHud()
}

public class YD_HUDCenter{
    
    
    public static let share = YD_HUDCenter()
    
    
    public let svpHud = SVPHud()
    
    private init(){}
}

public class SVPHud : YD_ProgressHUDType {
    
    public func hiddenHud() {
        runInMainQuequ {
            SVProgressHUD.dismiss()
        }
    }
    
    
    public func showMessage(showType: ShowType, message: String) {
        
        runInMainQuequ {
            switch showType {
            case .info:
                SVProgressHUD.showInfo(withStatus: message)
            case .success:
                SVProgressHUD.showSuccess(withStatus: message)
            case .error:
                SVProgressHUD.showError(withStatus: message)
            case .progress:
                SVProgressHUD.show(withStatus: message)
            }
        }
    }
    
    public func showProgress(progress: Float, message: String) {
        runInMainQuequ {
            SVProgressHUD.showProgress(progress, status: message)
        }
    }

    
    init(){
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
      
    }
    
    
}

func runInMainQuequ(runBlock:(() -> Void)?){
    guard let runner = runBlock else {
        return
    }
    
    if Thread.isMainThread {
        runner()
    }else{
        DispatchQueue.main.async {
            runner()
        }
    }
}
