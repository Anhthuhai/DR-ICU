# SOFA Score - Unit Conversion Feature

## 🧪 Tính năng mới: Chuyển đổi đơn vị cho Bilirubin và Creatinine

### 🎯 Mục đích
Hỗ trợ các phòng xét nghiệm có thể trả kết quả với đơn vị khác nhau:
- **mg/dL** (đơn vị thông dụng tại Việt Nam)
- **umol/L** (đơn vị quốc tế SI)

### 📊 Các chỉ số được hỗ trợ

#### 1. **Bilirubin (Hệ gan)**
- **Đơn vị hỗ trợ**: mg/dL, umol/L
- **Công thức chuyển đổi**: 1 mg/dL = 17.1 umol/L
- **Giới hạn SOFA Score**:
  - 0 điểm: < 1.2 mg/dL (< 20.5 umol/L)
  - 1 điểm: 1.2-1.9 mg/dL (20.5-32.5 umol/L)
  - 2 điểm: 2.0-5.9 mg/dL (34.2-100.9 umol/L)
  - 3 điểm: 6.0-11.9 mg/dL (102.6-203.5 umol/L)
  - 4 điểm: ≥ 12.0 mg/dL (≥ 205.2 umol/L)

#### 2. **Creatinine (Hệ thận)**
- **Đơn vị hỗ trợ**: mg/dL, umol/L
- **Công thức chuyển đổi**: 1 mg/dL = 88.4 umol/L
- **Giới hạn SOFA Score**:
  - 0 điểm: < 1.2 mg/dL (< 106 umol/L)
  - 1 điểm: 1.2-1.9 mg/dL (106-168 umol/L)
  - 2 điểm: 2.0-3.4 mg/dL (177-300 umol/L)
  - 3 điểm: 3.5-4.9 mg/dL (309-433 umol/L)
  - 4 điểm: ≥ 5.0 mg/dL (≥ 442 umol/L)

### 🛠 Cách sử dụng

1. **Vào SOFA Score calculator**
2. **Nhập giá trị Bilirubin**:
   - Chọn đơn vị (mg/dL hoặc umol/L)
   - Nhập số liệu
   - Điểm số sẽ tự động tính toán
3. **Nhập giá trị Creatinine**:
   - Chọn đơn vị (mg/dL hoặc umol/L) 
   - Nhập số liệu
   - Điểm số sẽ tự động tính toán

### 🔄 Chuyển đổi tự động
- Khi thay đổi đơn vị, giá trị sẽ được tự động chuyển đổi
- Điểm SOFA được tính toán dựa trên giá trị đã chuyển đổi về mg/dL
- Hiển thị công thức chuyển đổi để tham khảo

### 📋 Ví dụ thực tế

#### Bilirubin
- **Input**: 3.5 mg/dL → **Score**: 2 điểm
- **Input**: 60 umol/L → **Converted**: 3.51 mg/dL → **Score**: 2 điểm

#### Creatinine  
- **Input**: 2.5 mg/dL → **Score**: 2 điểm
- **Input**: 220 umol/L → **Converted**: 2.49 mg/dL → **Score**: 2 điểm

### 🎨 UI Features

#### Dropdown Unit Selector
- Compact dropdown bên cạnh input field
- Label động thay đổi theo đơn vị được chọn
- Reset về mg/dL khi reset toàn bộ

#### Conversion Reference
- Hiển thị công thức chuyển đổi dưới mỗi input
- Styling nhẹ nhàng với background màu xanh
- Font chữ nghiêng để phân biệt với input chính

#### Auto-calculation
- Tính toán ngay khi nhập số liệu
- Tính toán lại khi thay đổi đơn vị
- Không cần nhấn nút Calculate

### 🔧 Technical Implementation

```dart
// Unit conversion functions
double _convertBilirubinToMgDl(double value, String unit) {
  if (unit == 'umol/L') {
    return value / 17.1; // umol/L to mg/dL
  }
  return value; // Already in mg/dL
}

double _convertCreatinineToMgDl(double value, String unit) {
  if (unit == 'umol/L') {
    return value / 88.4; // umol/L to mg/dL  
  }
  return value; // Already in mg/dL
}
```

### 🏥 Lợi ích lâm sàng

1. **Tính nhất quán**: Không cần chuyển đổi thủ công
2. **Giảm sai sót**: Tự động tính toán chính xác
3. **Tiết kiệm thời gian**: Không cần tra cứu bảng chuyển đổi
4. **Linh hoạt**: Hỗ trợ nhiều phòng xét nghiệm khác nhau
5. **Minh bạch**: Hiển thị công thức chuyển đổi

---

*Tính năng này giúp bác sĩ ICU sử dụng SOFA Score một cách chính xác và thuận tiện, bất kể đơn vị xét nghiệm nào được sử dụng tại cơ sở y tế.*
