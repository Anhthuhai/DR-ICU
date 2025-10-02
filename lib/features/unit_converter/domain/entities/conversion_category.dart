import 'conversion_unit.dart';

class ConversionCategory {
  final String id;
  final String name;
  final String description;
  final List<ConversionUnit> units;
  final String icon; // Icon name for UI
  final String commonExample; // Example: "mg/dL ↔ mmol/L"
  final String? normalRange; // Giá trị tham khảo bình thường (optional)
  final String? clinicalSignificance; // Ý nghĩa lâm sàng (optional)

  const ConversionCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.units,
    required this.icon,
    required this.commonExample,
    this.normalRange,
    this.clinicalSignificance,
  });

  /// Get the base unit for this category
  ConversionUnit get baseUnit => 
      units.firstWhere((unit) => unit.isBaseUnit, orElse: () => units.first);

  /// Get a unit by ID
  ConversionUnit? getUnitById(String id) {
    try {
      return units.firstWhere((unit) => unit.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Analyze the meaning of a test result value
  String analyzeResult(double value, String unitSymbol) {
    switch (id) {
      case 'glucose':
        return _analyzeGlucose(value, unitSymbol);
      case 'cholesterol':
        return _analyzeCholesterol(value, unitSymbol);
      case 'creatinine':
        return _analyzeCreatinine(value, unitSymbol);
      case 'hba1c':
        return _analyzeHbA1c(value, unitSymbol);
      case 'triglycerides':
        return _analyzeTriglycerides(value, unitSymbol);
      case 'urea':
        return _analyzeUrea(value, unitSymbol);
      case 'hdl_cholesterol':
        return _analyzeHDL(value, unitSymbol);
      case 'ldl_cholesterol':
        return _analyzeLDL(value, unitSymbol);
      case 'uric_acid':
        return _analyzeUricAcid(value, unitSymbol);
      case 'calcium':
        return _analyzeCalcium(value, unitSymbol);
      case 'magnesium':
        return _analyzeMagnesium(value, unitSymbol);
      case 'phosphate':
        return _analyzePhosphate(value, unitSymbol);
      case 'bilirubin_total':
        return _analyzeBilirubin(value, unitSymbol);
      case 'albumin':
        return _analyzeAlbumin(value, unitSymbol);
      case 'total_protein':
        return _analyzeTotalProtein(value, unitSymbol);
      case 'sgot_ast':
        return _analyzeAST(value, unitSymbol);
      case 'sgpt_alt':
        return _analyzeALT(value, unitSymbol);
      case 'alp':
        return _analyzeALP(value, unitSymbol);
      case 'ggt':
        return _analyzeGGT(value, unitSymbol);
      default:
        return 'Không có thông tin phân tích cho loại xét nghiệm này';
    }
  }

  String _analyzeGlucose(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 70) return '🔴 THẤP: Hạ đường huyết - Cần bổ sung glucose ngay';
      if (value <= 99) return '🟢 BÌNH THƯỜNG: Glucose lúc đói trong giới hạn bình thường';
      if (value <= 125) return '🟡 TIỀN TIỂU ĐƯỜNG: Glucose lúc đói bất thường - Cần theo dõi';
      return '🔴 CAO: Tiểu đường - Cần điều trị và kiểm soát';
    } else { // mmol/L
      if (value < 3.9) return '🔴 THẤP: Hạ đường huyết - Cần bổ sung glucose ngay';
      if (value <= 5.5) return '🟢 BÌNH THƯỜNG: Glucose lúc đói trong giới hạn bình thường';
      if (value <= 6.9) return '🟡 TIỀN TIỂU ĐƯỜNG: Glucose lúc đói bất thường - Cần theo dõi';
      return '🔴 CAO: Tiểu đường - Cần điều trị và kiểm soát';
    }
  }

  String _analyzeCholesterol(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 200) return '🟢 TỐT: Cholesterol toàn phần trong giới hạn mong muốn';
      if (value <= 239) return '🟡 BIÊN GIỚI CAO: Cần thay đổi lối sống và theo dõi';
      return '🔴 CAO: Tăng nguy cơ tim mạch - Cần điều trị';
    } else { // mmol/L
      if (value < 5.2) return '🟢 TỐT: Cholesterol toàn phần trong giới hạn mong muốn';
      if (value <= 6.2) return '🟡 BIÊN GIỚI CAO: Cần thay đổi lối sống và theo dõi';
      return '🔴 CAO: Tăng nguy cơ tim mạch - Cần điều trị';
    }
  }

  String _analyzeCreatinine(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 0.6) return '🟡 THẤP: Có thể do giảm khối lượng cơ hoặc chế độ ăn ít protein';
      if (value <= 1.3) return '🟢 BÌNH THƯỜNG: Chức năng thận trong giới hạn bình thường';
      if (value <= 2.0) return '🟡 TĂNG NHẸ: Suy giảm chức năng thận nhẹ - Cần theo dõi';
      return '🔴 CAO: Suy giảm chức năng thận đáng kể - Cần can thiệp';
    } else { // μmol/L
      if (value < 53) return '🟡 THẤP: Có thể do giảm khối lượng cơ hoặc chế độ ăn ít protein';
      if (value <= 115) return '🟢 BÌNH THƯỜNG: Chức năng thận trong giới hạn bình thường';
      if (value <= 177) return '🟡 TĂNG NHẸ: Suy giảm chức năng thận nhẹ - Cần theo dõi';
      return '🔴 CAO: Suy giảm chức năng thận đáng kể - Cần can thiệp';
    }
  }

  String _analyzeHbA1c(double value, String unitSymbol) {
    if (unitSymbol == '%') {
      if (value < 5.7) return '🟢 BÌNH THƯỜNG: Kiểm soát đường huyết tốt';
      if (value <= 6.4) return '🟡 TIỀN TIỂU ĐƯỜNG: Nguy cơ phát triển tiểu đường - Cần can thiệp';
      if (value <= 7.0) return '🟠 TIỂU ĐƯỜNG: Kiểm soát chấp nhận được - Tiếp tục điều trị';
      if (value <= 9.0) return '🔴 TIỂU ĐƯỜNG: Kiểm soát kém - Cần điều chỉnh điều trị';
      return '🔴 TIỂU ĐƯỜNG: Kiểm soát rất kém - Cần can thiệp gấp';
    } else { // mmol/mol
      if (value < 39) return '🟢 BÌNH THƯỜNG: Kiểm soát đường huyết tốt';
      if (value <= 47) return '🟡 TIỀN TIỂU ĐƯỜNG: Nguy cơ phát triển tiểu đường - Cần can thiệp';
      if (value <= 53) return '🟠 TIỂU ĐƯỜNG: Kiểm soát chấp nhận được - Tiếp tục điều trị';
      if (value <= 75) return '🔴 TIỂU ĐƯỜNG: Kiểm soát kém - Cần điều chỉnh điều trị';
      return '🔴 TIỂU ĐƯỜNG: Kiểm soát rất kém - Cần can thiệp gấp';
    }
  }

  String _analyzeTriglycerides(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 150) return '🟢 BÌNH THƯỜNG: Triglyceride trong giới hạn mong muốn';
      if (value <= 199) return '🟡 BIÊN GIỚI CAO: Cần thay đổi lối sống';
      if (value <= 499) return '🔴 CAO: Tăng nguy cơ tim mạch - Cần điều trị';
      return '🔴 RẤT CAO: Nguy cơ viêm tụy cấp - Cần điều trị khẩn cấp';
    } else { // mmol/L
      if (value < 1.7) return '🟢 BÌNH THƯỜNG: Triglyceride trong giới hạn mong muốn';
      if (value <= 2.2) return '🟡 BIÊN GIỚI CAO: Cần thay đổi lối sống';
      if (value <= 5.6) return '🔴 CAO: Tăng nguy cơ tim mạch - Cần điều trị';
      return '🔴 RẤT CAO: Nguy cơ viêm tụy cấp - Cần điều trị khẩn cấp';
    }
  }

  String _analyzeUrea(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 15) return '🟡 THẤP: Có thể do chế độ ăn ít protein hoặc bệnh gan';
      if (value <= 40) return '🟢 BÌNH THƯỜNG: Chức năng thận và chuyển hóa protein tốt';
      if (value <= 60) return '🟡 TĂNG NHẸ: Có thể do mất nước, ăn nhiều protein hoặc suy thận nhẹ';
      return '🔴 CAO: Suy thận đáng kể hoặc mất nước nghiêm trọng - Cần can thiệp';
    } else { // mmol/L
      if (value < 2.5) return '🟡 THẤP: Có thể do chế độ ăn ít protein hoặc bệnh gan';
      if (value <= 6.7) return '🟢 BÌNH THƯỜNG: Chức năng thận và chuyển hóa protein tốt';
      if (value <= 10.0) return '🟡 TĂNG NHẸ: Có thể do mất nước, ăn nhiều protein hoặc suy thận nhẹ';
      return '🔴 CAO: Suy thận đáng kể hoặc mất nước nghiêm trọng - Cần can thiệp';
    }
  }

  String _analyzeHDL(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 40) return '🔴 THẤP: Nguy cơ tim mạch cao - Cần điều trị';
      if (value < 50) return '🟡 THẤP (Nữ): Dưới mức khuyến nghị cho nữ';
      if (value < 60) return '🟢 BÌNH THƯỜNG: HDL-C trong giới hạn chấp nhận';
      return '🟢 TỐT: HDL-C cao có tác dụng bảo vệ tim mạch';
    } else { // mmol/L
      if (value < 1.0) return '🔴 THẤP: Nguy cơ tim mạch cao - Cần điều trị';
      if (value < 1.3) return '🟡 THẤP (Nữ): Dưới mức khuyến nghị cho nữ';
      if (value < 1.6) return '🟢 BÌNH THƯỜNG: HDL-C trong giới hạn chấp nhận';
      return '🟢 TỐT: HDL-C cao có tác dụng bảo vệ tim mạch';
    }
  }

  String _analyzeLDL(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 100) return '🟢 TỐT: LDL-C tối ưu cho hầu hết mọi người';
      if (value < 130) return '🟡 GẦN TỐI ƯU: Chấp nhận được nếu không có yếu tố nguy cơ';
      if (value < 160) return '🟠 BIÊN GIỚI CAO: Cần thay đổi lối sống';
      if (value < 190) return '🔴 CAO: Cần điều trị - Nguy cơ tim mạch tăng';
      return '🔴 RẤT CAO: Cần điều trị tích cực - Nguy cơ rất cao';
    } else { // mmol/L
      if (value < 2.6) return '🟢 TỐT: LDL-C tối ưu cho hầu hết mọi người';
      if (value < 3.4) return '🟡 GẦN TỐI ƯU: Chấp nhận được nếu không có yếu tố nguy cơ';
      if (value < 4.1) return '🟠 BIÊN GIỚI CAO: Cần thay đổi lối sống';
      if (value < 4.9) return '🔴 CAO: Cần điều trị - Nguy cơ tim mạch tăng';
      return '🔴 RẤT CAO: Cần điều trị tích cực - Nguy cơ rất cao';
    }
  }

  String _analyzeUricAcid(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 2.6) return '🟡 THẤP: Hiếm gặp, có thể do thuốc hoặc bệnh lý';
      if (value <= 6.0) return '🟢 BÌNH THƯỜNG (Nữ): Trong giới hạn bình thường';
      if (value <= 7.2) return '🟢 BÌNH THƯỜNG (Nam): Trong giới hạn bình thường';
      if (value <= 9.0) return '🟠 CAO: Nguy cơ gout - Cần theo dõi và điều chỉnh';
      return '🔴 RẤT CAO: Nguy cơ gout và sỏi thận cao - Cần điều trị';
    } else { // μmol/L
      if (value < 155) return '🟡 THẤP: Hiếm gặp, có thể do thuốc hoặc bệnh lý';
      if (value <= 357) return '🟢 BÌNH THƯỜNG (Nữ): Trong giới hạn bình thường';
      if (value <= 428) return '🟢 BÌNH THƯỜNG (Nam): Trong giới hạn bình thường';
      if (value <= 535) return '🟠 CAO: Nguy cơ gout - Cần theo dõi và điều chỉnh';
      return '🔴 RẤT CAO: Nguy cơ gout và sỏi thận cao - Cần điều trị';
    }
  }

  String _analyzeCalcium(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 8.8) return '🔴 THẤP: Hạ canxi máu - Nguy cơ tetany, co giật';
      if (value <= 10.6) return '🟢 BÌNH THƯỜNG: Canxi trong giới hạn bình thường';
      if (value <= 11.5) return '🟡 TĂNG NHẸ: Cần kiểm tra parathyroid và vitamin D';
      return '🔴 CAO: Tăng canxi máu - Nguy cơ sỏi thận, rối loạn tim';
    } else { // mmol/L
      if (value < 2.20) return '🔴 THẤP: Hạ canxi máu - Nguy cơ tetany, co giật';
      if (value <= 2.65) return '🟢 BÌNH THƯỜNG: Canxi trong giới hạn bình thường';
      if (value <= 2.87) return '🟡 TĂNG NHẸ: Cần kiểm tra parathyroid và vitamin D';
      return '🔴 CAO: Tăng canxi máu - Nguy cơ sỏi thận, rối loạn tim';
    }
  }

  String _analyzeMagnesium(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 1.7) return '🔴 THẤP: Hạ magie - Nguy cơ co giật, rối loạn nhịp tim';
      if (value <= 2.5) return '🟢 BÌNH THƯỜNG: Magie trong giới hạn bình thường';
      if (value <= 3.0) return '🟡 TĂNG NHẸ: Cần theo dõi chức năng thận';
      return '🔴 CAO: Tăng magie - Có thể do suy thận hoặc dùng thuốc';
    } else { // mmol/L
      if (value < 0.70) return '🔴 THẤP: Hạ magie - Nguy cơ co giật, rối loạn nhịp tim';
      if (value <= 1.05) return '🟢 BÌNH THƯỜNG: Magie trong giới hạn bình thường';
      if (value <= 1.25) return '🟡 TĂNG NHẸ: Cần theo dõi chức năng thận';
      return '🔴 CAO: Tăng magie - Có thể do suy thận hoặc dùng thuốc';
    }
  }

  String _analyzePhosphate(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value < 2.5) return '🔴 THẤP: Hạ phosphat - Có thể do suy dinh dưỡng';
      if (value <= 4.5) return '🟢 BÌNH THƯỜNG: Phosphat trong giới hạn bình thường';
      if (value <= 6.0) return '🟡 TĂNG NHẸ: Cần kiểm tra chức năng thận';
      return '🔴 CAO: Tăng phosphat - Thường do suy thận';
    } else { // mmol/L
      if (value < 0.81) return '🔴 THẤP: Hạ phosphat - Có thể do suy dinh dưỡng';
      if (value <= 1.45) return '🟢 BÌNH THƯỜNG: Phosphat trong giới hạn bình thường';
      if (value <= 1.94) return '🟡 TĂNG NHẸ: Cần kiểm tra chức năng thận';
      return '🔴 CAO: Tăng phosphat - Thường do suy thận';
    }
  }

  String _analyzeBilirubin(double value, String unitSymbol) {
    if (unitSymbol == 'mg/dL') {
      if (value <= 1.2) return '🟢 BÌNH THƯỜNG: Bilirubin trong giới hạn bình thường';
      if (value <= 2.0) return '🟡 TĂNG NHẸ: Có thể có tán huyết nhẹ hoặc Gilbert';
      if (value <= 5.0) return '🔴 TĂNG VỪNG: Vàng da rõ - Cần tìm nguyên nhân';
      return '🔴 TĂNG CAO: Vàng da nặng - Cần điều trị khẩn cấp';
    } else { // μmol/L
      if (value <= 21) return '🟢 BÌNH THƯỜNG: Bilirubin trong giới hạn bình thường';
      if (value <= 34) return '🟡 TĂNG NHẸ: Có thể có tán huyết nhẹ hoặc Gilbert';
      if (value <= 85) return '🔴 TĂNG VỪNG: Vàng da rõ - Cần tìm nguyên nhân';
      return '🔴 TĂNG CAO: Vàng da nặng - Cần điều trị khẩn cấp';
    }
  }

  String _analyzeAlbumin(double value, String unitSymbol) {
    if (unitSymbol == 'g/dL') {
      if (value < 2.5) return '🔴 THẤP NẶNG: Hạ albumin nặng - Nguy cơ phù, nhiễm trùng';
      if (value < 3.5) return '🔴 THẤP: Hạ albumin - Có thể do gan, thận, dinh dưỡng';
      if (value <= 5.0) return '🟢 BÌNH THƯỜNG: Albumin trong giới hạn bình thường';
      return '🟡 CAO: Hiếm gặp, có thể do mất nước';
    } else { // g/L
      if (value < 25) return '🔴 THẤP NẶNG: Hạ albumin nặng - Nguy cơ phù, nhiễm trùng';
      if (value < 35) return '🔴 THẤP: Hạ albumin - Có thể do gan, thận, dinh dưỡng';
      if (value <= 50) return '🟢 BÌNH THƯỜNG: Albumin trong giới hạn bình thường';
      return '🟡 CAO: Hiếm gặp, có thể do mất nước';
    }
  }

  String _analyzeTotalProtein(double value, String unitSymbol) {
    if (unitSymbol == 'g/dL') {
      if (value < 6.0) return '🔴 THẤP: Hạ protein - Có thể do gan, thận, suy dinh dưỡng';
      if (value <= 8.3) return '🟢 BÌNH THƯỜNG: Protein toàn phần bình thường';
      if (value <= 9.5) return '🟡 TĂNG NHẸ: Có thể do mất nước hoặc viêm';
      return '🔴 CAO: Tăng protein - Nghi myeloma hoặc viêm mạn';
    } else { // g/L
      if (value < 60) return '🔴 THẤP: Hạ protein - Có thể do gan, thận, suy dinh dưỡng';
      if (value <= 83) return '🟢 BÌNH THƯỜNG: Protein toàn phần bình thường';
      if (value <= 95) return '🟡 TĂNG NHẸ: Có thể do mất nước hoặc viêm';
      return '🔴 CAO: Tăng protein - Nghi myeloma hoặc viêm mạn';
    }
  }

  String _analyzeAST(double value, String unitSymbol) {
    // AST normal: Men 15-40, Women 13-35 U/L
    if (value <= 40) return '🟢 BÌNH THƯỜNG: AST trong giới hạn bình thường';
    if (value <= 80) return '🟡 TĂNG NHẸ: Có thể do tập thể dục, thuốc, hoặc gan nhẹ';
    if (value <= 120) return '🔴 TĂNG VỪNG: Tổn thương gan/tim - Cần đánh giá thêm';
    return '🔴 TĂNG CAO: Tổn thương gan/tim nghiêm trọng - Cần can thiệp';
  }

  String _analyzeALT(double value, String unitSymbol) {
    // ALT normal: Men 10-40, Women 7-35 U/L
    if (value <= 40) return '🟢 BÌNH THƯỜNG: ALT trong giới hạn bình thường';
    if (value <= 80) return '🟡 TĂNG NHẸ: Có thể do béo phì, thuốc, hoặc viêm gan nhẹ';
    if (value <= 120) return '🔴 TĂNG VỪNG: Viêm gan - Cần tìm nguyên nhân';
    return '🔴 TĂNG CAO: Viêm gan nghiêm trọng - Cần điều trị khẩn cấp';
  }

  String _analyzeALP(double value, String unitSymbol) {
    // ALP normal: Adult 40-150, Children 100-320 U/L
    if (value <= 150) return '🟢 BÌNH THƯỜNG: ALP trong giới hạn bình thường';
    if (value <= 250) return '🟡 TĂNG NHẸ: Có thể do xương phát triển hoặc gan nhẹ';
    if (value <= 400) return '🔴 TĂNG VỪNG: Bệnh xương hoặc tắc mật - Cần đánh giá';
    return '🔴 TĂNG CAO: Bệnh xương nặng hoặc tắc mật nghiêm trọng';
  }

  String _analyzeGGT(double value, String unitSymbol) {
    // GGT normal: Men 11-50, Women 7-32 U/L
    if (value <= 50) return '🟢 BÌNH THƯỜNG: GGT trong giới hạn bình thường';
    if (value <= 100) return '🟡 TĂNG NHẸ: Có thể do rượu bia hoặc thuốc';
    if (value <= 200) return '🔴 TĂNG VỪNG: Nghi tổn thương gan do rượu/thuốc';
    return '🔴 TĂNG CAO: Tổn thương gan nghiêm trọng - Cần can thiệp';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversionCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => name;
}
