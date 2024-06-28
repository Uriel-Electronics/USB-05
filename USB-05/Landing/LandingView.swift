//
//  LandingView.swift
//  USB-05
//
//  Created by 이요섭 on 6/26/24.
//

import SwiftUI
import CoreBluetooth

struct LandingView: View {
    @ObservedObject var bluetoothManager = BluetoothManager()
    @StateObject private var locationManager = LocationManager()
    @ObservedObject var timerViewModel = TimerViewModel()
    @EnvironmentObject var timeManager: TimeManager
    @Binding var navigateToLanding: Bool
    
    @State private var currentDate = Date()
    
    @State private var emergenyTimer: Timer? = nil
    @State private var timeRemaining = 3600 // 초 단위로 초기 설정 (01:00:00)
    @State private var lastBackgroundTime: Date?
    @Environment(\.scenePhase) private var scenePhase
    @State private var timerRunning = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    // @State private var selectedModeValue: String?
    @State private var selectedDate = Date()
    @State private var selectedDaysValue: UInt8 = 0
    @State private var dayNames: [String] = []
    
    @State var Mode5OnTime: Date = Date()
    @State var Mode5OffTime: Date = Date()

    @State private var Mode6OnTime: Date = Date()
    @State private var Mode6OffTime: Date = Date()
    @State private var Mode6OnTime2: Date = Date()
    @State private var Mode6OffTime2: Date = Date()
    
    @State private var isLoading: Bool = false

    // power on/off
    @State private var powerOnOff = true
    
