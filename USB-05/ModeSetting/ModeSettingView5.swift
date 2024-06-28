//
//  ModeSettingView5.swift
//  USB-05
//
//  Created by 이요섭 on 6/26/24.
//

import SwiftUI
import CoreBluetooth

struct ModeSettingView5: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var locationManager = LocationManager()
    
//    @State private var Mode5OnTime: Date = UserDefaults.standard.object(forKey: "Mode5 OnTime") as? Date ?? Date()
//    @State private var Mode5OffTime: Date = UserDefaults.standard.object(forKey: "Mode5 OffTime") as? Date ?? Date()
    
    @State var Mode5OnTime = Date()
    @State var Mode5OffTime = Date()
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    VStack {
                        VStack {
                            Text("모드 5")
                                .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                .foregroundColor(.textLight)
                                .opacity(0.5)
                                .padding()
                            
                            Text("설정 시간 켜짐, 설정 시간 꺼짐")
                                .font(Font.custom("Pretendard", size: 24).weight(.bold))
                                .foregroundColor(.textLight)
                            
                            Text("1회 반복")
                                .font(Font.custom("Pretendard", size: 24).weight(.bold))
                                .foregroundColor(.textLight)
                            
                            HStack(alignment: .top, spacing: 4) {
                                HStack(spacing: 0) {
                                    Text("\(dateToOnTime(date:Mode5OnTime))")
                                        .font(Font.custom("Pretendard", size: 13).weight(.semibold))
                                        .lineSpacing(12)
                                        .foregroundColor(.textLight)
                                }
                                .padding(EdgeInsets(top:12, leading: 9, bottom: 12, trailing: 10))
                                .cornerRadius(8)
                                
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    Text("밤중")
                                        .font(Font.custom("Pretendard", size: 16).weight(.semibold))
                                        .lineSpacing(12)
                                        .foregroundColor(.textLight)
                                }
                                .padding(EdgeInsets(top:12, leading: 0, bottom: 12, trailing: 0)).opacity(0)
                                
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    Text("새벽")
                                        .font(Font.custom("Pretendard", size: 16).weight(.semibold))
                                        .lineSpacing(12)
                                        .foregroundColor(.textLight)
                                }
                                .padding(EdgeInsets(top:12, leading: 0, bottom: 12, trailing: 0)).opacity(0)
                                
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    Text("\(dateToOffTime(date:Mode5OffTime))")
                                        .font(Font.custom("Pretendard", size: 13).weight(.semibold))
                                        .lineSpacing(12)
                                        .foregroundColor(.textLight)
                                }
                                .padding(EdgeInsets(top:12, leading: 9, bottom: 12, trailing: 10))
                                .cornerRadius(8)
                            }
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .frame(maxWidth: .infinity)
                            .background(
                              LinearGradient(gradient: Gradient(colors: [Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(12)
                            .padding(EdgeInsets(top: 12, leading: 14, bottom: -6, trailing: 14))
                            
                            
                            HStack(alignment: .top, spacing: 0) {
                                VStack {}.frame(width: 2, height: 16).background(Color.urielDarkBlue)
                                
                                Spacer()
                                
                                VStack {}.frame(width: 2, height: 16).background(Color.urielPurple).opacity(0)
                                
                                Spacer()
                                
                                VStack {}.frame(width: 2, height: 16).background(Color.urielDarkBlue).opacity(0)
                                
                                Spacer()
                                
                                VStack {}.frame(width: 2, height: 16).background(Color.urielBlue)
                            }
                            .padding(EdgeInsets(top: 0, leading: 56, bottom: 0, trailing: 56))
                            .frame(maxWidth: .infinity)
                            
                            HStack(spacing: 2) {
                                VStack(spacing: 0) {
                                    Text("OFF")
                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                        .lineSpacing(12)
                                        .foregroundColor(.textLight)
                                        .opacity(0.50)
                                }
                                .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                .frame(height: 40)
                                
                                .cornerRadius(8)
                                HStack(spacing: 0) {
                                    Text("ON")
                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                        .lineSpacing(12)
                                        .foregroundColor(.black)
                                }
                                .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.98, green: 0.99, blue: 1))
                                .cornerRadius(8)
                                VStack(spacing: 0) {
                                    Text("OFF")
                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                        .lineSpacing(12)
                                        .foregroundColor(.textLight)
                                        .opacity(0.50)
                                }
                                .padding(EdgeInsets(top: 14, leading: 5, bottom: 14, trailing: 5))
                                .frame(height: 40)
                                
                                .cornerRadius(8)
                            }
                            .padding(EdgeInsets(top: 12, leading: 6, bottom: 12, trailing: 6))
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.13, green: 0.14, blue: 0.15))
                            .cornerRadius(12)
                            .padding(EdgeInsets(top: -12, leading: 14, bottom: 24, trailing: 14))
                        }
                        .background(Color.black)
                        
                        
                        VStack {
                            // 밤 중에 꺼지는 시간 (offTime2)
                            VStack(alignment: .leading) {
                                VStack {
                                    Text("1회 켜지는 시간")
                                        .font(Font.custom("Pretendard", size: 17).weight(.bold))
                                        .foregroundColor(.textLight)
                                }
                                
                                HStack {
                                    DatePicker("One Timer ON", selection: $Mode5OnTime, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(WheelDatePickerStyle())
                                        .labelsHidden()
                                        .frame(height: 100)
                                        .padding(8)
                                        .onAppear {
                                            Mode5OnTime = convertMinutesToDate(minutes: bluetoothManager.Mode5OnTime)
                                        }
                                    
                                    Text("꺼짐")
                                        .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                        .foregroundColor(.textLight)
                                        .opacity(0.5)
                                }
                                .padding(EdgeInsets(top: 40, leading: 12, bottom: 6, trailing: 12))
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                            .cornerRadius(24)
                            .padding()
                            
                            
                            Image(systemName: "arrow.down")
                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                .foregroundColor(.textLight)
                                .opacity(0.5)
                            
                            
                            // 새벽에 켜지는 시간 (onTime2)
                            VStack(alignment: .leading) {
                                VStack {
                                    Text("1회 꺼지는 시간")
                                        .font(Font.custom("Pretendard", size: 17).weight(.bold))
                                        .foregroundColor(.textLight)
                                }
                                
                                HStack {
                                    DatePicker("One Timer OFF", selection: $Mode5OffTime, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(WheelDatePickerStyle())
                                        .labelsHidden()
                                        .frame(height: 100)
                                        .padding(8)
                                        .onAppear {
                                            Mode5OffTime = convertMinutesToDate(minutes: bluetoothManager.Mode5OffTime)
                                        }
                                    
                                    Text("켜짐")
                                        .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                        .foregroundColor(.textLight)
                                        .opacity(0.5)
                                }
                                .padding(EdgeInsets(top: 40, leading: 12, bottom: 6, trailing: 12))
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                            .cornerRadius(24)
                            .padding()
                            
                            
                            Image(systemName: "arrow.down")
                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                .foregroundColor(.textLight)
                                .opacity(0.5)
                            
                            
                            HStack(spacing: 8) {
                                Button("취소") {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.22, green: 0.23, blue: 0.25))
                                .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                
                                Button("확인") {
                                    sendMode5Data()
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                .foregroundColor(.urielBlack)
                                .cornerRadius(12)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                        }
                        .background(Color.urielBlack)
                        .cornerRadius(24)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
                        }
                    }
                }
            }
        }
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
    
    func sendMode5Data() {
        if !bluetoothManager.bluetoothIsReady {
            print("시리얼이 준비되지 않음")
            return
        }
        
        let onTimeminutes = dateToMinutes(date: Mode5OnTime)
        let offTimeminutes = dateToMinutes(date: Mode5OffTime)
        // let onTimeData2 = onTime
        
        let onTimeresult: UInt16 = UInt16(onTimeminutes)
        let onTimeupperByte = UInt8(onTimeresult >> 8)
        let onTimelowerByte = UInt8(onTimeresult & 0x00FF)
        
        // let offTimeData2 = offTime
        
        let offTimeresult: UInt16 = UInt16(offTimeminutes)
        let offTimeupperByte = UInt8(offTimeresult >> 8)
        let offTimelowerByte = UInt8(offTimeresult & 0x00FF)
        
        if (onTimeminutes == offTimeminutes) {
            alertMessage = "ON/OFF 시간을 다르게 설정해주세요."
            showingAlert = true
            return
        }
        
        let CHECKSUM = 207 &+ 5 &+ onTimeupperByte &+ onTimelowerByte &+ offTimeupperByte &+ offTimelowerByte
        
        let packet: [UInt8] = [207, 5, 0, onTimeupperByte, onTimelowerByte, offTimeupperByte, offTimelowerByte, 0, 0, 0, 0, CHECKSUM, 13, 10]
    
        sendData()
        bluetoothManager.sendBytesToDevice(packet)
        // Change Label Text expression "success" for waiting
        // serialMessageLabel.text = "waiting msg from peripheral"
        alertMessage = "설정이 완료되었습니다"
        showingAlert = true
        
        UserDefaults.standard.set(Mode5OnTime, forKey: "Mode5 OnTime")
        UserDefaults.standard.set(Mode5OffTime, forKey: "Mode5 OffTime")
        UserDefaults.standard.set("모드 5, 설정 시간 ON/OFF, 1회 반복", forKey: "selectedMode")
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func dateToOnTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let formattedDate = formatter.string(from: Mode5OnTime)
        
        return formattedDate
    }
    
    func dateToOffTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let formattedDate = formatter.string(from: Mode5OffTime)
        
        return formattedDate
    }
    
    func dateToMinutes(date: Date) -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return hour * 60 + minute
    }
    
    func convertMinutesToDate(minutes: Int) -> Date {
        let hours = minutes / 60
        let minutes = minutes % 60
        var dateComponents = DateComponents()
        dateComponents.hour = hours
        dateComponents.minute = minutes
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents) ?? Date()
        return date
    }
    
    func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
}

