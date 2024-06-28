//
//  SettingView.swift
//  USB-05
//
//  Created by 이요섭 on 6/26/24.
//

import SwiftUI
import CoreBluetooth


struct SettingView: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    @ObservedObject private var locationManager = LocationManager()
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var navigateToLanding: Bool
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isTimeLoading = false
    @State private var isModeLoading = false
    
    var selectedMode: String {
        UserDefaults.standard.string(forKey: "selectedMode") ?? "선택 안 됨"
    }
    
    var body: some View {
        ZStack {
            Color.urielBlack.ignoresSafeArea()
            
            VStack (spacing: 20) {
                if isModeLoading {
                    ProgressView("로딩 중...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    
                        
                    VStack {
                        
                        Text("모드 선택하기")
                            .font(Font.custom("Pretendard", size: 20).weight(.bold))
                            .lineSpacing(8)
                            .foregroundColor(.textLight)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                                
                                
                        Button(action: {
                            isModeLoading = true
                            sendData()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                requestData()
                            }                            
                            isModeLoading = false
                        }) {
                            HStack {
                                Text("1. 모드 선택하기")
                                    .font(Font.custom("Pretendard", size: 22).weight(.bold))
                            }
                            .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.bottom)
                        }
                        // .padding()
                    }
                                            
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                    .cornerRadius(24)
                    .padding()
                    .padding(.top, -20)
                }
                
                    if isTimeLoading {
                        ProgressView("로딩 중...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .textLight))
                            .padding()
                    } else {
                        VStack {
                            Text("기기의 시간과 위치정보를 재설정")
                                .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                .lineSpacing(8)
                                .foregroundColor(.textLight)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                            
                            Button (action: {
                                sendTimeData()
                                isTimeLoading = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                    disconnectDevice()
                                    isTimeLoading = false
                                }
                            }){
                                HStack {
                                    Text("2. 시간 재설정하기")
                                        .font(Font.custom("Pretendard", size: 22).weight(.bold))
                                }
                                .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(12)
                                .padding(.bottom)
                            }
                            //.padding()
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                        .cornerRadius(24)
                        .padding()
                        .padding(.top, -20)
                    }
            }
            
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
    }
    
    func convertToUInt8Pair(value: Int) -> (upper: UInt8, lower: UInt8) {
        let upper = UInt8(value / 256)
        let lower = UInt8(value % 256)
        return (upper, lower)
    }
    
    func sendTimeData() {
        if !bluetoothManager.bluetoothIsReady {
            print("기기가 연결되지 않음")
            alertMessage = "블루투스가 준비되지 않았습니다."
            showingAlert = true
            return
        }
        
        let date = Date()
        let yform = DateFormatter()
        let mform = DateFormatter()
        let dform = DateFormatter()
        let dayform = DateFormatter()
        let hhform = DateFormatter()
        let minform = DateFormatter()
        let ssform = DateFormatter()
        
        yform.dateFormat = "yyyy"
        mform.dateFormat = "MM"
        dform.dateFormat = "dd"
        dayform.dateFormat = "ccc"
        hhform.dateFormat = "HH"
        minform.dateFormat = "mm"
        ssform.dateFormat = "ss"
        
        let yy = yform.string(from: date)
        let mm = mform.string(from: date)
        let dd = dform.string(from: date)
        let day = dayform.string(from: date)
        print(day)
        let hh = hhform.string(from: date)
        let minute = minform.string(from: date)
        let ss = ssform.string(from: date)
        
        let YY = UInt8(Int(yy)! - 2000)
        print(YY)
        let MM = UInt8(Int(mm)!)
        print(MM)
        let DD = UInt8(Int(dd)!)
        print(DD)
        let DAY: UInt8 = {
            switch day {
            case "월": return 1
            case "화": return 2
            case "수": return 3
            case "목": return 4
            case "금": return 5
            case "토": return 6
            case "일": return 7
            default: return 0 // 잘못된 요일 값 처리
            }
        }()
        let HH = UInt8(Int(hh)!)
        let MIN = UInt8(Int(minute)!)
        let SS = UInt8(Int(ss)!)
        
        
        let LAT = locationManager.formattedLAT
        let LNG = locationManager.formattedLNG
        
        let bigLAT: Int16 = Int16(LAT)
        let bigLNG: Int16 = Int16(LNG)
        
        let upperLAT = UInt8(bigLAT >> 8)
        let lowerLAT = UInt8(bigLAT & 0x00FF)
        
        let upperLNG = UInt8(bigLNG >> 8)
        let lowerLNG = UInt8(bigLNG & 0x00FF)
        
        let _: Int16 = 0
        let _: Int16 = 0
               
        let CHECKSUM = 175 &+ YY &+ MM &+ DD &+ DAY &+ HH &+ MIN &+ SS &+ upperLAT &+ lowerLAT &+ upperLNG &+ lowerLNG &+ 5 &+ 70
        print(DAY)
        print(CHECKSUM)
        
        let packet: [UInt8] = [175, YY, MM, DD, DAY, HH, MIN, SS, upperLAT, lowerLAT, upperLNG, lowerLNG, 5, 70, CHECKSUM, 13, 10]
        print(packet)
        bluetoothManager.sendBytesToDevice(packet)
        
        alertMessage = "시간 재설정이 완료되었습니다"
        showingAlert = true
        
        presentationMode.wrappedValue.dismiss()
        navigateToLanding = false
    }
    
    func disconnectDevice () {
        if !bluetoothManager.bluetoothIsReady {
            print("블루투스가 연결되지 않았습니다.")
            return
        }
        bluetoothManager.disconnectDevice()
    }
    
    func requestData() {
        if !bluetoothManager.bluetoothIsReady {
            print("기기가 연결되지 않음")
            alertMessage = "블루투스가 준비되지 않았습니다."
            showingAlert = true
            return
        }
        
        let CHECKSUM: UInt8 = 207
        
        let packet: [UInt8] = [207, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, CHECKSUM, 13, 10]
        
        print(packet)
        bluetoothManager.sendBytesToDevice(packet)
    }
    
    func sendData() {
        if !bluetoothManager.bluetoothIsReady {
            print("기기가 연결되지 않음")
            alertMessage = "블루투스가 준비되지 않았습니다."
            showingAlert = true
            return
        }
        
        let date = Date()
        let yform = DateFormatter()
        let mform = DateFormatter()
        let dform = DateFormatter()
        let dayform = DateFormatter()
        let hhform = DateFormatter()
        let minform = DateFormatter()
        let ssform = DateFormatter()
        
        yform.dateFormat = "yyyy"
        mform.dateFormat = "MM"
        dform.dateFormat = "dd"
        dayform.dateFormat = "ccc"
        hhform.dateFormat = "HH"
        minform.dateFormat = "mm"
        ssform.dateFormat = "ss"
        
        let yy = yform.string(from: date)
        let mm = mform.string(from: date)
        let dd = dform.string(from: date)
        let day = dayform.string(from: date)
        print(day)
        let hh = hhform.string(from: date)
        let minute = minform.string(from: date)
        let ss = ssform.string(from: date)
            
            
        // 시리얼의 delegate를 SerialViewController로 설정합니다.
        //serial.delegate = self
        
        let YY = UInt8(Int(yy)! - 2000)
        print(YY)
        let MM = UInt8(Int(mm)!)
        print(MM)
        let DD = UInt8(Int(dd)!)
        print(DD)
        let DAY: UInt8 = {
            switch day {
            case "월": return 1
            case "화": return 2
            case "수": return 3
            case "목": return 4
            case "금": return 5
            case "토": return 6
            case "일": return 7
            default: return 0 // 잘못된 요일 값 처리
            }
        }()
        let HH = UInt8(Int(hh)!)
        let MIN = UInt8(Int(minute)!)
        let SS = UInt8(Int(ss)!)
        
        
        let LAT = locationManager.formattedLAT
        let LNG = locationManager.formattedLNG
        
        let bigLAT: Int16 = Int16(LAT)
        let bigLNG: Int16 = Int16(LNG)
        
        let upperLAT = UInt8(bigLAT >> 8)
        let lowerLAT = UInt8(bigLAT & 0x00FF)
        
        let upperLNG = UInt8(bigLNG >> 8)
        let lowerLNG = UInt8(bigLNG & 0x00FF)
        
        let _: Int16 = 0
        let _: Int16 = 0
               
        let CHECKSUM = 175 &+ YY &+ MM &+ DD &+ DAY &+ HH &+ MIN &+ SS &+ upperLAT &+ lowerLAT &+ upperLNG &+ lowerLNG &+ 5 &+ 70
        print(DAY)
        print(CHECKSUM)
        
        let packet: [UInt8] = [175, YY, MM, DD, DAY, HH, MIN, SS, upperLAT, lowerLAT, upperLNG, lowerLNG, 5, 70, CHECKSUM, 13, 10]
        print(packet)
        bluetoothManager.sendBytesToDevice(packet)
        
        alertMessage = "기기 설정이 완료되었습니다"
        showingAlert = true
        
        presentationMode.wrappedValue.dismiss()
        navigateToLanding = true
    }
}

