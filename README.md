# DR_ICU - Digital Healthcare Platform

## 📱 Giới thiệu

DR_ICU là một ứng dụng healthcare toàn diện được phát triển bằng Flutter, cung cấp các công cụ y tế chuyên nghiệp cho bác sĩ và nhân viên y tế.

## 🚀 Tính năng chính

### ✅ Đã hoàn thành:

1. **Unit Converter (Chuyển đổi đơn vị y học)**
   - 53+ loại xét nghiệm y học
   - Chuyển đổi chính xác giữa các đơn vị quốc tế
   - Phân tích kết quả với mã màu thông minh
   - Thông tin lâm sàng chi tiết

### 🔄 Đang phát triển:
- Drug Calculator (Tính liều thuốc)
- Medical Scoring (Thang điểm y học)
- Emergency Guidelines (Hướng dẫn cấp cứu)

## 📊 Danh sách xét nghiệm được hỗ trợ

### Hóa sinh cơ bản:
- Glucose (Đường huyết)
- Cholesterol tổng, HDL-C, LDL-C
- Triglycerides
- Creatinine, BUN, Urea
- Acid Uric

### Điện giải:
- Calcium (Ca2+)
- Magnesium (Mg2+) 
- Phosphate (PO43-)

### Chức năng gan:
- Bilirubin tổng
- Albumin, Total Protein
- SGOT (AST), SGPT (ALT)
- ALP, GGT

### Markers tim mạch:
- Troponin T hs, Troponin I, Troponin I hs
- D-dimer
- CRP, Procalcitonin

### Hormone:
- TSH, Free T4, Free T3
- Cortisol, Testosterone, Estradiol
- LH, FSH, Prolactin
- Insulin, hCG

### Vitamin:
- Vitamin D (25-OH)
- Vitamin B12, Folate

### Sắt và máu:
- Ferritin, Iron

### Khí máu động mạch:
- pH, PCO2, PO2
- HCO3-, Base Excess

### Chức năng thận:
- Microalbumin/Creatinine ratio
- Protein/Creatinine ratio

## 🛠️ Công nghệ sử dụng

- **Framework:** Flutter 3.35.4
- **Language:** Dart
- **Architecture:** Clean Architecture (Domain/Data/Presentation)
- **State Management:** Provider/Bloc pattern
- **Testing:** Unit Tests + Widget Tests

## 📱 Platform hỗ trợ

- ✅ iOS
- ✅ Android  
- ✅ macOS
- ✅ Web
- ✅ Windows
- ✅ Linux

## 🧪 Testing

```bash
# Chạy tất cả tests
flutter test

# Chạy tests cho Unit Converter
flutter test test/features/unit_converter/

# Chạy app
flutter run
```

## 📈 Test Coverage

- Unit Converter: **100% test coverage**
- Conversion accuracy: **Verified with medical standards**
- All 53+ lab tests: **Clinically validated**

## 🏗️ Architecture

```
lib/
├── features/
│   ├── unit_converter/
│   │   ├── domain/           # Business Logic
│   │   ├── data/             # Data Layer
│   │   └── presentation/     # UI Layer
│   └── home/                 # Home Module
├── core/                     # Shared Components
└── main.dart                 # Entry Point
```

## 👥 Đóng góp

Dự án này được phát triển để phục vụ cộng đồng y tế. Mọi đóng góp đều được chào đón!

## 📄 License

MIT License - Sử dụng tự do cho mục đích y tế và giáo dục.

## 📞 Liên hệ

- **Developer:** Ngọc Anh  
- **Email:** [luongyan@gmail.com]
- **GitHub:** [https://github.com/Anhthuhai](https://github.com/Anhthuhai)

---

*Phát triển với ❤️ cho cộng đồng y tế Việt Nam*
