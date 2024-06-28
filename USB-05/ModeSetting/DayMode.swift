//
//  DayMode.swift
//  USB-05
//
//  Created by 이요섭 on 6/26/24.
//

import SwiftUI
import CoreBluetooth

struct BitSet {
    private(set) var value: UInt8 {
        didSet {
            UserDefaults.standard.set(value, forKey: "selectedDays")
        }
    }
    
    init() {
        self.value = UInt8(UserDefaults.standard.integer(forKey: "selectedDays"))
        if self.value == 0 {
            self.value = 127
        }
    }
    
    mutating func set(day: Int) {
        value |= (1 << day)
    }

    mutating func clear(day: Int) {
        value &= ~(1 << day)
    }

    func isSet(day: Int) -> Bool {
        return (value & (1 << day)) != 0
    }
}

struct DayMode: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    @StateObject private var locationManager = LocationManager()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var days = BitSet()
    @State private var showingAlert = false
    @State private var pendingIndex: Int?
    @State private var pendingValue: Bool = false
    @State private var alertMessage = ""
    
    let dayNames = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        ZStack {
            Color.urielBlack.ignoresSafeArea()
            
            VStack {
                Text("요일 선택")
                    .font(Font.custom("Pretendard", size: 20).weight(.bold))
                    .foregroundColor(.textLight)
                //    .padding()
                
                ScrollView {
                    ForEach(dayNames.indices, id: \.self) { index in
                    VStack (spacing: 10) {
                        HStack (spacing: 50){
                            VStack (alignment: .leading) {
                                
                                    Toggle(isOn: Binding(
                                        get: { self.days.isSet(day: index) },
                                        set: { isOn in
                                            if isOn {
                                                self.days.set(day: index)
                                                self.showingAlert = true
                                            } else {
                                                self.days.clear(day: index)
                                            }
                                        }
                                    )) {
                                        Text(self.dayNames[index])
                                            .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                            .foregroundColor(.textLight)
                                            .tracking(1)
                                            .padding()
                                            .cornerRadius(12)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    .frame(maxWidth: .infinity)
                    .background(Color.bgLightDark)
                    .cornerRadius(12)
                    .padding()
                    
                    // .padding(.top, -15)
                    
                    Button(action: {
                        updateBluetoothDevice()
                    }) {
                        HStack {
                            Text("요일 설정하기")
                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                        }
                        .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.bottom)
                    }
                    .padding()
                }
            }

        }
    }
    
    func updateBluetoothDevice() {
        print(String(format: "Selected days in binary: %08b", days.value))
        print(String(format: "Selected days in hex: %02X", days.value))
        print(days.value)
        
        if !bluetoothManager.bluetoothIsReady {
            print("시리얼이 준비되지 않음")
            return
        }
        
        let daysData = days.value
        
        let CHECKSUM: UInt8 = 207 &+ 8 &+ daysData
        print(CHECKSUM)
        
        let packet: [UInt8] = [207, 8, daysData, 0, 0, 0, 0, 0, 0, 0, 0, CHECKSUM, 13, 10]
        print(packet)
        
        sendData()
        bluetoothManager.sendBytesToDevice(packet)
        alertMessage = "요일 설정이 완료되었습니다."
        showingAlert = true
        
        presentationMode.wrappedValue.dismiss()
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
    }
}