    let allDaysNames = ["월", "화", "수", "목", "금", "토", "일"]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var selectedMode: String {
        UserDefaults.standard.string(forKey: "selectedMode") ?? "선택 안 됨"
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
            
        formatter.dateFormat = "yyyy년 M월 d일 EEEE" //
        formatter.locale = Locale(identifier: "ko_KR") // 사용자의 현재 로케일 설정을 사용
        return formatter
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "a hh:mm:ss"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    if !navigateToLanding {
                        MainView()
                    }
                    else {
                        Color.urielBlack.ignoresSafeArea()
                        
                        ScrollView {
                            VStack() {
                                HStack {
                                    Text("Uriel")
                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                        .foregroundColor(.textLight)
                                        .opacity(0)
                                    
                                    Spacer()
                                    
                                    Text(loadDeviceName(uuidString: bluetoothManager.connectedDeviceIdentifier) ?? "USB-05")
                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                        .foregroundColor(.textLight)
                                    
                                    Spacer()
                                    
                                    NavigationLink (destination:PeripheralSettingView(bluetoothManager : bluetoothManager, navigateToLanding: $navigateToLanding)) {
                                        Image(systemName: "gearshape.fill")
                                            .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                            .foregroundColor(.textLight)
                                    }
                                    
                                }
                                .padding()
                                
                                VStack {
                                    Text(dateFormatter.string(from: timeManager.currentDate))
                                        .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                        .foregroundColor(.textLight)
                                        .onReceive(timer) { _ in
                                            currentDate = Date()
                                        }
                                        .padding(.top, 8)
                                    
                                    Text(timeFormatter.string(from: timeManager.currentDate))
                                        .font(Font.custom("Pretendard", size: 28).weight(.bold))
                                        .lineSpacing(28)
                                        .foregroundColor(.textLight)
                                        .onReceive(timer) { input in
                                            currentDate = input
                                        }
                                        .padding(.top, 2)
                                        .padding(.bottom)
                                    
                                    HStack {
                                        HStack {
                                            Text("일출")
                                                .font(Font.custom("Pretendard", size: 15).weight(.bold))
                                                .lineSpacing(12)
                                                .foregroundColor(.textLight)
                                                .opacity(0.70)
                                            
                                            Text(locationManager.sunrise)
                                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                                .lineSpacing(12)
                                                .foregroundColor(.textLight)
                                                .padding(.horizontal)
                                        }
                                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 20))
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 1, green: 1, blue: 1).opacity(0.15))
                                        .cornerRadius(12)
                                        
                                        HStack {
                                            Text("일몰")
                                                .font(Font.custom("Pretendard", size: 15).weight(.bold))
                                                .lineSpacing(12)
                                                .foregroundColor(.textLight)
                                                .opacity(0.70)
                                            
                                            Text(locationManager.sunset)
                                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                                .lineSpacing(12)
                                                .foregroundColor(.textLight)
                                                .padding(.horizontal)
                                        }
                                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 1, green: 1, blue: 1).opacity(0.15))
                                        .cornerRadius(12)
                                        
                                    }
                                    
                                    HStack {
                                        HStack {
                                            Text("위도")
                                                .font(Font.custom("Pretendard", size: 15).weight(.bold))
                                                .lineSpacing(12)
                                                .foregroundColor(.textLight)
                                                .opacity(0.70)
                                            
                                            Text(locationManager.latitude)
                                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                                .lineSpacing(12)
                                                .foregroundColor(.textLight)
                                                .padding(.horizontal)
                                        }
                                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 20))
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 1, green: 1, blue: 1).opacity(0.15))
                                        .cornerRadius(12)
                                        .padding(.top, 6)
                                        HStack {
                                            Text("경도")
                                                .font(Font.custom("Pretendard", size: 15).weight(.bold))
                                                .lineSpacing(12)
                                                .foregroundColor(.textLight)
                                                .opacity(0.70)
                                            
                                            Text(locationManager.longitude)
                                                .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                                .lineSpacing(12)
                                                .foregroundColor(.textLight)
                                                .padding(.horizontal)
                                        }
                                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 1, green: 1, blue: 1).opacity(0.15))
                                        .cornerRadius(12)
                                        .padding(.top, 6)
                                        
                                    }
                                    .padding(.bottom, 6)
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.52, blue: 1), Color(red: 0.34, green: 0.76, blue: 1)]), startPoint: .top, endPoint: .bottom)
                                )
                                .cornerRadius(24)
                                .padding()
                                
                                
                                if bluetoothManager.powerOn {
                                    // 모드 선택
                                    NavigationLink (destination: ModeView(bluetoothManager: bluetoothManager)) {
                                        VStack(spacing:20) {
                                            HStack (spacing: 50) {
                                                VStack (alignment: .leading) {
                                                    HStack {
                                                        Text("모드 선택")
                                                            .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.8)
                                                        
                                                        Spacer()
                                                        
                                                        Image(systemName: "chevron.right")
                                                            .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                            .foregroundColor(.textLight)
                                                    }
                                                    
                                                    if bluetoothManager.modeNum == 1 {
                                                        Text("모드 1, 일몰 켜짐, 일출 꺼짐")
                                                            .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                                            .foregroundColor(.textLight)
                                                            .padding(.top, 12)
                                                    } else if (bluetoothManager.modeNum == 2) {
                                                        Text("모드 2, 일몰 켜짐, 밤중 꺼짐, 새벽 켜짐, 일출 꺼짐")
                                                            .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                                            .foregroundColor(.textLight)
                                                            .padding(.top, 12)
                                                    } else if (bluetoothManager.modeNum == 3) {
                                                        Text("모드 3, 일몰 켜짐, 밤중 꺼짐")
                                                            .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                                            .foregroundColor(.textLight)
                                                            .padding(.top, 12)
                                                    } else if (bluetoothManager.modeNum == 4) {
                                                        Text("모드 4, 새벽 켜짐, 일출 꺼짐")
                                                            .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                                            .foregroundColor(.textLight)
                                                            .padding(.top, 12)
                                                    } else if (bluetoothManager.modeNum == 5) {
                                                        Text("모드 5, 설정 시간 ON/OFF, 1회 반복")
                                                            .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                                            .foregroundColor(.textLight)
                                                            .padding(.top, 12)
                                                    } else if (bluetoothManager.modeNum == 6) {
                                                        Text("모드 6, 설정 시간 ON/OFF, 2회 반복")
                                                            .font(Font.custom("Pretendard", size: 16).weight(.bold))
                                                            .foregroundColor(.textLight)
                                                            .padding(.top, 12)
                                                    }
                                                    
//                                                    Text(selectedMode)
//                                                        .font(Font.custom("Pretendard", size: 16).weight(.bold))
//                                                        .foregroundColor(.textLight)
//                                                        .padding(.top, 12)
                                                    
                                                    VStack {
                                                        if bluetoothManager.modeNum == 1 {
                                                            HStack(alignment: .top, spacing: 4) {
                                                                HStack(spacing: 0) {
                                                                    Text("일몰")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("일출")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                            .frame(maxWidth: .infinity)
                                                            .background(
                                                                LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.30, blue: 0), Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                            )
                                                            .cornerRadius(12)
                                                            .padding(.top, 20)
                                                            .padding(.bottom, 8)
                                                            
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
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                                .cornerRadius(8)
                                                                HStack(spacing: 0) {
                                                                    Text("ON")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.black)
                                                                }
                                                                .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                                // .frame(width: 213, height: 40)
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
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(6)
                                                            .frame(maxWidth: .infinity)
                                                            .background(.black)
                                                            .cornerRadius(12)
                                                        }
                                                        else if (bluetoothManager.modeNum == 2) {
                                                            
                                                            HStack(alignment: .top, spacing: 4) {
                                                                HStack(spacing: 0) {
                                                                    Text("일몰")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("밤 중")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 9))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("새벽")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("일출")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                            .frame(maxWidth: .infinity)
                                                            .background(
                                                                LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.30, blue: 0), Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                            )
                                                            .cornerRadius(12)
                                                            .padding(.top, 20)
                                                            .padding(.bottom, 8)
                                                            
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
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
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
                                                                HStack(spacing: 0) {
                                                                    Text("OFF")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                        .opacity(0.50)
                                                                }
                                                                .padding(
                                                                    EdgeInsets(top: 14, leading: 23, bottom: 14, trailing: 23.67)
                                                                )
                                                                .frame(height: 40)
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
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
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(6)
                                                            .frame(maxWidth: .infinity)
                                                            .background(.black)
                                                            .cornerRadius(12)
                                                        }
                                                        else if (bluetoothManager.modeNum == 3) {
                                                            
                                                            HStack(alignment: .top, spacing:4) {
                                                                HStack(spacing: 0) {
                                                                    Text("일몰")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("밤 중")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 9))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("일출")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                            .frame(maxWidth: .infinity)
                                                            .background(
                                                                LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.30, blue: 0), Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                            )
                                                            .cornerRadius(12)
                                                            .padding(.top, 20)
                                                            .padding(.bottom, 8)
                                                            
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
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
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
                                                                HStack(spacing: 0) {
                                                                    Text("OFF")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                        .opacity(0.50)
                                                                }
                                                                .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                                .frame(maxWidth: .infinity)
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(6)
                                                            .frame(maxWidth: .infinity)
                                                            .background(.black)
                                                            .cornerRadius(12)
                                                        }
                                                        else if (bluetoothManager.modeNum == 4) {
                                                            
                                                            HStack(alignment: .top, spacing: 4) {
                                                                HStack(spacing: 0) {
                                                                    Text("일몰")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("새벽")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 9))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("일출")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                            .frame(maxWidth: .infinity)
                                                            .background(
                                                                LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.30, blue: 0), Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                            )
                                                            .cornerRadius(12)
                                                            .padding(.top, 20)
                                                            .padding(.bottom, 8)
                                                            
                                                            HStack(spacing: 2) {
                                                                HStack(spacing: 0) {
                                                                    Text("OFF")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                        .opacity(0.50)
                                                                }
                                                                .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                                .frame(maxWidth: .infinity)
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
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
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(6)
                                                            .frame(maxWidth: .infinity)
                                                            .background(.black)
                                                            .cornerRadius(12)
                                                        }
                                                        else if (bluetoothManager.modeNum == 5) {
                                                            HStack(alignment: .top, spacing: 4) {
                                                                HStack(spacing: 0) {
                                                                    Text("\(dateToOnTime1(date: Mode5OnTime))")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("\(dateToOffTime2(date: Mode5OffTime))")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                            .frame(maxWidth: .infinity)
                                                            .background(
                                                                LinearGradient(gradient: Gradient(colors: [Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                            )
                                                            .cornerRadius(12)
                                                            .padding(.top, 20)
                                                            .padding(.bottom, 8)
                                                            
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
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                                .cornerRadius(8)
                                                                HStack(spacing: 0) {
                                                                    Text("ON")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.black)
                                                                }
                                                                .padding(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
                                                                // .frame(width: 213, height: 40)
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
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(6)
                                                            .frame(maxWidth: .infinity)
                                                            .background(.black)
                                                            .cornerRadius(12)
                                                        }
                                                        else if (bluetoothManager.modeNum == 6) {
                                                            HStack(alignment: .top, spacing: 4) {
                                                                HStack(spacing: 0) {
                                                                    Text("\(dateToOnTime3(date: Mode6OnTime))")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("\(dateToOffTime4(date: Mode6OffTime))")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 9))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("\(dateToOnTime5(date: Mode6OnTime2))")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                                
                                                                Spacer()
                                                                
                                                                HStack(spacing: 0) {
                                                                    Text("\(dateToOffTime6(date: Mode6OffTime2))")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.semibold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                }
                                                                .padding(EdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 10))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                            .frame(maxWidth: .infinity)
                                                            .background(
                                                                LinearGradient(gradient: Gradient(colors: [Color(red: 0.13, green: 0.12, blue: 0.52), Color(red: 0, green: 0.94, blue: 1)]), startPoint: .leading, endPoint: .trailing)
                                                            )
                                                            .cornerRadius(12)
                                                            .padding(.top, 20)
                                                            .padding(.bottom, 8)
                                                            
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
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
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
                                                                HStack(spacing: 0) {
                                                                    Text("OFF")
                                                                        .font(Font.custom("Pretendard", size: 12).weight(.bold))
                                                                        .lineSpacing(12)
                                                                        .foregroundColor(.textLight)
                                                                        .opacity(0.50)
                                                                }
                                                                .padding(
                                                                    EdgeInsets(top: 14, leading: 23, bottom: 14, trailing: 23.67)
                                                                )
                                                                .frame(height: 40)
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
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
                                                                .background(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                                                                .cornerRadius(8)
                                                            }
                                                            .padding(6)
                                                            .frame(maxWidth: .infinity)
                                                            .background(.black)
                                                            .cornerRadius(12)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        .padding(20)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.bgLightDark)
                                        .cornerRadius(24)
                                        .padding()
                                        .padding(.top, -20)
                                        .onAppear {
                                            loadSettingTimes()
                                        }
                                    }
                                }
                                
                                
                                if bluetoothManager.powerOn {
                                    // 요일모드 선택
                                    NavigationLink (destination: DayMode(bluetoothManager:bluetoothManager)) {
                                        VStack(spacing:20) {
                                            HStack (spacing: 50) {
                                                VStack (alignment: .leading) {
                                                    HStack {
                                                        Text("요일 선택")
                                                            .font(Font.custom("Pretendard", size: 17).weight(.bold))
                                                            .foregroundColor(.textLight)
                                                            .opacity(0.8)
                                                        
                                                        Spacer()
                                                        
                                                        Image(systemName: "chevron.right")
                                                            .font(Font.custom("Pretendard", size: 15).weight(.bold))
                                                            .foregroundColor(.textLight)
                                                    }
                                                    
                                                    
                                                    Text("\(dayNames.joined(separator: ", "))")
                                                        .onAppear {
                                                            loadSelectedDays()
                                                        }
                                                        .font(Font.custom("Pretendard", size: 15).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                }
                                                
                                            }
                                        }
                                        .padding(20)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.bgLightDark)
                                        .cornerRadius(24)
                                        .padding()
                                        .padding(.top, -20)
                                    }
                                }
                                
                                HStack {
                                    if bluetoothManager.powerOn {
                                        // 수동 작동
                                        VStack {
                                            HStack {
                                                VStack (alignment: .leading){
                                                    Text("수동 작동")
                                                        .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                        .padding()
                                                    
                                                    Text(timerViewModel.timeFormatted)
                                                        .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                                        .foregroundColor(.textLight)
                                                        .padding(.leading)
                                                    
                                                    if (isLoading) {
                                                        ProgressView("로딩 중...")
                                                            .progressViewStyle(CircularProgressViewStyle(tint: .textLight))
                                                            .padding()
                                                    } else {
                                                        Toggle(isOn: $bluetoothManager.emergencyOn) {
                                                            
                                                        }
                                                        .padding()
                                                        .disabled(isLoading)
                                                        .onChange(of: bluetoothManager.emergencyOn) { newValue in
                                                            isLoading = true
                                                            if newValue {
                                                                timerViewModel.startTimer()
                                                                sendEmergencyData()
                                                            } else {
                                                                timerViewModel.stopTimer()
                                                                sendEmergencyOffData()
                                                            }
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                                                isLoading = false
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .background(Color.bgLightDark)
                                        .cornerRadius(24)
                                    }
                                    
                                    // 전원ON/OFF
                                    VStack {
                                        HStack {
                                            VStack (alignment: .leading) {
                                                Text("전원 ON/OFF")
                                                    .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                                    .foregroundColor(.textLight)
                                                    .padding()
                                                
                                                Text(timerViewModel.timeFormatted)
                                                    .font(Font.custom("Pretendard", size: 18).weight(.bold))
                                                    .foregroundColor(.textLight)
                                                    .opacity(0)
                                                
                                                
                                                if (isLoading) {
                                                    ProgressView("로딩 중...")
                                                        .progressViewStyle(CircularProgressViewStyle(tint: .textLight))
                                                        .padding()
                                                } else {
                                                    Toggle(isOn: $bluetoothManager.powerOn) {
                                                        
                                                    }
                                                    .padding()
                                                    .onChange(of: bluetoothManager.powerOn) { newValue in
                                                        isLoading = true
                                                        if newValue {
                                                            sendOnData()
                                                        } else {
                                                            sendOffData()
                                                        }
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                                            isLoading = false
                                                        }
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color.bgLightDark)
                                    .cornerRadius(24)
                                    
                                }
                                .padding(.top, -20)
                                .padding()
                            }
                            .navigationBarBackButtonHidden(true)
                        }
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func loadSelectedDays() {
        selectedDaysValue = UInt8(UserDefaults.standard.integer(forKey: "selectedDays"))
        updateDayNames()
    }
    
    func updateDayNames() {
        // BitSet을 사용하여 선택된 요일의 이름을 가르킴
        dayNames = []
        for index in allDaysNames.indices {
            if (selectedDaysValue & (1 << index)) != 0 {
                dayNames.append(allDaysNames[index])
            } else if (selectedDaysValue == 0) {
                dayNames = allDaysNames
            }
        }
    }
    
    func loadSettingTimes() {
        Mode5OnTime = UserDefaults.standard.object(forKey: "Mode5 OnTime") as? Date ?? Date()
        Mode5OffTime = UserDefaults.standard.object(forKey: "Mode5 OffTime") as? Date ?? Date()
        Mode6OnTime = UserDefaults.standard.object(forKey: "Mode6 OnTime") as? Date ?? Date() // 일몰 전 시간
        Mode6OffTime = UserDefaults.standard.object(forKey: "Mode6 OffTime") as? Date ?? Date() // 일몰 후 시간
        Mode6OnTime2 = UserDefaults.standard.object(forKey: "Mode6 OnTime2") as? Date ?? Date()
        Mode6OffTime2 = UserDefaults.standard.object(forKey: "Mode6 OffTime2") as? Date ?? Date()
    }
    
    func sendEmergencyData() {
        if !bluetoothManager.bluetoothIsReady {
            print("시리얼이 준비되지 않음")
            return
        }
        
        let CHECKSUM: UInt8 = 207 &+ 7
        print(CHECKSUM)
        
        let packet: [UInt8] = [207, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, CHECKSUM, 13, 10]
        
        print(packet)
        bluetoothManager.sendBytesToDevice(packet)
        // Change Label Text expression "success" for waiting
        // serialMessageLabel.text = "waiting msg from peripheral"
    }
    
    func sendEmergencyOffData() {
        if !bluetoothManager.bluetoothIsReady {
            print("시리얼이 준비되지 않음")
            return
        }
        
        let CHECKSUM: UInt8 = 207 &+ 9
        
        let packet: [UInt8] = [207, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, CHECKSUM, 13, 10]
        print(packet)
        sendData()
        bluetoothManager.sendBytesToDevice(packet)
        
    }
    
    func sendOnData() {
        if !bluetoothManager.bluetoothIsReady {
            print("시리얼이 준비되지 않음")
            return
        }
        
        let CHECKSUM: UInt8 = 207 &+ 9
        
        let packet: [UInt8] = [207, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, CHECKSUM, 13, 10]
        
        print(packet)
        sendData()
        bluetoothManager.sendBytesToDevice(packet)
        // Change Label Text expression "success" for waiting
        // serialMessageLabel.text = "waiting msg from peripheral"
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
    
    func sendOffData() {
        if !bluetoothManager.bluetoothIsReady {
            print("시리얼이 준비되지 않음")
            return
        }
        
        let CHECKSUM: UInt8 = 207 &+ 10
        
        let packet: [UInt8] = [207, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, CHECKSUM, 13, 10]
        
        timerViewModel.stopTimer()
        print(packet)
        bluetoothManager.sendBytesToDevice(packet)
        // Change Label Text expression "success" for waiting
        // serialMessageLabel.text = "waiting msg from peripheral"
    }
    
    func toggleTimer() {
            timerRunning.toggle()
            if timerRunning {
                lastBackgroundTime = nil
            } else {
                stopTimer()
            }
        }
    
    func startTimer() {
        self.timerRunning = true
        self.emergenyTimer?.invalidate()
        self.emergenyTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stopTimer()
            }
        }
        sendEmergencyData()
    }
    
    func stopTimer() {
        self.emergenyTimer?.invalidate()
        self.emergenyTimer = nil
        self.timerRunning = false
        self.timeRemaining = 3600 // 다시 초기화
        
        sendOnData()
    }
        
    func timeString(time: Int) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    // Date 인스턴스에서 요일을 추출하는 함수
    func dayOfWeekString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // 'EEEE'는 날짜의 전체 이름을 의미합니다.
        return dateFormatter.string(from: date)
    }
    
    func loadDeviceName(uuidString: String) -> String? {
        // let connectedName = bluetoothManager.connectedDeviceIdentifier
        // UserDefaults.standard.string(forKey: connectedName)
        if let peripheralDict = UserDefaults.standard.dictionary(forKey: "PeripheralList") as? [String: [String: String]] {
            return peripheralDict[uuidString]?["name"]
        }
        return nil
    }
    
    func dateToOnTime1(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let formattedDate = formatter.string(from: Mode5OnTime)

            return formattedDate
        }

        func dateToOffTime2(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let formattedDate = formatter.string(from: Mode5OffTime)

            return formattedDate
        }

        func dateToOnTime3(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let formattedDate = formatter.string(from: Mode6OnTime)

            return formattedDate
        }

        func dateToOffTime4(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let formattedDate = formatter.string(from: Mode6OffTime)

            return formattedDate
        }

        func dateToOnTime5(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let formattedDate = formatter.string(from: Mode6OnTime2)

            return formattedDate
        }

        func dateToOffTime6(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let formattedDate = formatter.string(from: Mode6OffTime2)

            return formattedDate
        }
}

//
//#Preview {
//    ContentView()
//}
