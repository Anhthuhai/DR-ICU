import '../../domain/entities/conversion_category.dart';
import '../../domain/entities/conversion_result.dart';
import '../../domain/entities/conversion_unit.dart';
import '../../domain/repositories/unit_converter_repository.dart';

class UnitConverterRepositoryImpl implements UnitConverterRepository {
  // Static data for medical lab units with normal ranges and clinical significance
  static final List<ConversionCategory> _categories = [
    // Glucose (Đường huyết)
    ConversionCategory(
      id: 'glucose',
      name: 'Glucose - Đường huyết',
      description: 'Chuyển đổi đơn vị đường huyết',
      icon: 'glucose',
      commonExample: 'mg/dL ↔ mmol/L',
      normalRange: 'Đói: 70-99 mg/dL (3.9-5.5 mmol/L)\nSau ăn 2h: <140 mg/dL (<7.8 mmol/L)',
      clinicalSignificance: 'Đánh giá bệnh tiểu đường, giám sát điều trị. Tăng glucose máu là dấu hiệu chính của bệnh tiểu đường và hội chứng chuyển hóa.',
      units: [
        ConversionUnit(
          id: 'glucose_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng ở Mỹ',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'glucose_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị quốc tế SI',
          conversionFactor: 0.0555, // mg/dL to mmol/L: multiply by 0.0555 (1/18.018)
        ),
      ],
    ),

    // Cholesterol
    ConversionCategory(
      id: 'cholesterol',
      name: 'Cholesterol',
      description: 'Chuyển đổi đơn vị cholesterol',
      icon: 'heart',
      commonExample: 'mg/dL ↔ mmol/L',
      normalRange: 'Tổng cholesterol: <200 mg/dL (<5.2 mmol/L)\nLDL: <100 mg/dL (<2.6 mmol/L)\nHDL: Nam >40, Nữ >50 mg/dL',
      clinicalSignificance: 'Đánh giá nguy cơ tim mạch. Cholesterol cao tăng nguy cơ xơ vữa động mạch, nhồi máu cơ tim và đột quỵ.',
      units: [
        ConversionUnit(
          id: 'chol_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'chol_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị quốc tế SI',
          conversionFactor: 0.0259, // mg/dL to mmol/L: multiply by 0.0259 (1/38.67)
        ),
      ],
    ),

    // Creatinine
    ConversionCategory(
      id: 'creatinine',
      name: 'Creatinine',
      description: 'Chuyển đổi đơn vị creatinine',
      icon: 'kidney',
      commonExample: 'mg/dL ↔ μmol/L',
      normalRange: 'Nam: 0.7-1.3 mg/dL (62-115 μmol/L)\nNữ: 0.6-1.1 mg/dL (53-97 μmol/L)',
      clinicalSignificance: 'Đánh giá chức năng thận. Tăng creatinine là dấu hiệu suy giảm chức năng thận, có thể do viêm thận, sỏi thận hoặc suy thận.',
      units: [
        ConversionUnit(
          id: 'creat_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'creat_umoll',
          name: 'Micromoles per liter',
          symbol: 'μmol/L',
          description: 'Đơn vị quốc tế SI',
          conversionFactor: 88.42, // mg/dL to μmol/L: multiply by 88.42
        ),
      ],
    ),

    // HbA1c
    ConversionCategory(
      id: 'hba1c',
      name: 'HbA1c - Hemoglobin A1c',
      description: 'Chuyển đổi đơn vị HbA1c',
      icon: 'diabetes',
      commonExample: '% ↔ mmol/mol',
      normalRange: 'Bình thường: <5.7%\nTiền tiểu đường: 5.7-6.4%\nTiểu đường: ≥6.5%',
      clinicalSignificance: 'Đánh giá kiểm soát đường huyết trong 2-3 tháng qua. HbA1c là chỉ số quan trọng để theo dõi và điều chỉnh điều trị tiểu đường.',
      units: [
        ConversionUnit(
          id: 'hba1c_percent',
          name: 'Percentage',
          symbol: '%',
          description: 'Đơn vị phần trăm (DCCT)',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'hba1c_mmolmol',
          name: 'Millimoles per mole',
          symbol: 'mmol/mol',
          description: 'Đơn vị IFCC',
          conversionFactor: 10.93, // % to mmol/mol: (% × 10.93) - 23.5
        ),
      ],
    ),

    // Triglycerides
    ConversionCategory(
      id: 'triglycerides',
      name: 'Triglycerides',
      description: 'Chuyển đổi đơn vị triglycerides',
      icon: 'lipid',
      commonExample: 'mg/dL ↔ mmol/L',
      normalRange: 'Bình thường: <150 mg/dL (<1.7 mmol/L)\nCao: 200-499 mg/dL\nRất cao: ≥500 mg/dL',
      clinicalSignificance: 'Đánh giá nguy cơ tim mạch và viêm tụy. Triglyceride cao liên quan đến hội chứng chuyển hóa và tăng nguy cơ bệnh tim mạch.',
      units: [
        ConversionUnit(
          id: 'trig_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'trig_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị quốc tế SI',
          conversionFactor: 0.0113, // mg/dL to mmol/L: multiply by 0.0113 (1/88.5)
        ),
      ],
    ),

    // Urea
    ConversionCategory(
      id: 'urea',
      name: 'Urea',
      description: 'Chuyển đổi đơn vị urea',
      icon: 'kidney',
      commonExample: 'mg/dL ↔ mmol/L',
      normalRange: 'Người lớn: 15-40 mg/dL (2.5-6.7 mmol/L)',
      clinicalSignificance: 'Đánh giá chức năng thận và tình trạng protein. Tăng urea có thể do suy thận, mất nước, chế độ ăn giàu protein.',
      units: [
        ConversionUnit(
          id: 'urea_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'urea_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị quốc tế SI',
          conversionFactor: 0.357, // mg/dL to mmol/L: multiply by 0.357 (1/2.8)
        ),
      ],
    ),

    // BUN (Blood Urea Nitrogen)
    ConversionCategory(
      id: 'bun',
      name: 'BUN - Blood Urea Nitrogen',
      description: 'Chuyển đổi đơn vị BUN',
      icon: 'kidney',
      commonExample: 'mg/dL ↔ mmol/L',
      normalRange: 'Người lớn: 6-24 mg/dL (2.1-8.5 mmol/L)',
      clinicalSignificance: 'Đánh giá chức năng thận và tình trạng protein. BUN cao có thể do suy thận, mất nước, chế độ ăn giàu protein.',
      units: [
        ConversionUnit(
          id: 'bun_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'bun_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị quốc tế SI',
          conversionFactor: 0.357, // mg/dL to mmol/L: multiply by 0.357 (1/2.8)
        ),
      ],
    ),

    // CRP (C-Reactive Protein)
    ConversionCategory(
      id: 'crp',
      name: 'CRP - C-Reactive Protein',
      description: 'Chuyển đổi đơn vị CRP',
      icon: 'inflammation',
      commonExample: 'mg/L ↔ mg/dL',
      normalRange: '<3.0 mg/L (<0.3 mg/dL)\nThấp: <1.0 mg/L\nTrung bình: 1.0-3.0 mg/L\nCao: >3.0 mg/L',
      clinicalSignificance: 'Chỉ số viêm và nguy cơ tim mạch. CRP cao cho thấy có viêm cấp tính hoặc nguy cơ tim mạch tăng.',
      units: [
        ConversionUnit(
          id: 'crp_mgl',
          name: 'Milligrams per liter',
          symbol: 'mg/L',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'crp_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị khác',
          conversionFactor: 10.0, // mg/L to mg/dL: divide by 10
        ),
      ],
    ),

    // Procalcitonin
    ConversionCategory(
      id: 'procalcitonin',
      name: 'Procalcitonin (PCT)',
      description: 'Chuyển đổi đơn vị Procalcitonin',
      icon: 'infection',
      commonExample: 'ng/mL ↔ μg/L',
      normalRange: '<0.25 ng/mL (<0.25 μg/L)\nNhiễm khuẩn: >0.5 ng/mL\nSepsis: >2.0 ng/mL',
      clinicalSignificance: 'Chẩn đoán nhiễm khuẩn và sepsis. PCT tăng cao trong nhiễm khuẩn, giúp phân biệt với nhiễm virus.',
      units: [
        ConversionUnit(
          id: 'pct_ngml',
          name: 'Nanograms per milliliter',
          symbol: 'ng/mL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'pct_ugl',
          name: 'Micrograms per liter',
          symbol: 'μg/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0, // ng/mL = μg/L
        ),
      ],
    ),

    // Troponin T high sensitivity
    ConversionCategory(
      id: 'troponin_t_hs',
      name: 'Troponin T hs',
      description: 'Chuyển đổi đơn vị Troponin T high sensitivity',
      icon: 'heart_attack',
      commonExample: 'ng/L ↔ pg/mL',
      normalRange: 'Nam: <22 ng/L (<22 pg/mL)\nNữ: <14 ng/L (<14 pg/mL)\nNhồi máu: >52 ng/L',
      clinicalSignificance: 'Chẩn đoán nhồi máu cơ tim và tổn thương cơ tim. Troponin T hs rất nhạy và đặc hiệu cho tổn thương cơ tim.',
      units: [
        ConversionUnit(
          id: 'tnt_hs_ngl',
          name: 'Nanograms per liter',
          symbol: 'ng/L',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'tnt_hs_pgml',
          name: 'Picograms per milliliter',
          symbol: 'pg/mL',
          description: 'Đơn vị khác',
          conversionFactor: 1.0, // ng/L = pg/mL
        ),
      ],
    ),

    // Troponin I
    ConversionCategory(
      id: 'troponin_i',
      name: 'Troponin I',
      description: 'Chuyển đổi đơn vị Troponin I',
      icon: 'heart_attack',
      commonExample: 'ng/mL ↔ μg/L',
      normalRange: '<0.04 ng/mL (<0.04 μg/L)\nNhồi máu: >0.10 ng/mL',
      clinicalSignificance: 'Chẩn đoán nhồi máu cơ tim. Troponin I là marker đặc hiệu cho tổn thương cơ tim, tăng trong 3-12h sau khởi phát.',
      units: [
        ConversionUnit(
          id: 'tni_ngml',
          name: 'Nanograms per milliliter',
          symbol: 'ng/mL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'tni_ugl',
          name: 'Micrograms per liter',
          symbol: 'μg/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0, // ng/mL = μg/L
        ),
      ],
    ),

    // Troponin I high sensitivity
    ConversionCategory(
      id: 'troponin_i_hs',
      name: 'Troponin I hs',
      description: 'Chuyển đổi đơn vị Troponin I high sensitivity',
      icon: 'heart_attack',
      commonExample: 'ng/L ↔ pg/mL',
      normalRange: 'Nam: <34 ng/L (<34 pg/mL)\nNữ: <16 ng/L (<16 pg/mL)\nNhồi máu: >60 ng/L',
      clinicalSignificance: 'Chẩn đoán sớm nhồi máu cơ tim. Troponin I hs có độ nhạy cao hơn, phát hiện tổn thương cơ tim sớm hơn.',
      units: [
        ConversionUnit(
          id: 'tni_hs_ngl',
          name: 'Nanograms per liter',
          symbol: 'ng/L',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'tni_hs_pgml',
          name: 'Picograms per milliliter',
          symbol: 'pg/mL',
          description: 'Đơn vị khác',
          conversionFactor: 1.0, // ng/L = pg/mL
        ),
      ],
    ),

    // D-dimer
    ConversionCategory(
      id: 'd_dimer',
      name: 'D-dimer',
      description: 'Chuyển đổi đơn vị D-dimer',
      icon: 'blood_clot',
      commonExample: 'mg/L ↔ ng/mL',
      normalRange: '<0.5 mg/L (<500 ng/mL)\nThuyên tắc phổi: thường >0.5 mg/L',
      clinicalSignificance: 'Chẩn đoán huyết khối và thuyên tắc. D-dimer tăng trong huyết khối tĩnh mạch, thuyên tắc phổi, DIC.',
      units: [
        ConversionUnit(
          id: 'ddimer_mgl',
          name: 'Milligrams per liter',
          symbol: 'mg/L',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'ddimer_ngml',
          name: 'Nanograms per milliliter',
          symbol: 'ng/mL',
          description: 'Đơn vị khác',
          conversionFactor: 1000.0, // mg/L to ng/mL: multiply by 1000
        ),
      ],
    ),

    // TSH (Thyroid Stimulating Hormone)
    ConversionCategory(
      id: 'tsh',
      name: 'TSH',
      description: 'Chuyển đổi đơn vị Thyroid Stimulating Hormone',
      icon: 'thyroid',
      commonExample: 'mIU/L ↔ μIU/mL',
      normalRange: '0.4-4.0 mIU/L (0.4-4.0 μIU/mL)\nCường giáp: <0.1 mIU/L\nSuy giáp: >10 mIU/L',
      clinicalSignificance: 'Đánh giá chức năng tuyến giáp. TSH tăng trong suy giáp, giảm trong cường giáp.',
      units: [
        ConversionUnit(
          id: 'tsh_miul',
          name: 'Milli international units per liter',
          symbol: 'mIU/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'tsh_uiuml',
          name: 'Micro international units per milliliter',
          symbol: 'μIU/mL',
          description: 'Đơn vị khác',
          conversionFactor: 1.0, // mIU/L = μIU/mL
        ),
      ],
    ),

    // Free T4
    ConversionCategory(
      id: 'free_t4',
      name: 'Free T4',
      description: 'Chuyển đổi đơn vị Free Thyroxine',
      icon: 'thyroid',
      commonExample: 'pmol/L ↔ ng/dL',
      normalRange: '12-22 pmol/L (0.93-1.7 ng/dL)\nCường giáp: >25 pmol/L\nSuy giáp: <10 pmol/L',
      clinicalSignificance: 'Đánh giá chức năng tuyến giáp. Free T4 tăng trong cường giáp, giảm trong suy giáp.',
      units: [
        ConversionUnit(
          id: 'ft4_pmoll',
          name: 'Picomoles per liter',
          symbol: 'pmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'ft4_ngdl',
          name: 'Nanograms per deciliter',
          symbol: 'ng/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.0777, // pmol/L to ng/dL: multiply by 0.0777
        ),
      ],
    ),

    // Free T3
    ConversionCategory(
      id: 'free_t3',
      name: 'Free T3',
      description: 'Chuyển đổi đơn vị Free Triiodothyronine',
      icon: 'thyroid',
      commonExample: 'pmol/L ↔ pg/mL',
      normalRange: '3.1-6.8 pmol/L (2.0-4.4 pg/mL)\nCường giáp: >7.5 pmol/L\nSuy giáp: <3.0 pmol/L',
      clinicalSignificance: 'Đánh giá chức năng tuyến giáp. Free T3 tăng trong cường giáp, giảm trong suy giáp.',
      units: [
        ConversionUnit(
          id: 'ft3_pmoll',
          name: 'Picomoles per liter',
          symbol: 'pmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'ft3_pgml',
          name: 'Picograms per milliliter',
          symbol: 'pg/mL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.651, // pmol/L to pg/mL: multiply by 0.651
        ),
      ],
    ),

    // Cortisol
    ConversionCategory(
      id: 'cortisol',
      name: 'Cortisol',
      description: 'Chuyển đổi đơn vị Cortisol',
      icon: 'stress_hormone',
      commonExample: 'nmol/L ↔ μg/dL',
      normalRange: 'Sáng: 171-536 nmol/L (6.2-19.4 μg/dL)\nTối: <276 nmol/L (<10 μg/dL)',
      clinicalSignificance: 'Đánh giá chức năng tuyến thượng thận. Cortisol tăng trong stress, hội chứng Cushing.',
      units: [
        ConversionUnit(
          id: 'cortisol_nmoll',
          name: 'Nanomoles per liter',
          symbol: 'nmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'cortisol_ugdl',
          name: 'Micrograms per deciliter',
          symbol: 'μg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.0362, // nmol/L to μg/dL: multiply by 0.0362
        ),
      ],
    ),

    // Testosterone
    ConversionCategory(
      id: 'testosterone',
      name: 'Testosterone',
      description: 'Chuyển đổi đơn vị Testosterone',
      icon: 'male_hormone',
      commonExample: 'nmol/L ↔ ng/dL',
      normalRange: 'Nam: 8.64-29 nmol/L (249-836 ng/dL)\nNữ: 0.7-2.8 nmol/L (20-81 ng/dL)',
      clinicalSignificance: 'Đánh giá chức năng sinh dục nam. Testosterone thấp trong suy sinh dục, cao trong u tuyến thượng thận.',
      units: [
        ConversionUnit(
          id: 'testo_nmoll',
          name: 'Nanomoles per liter',
          symbol: 'nmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'testo_ngdl',
          name: 'Nanograms per deciliter',
          symbol: 'ng/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 28.84, // nmol/L to ng/dL: multiply by 28.84
        ),
      ],
    ),

    // Estradiol
    ConversionCategory(
      id: 'estradiol',
      name: 'Estradiol',
      description: 'Chuyển đổi đơn vị Estradiol',
      icon: 'female_hormone',
      commonExample: 'pmol/L ↔ pg/mL',
      normalRange: 'Nữ chu kỳ: 46-607 pmol/L (12.5-166 pg/mL)\nMãn kinh: <183 pmol/L (<50 pg/mL)',
      clinicalSignificance: 'Đánh giá chức năng sinh dục nữ. Estradiol thay đổi theo chu kỳ kinh nguyệt, giảm sau mãn kinh.',
      units: [
        ConversionUnit(
          id: 'e2_pmoll',
          name: 'Picomoles per liter',
          symbol: 'pmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'e2_pgml',
          name: 'Picograms per milliliter',
          symbol: 'pg/mL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.2723, // pmol/L to pg/mL: multiply by 0.2723
        ),
      ],
    ),

    // LH (Luteinizing Hormone)
    ConversionCategory(
      id: 'lh',
      name: 'LH',
      description: 'Chuyển đổi đơn vị Luteinizing Hormone',
      icon: 'reproductive_hormone',
      commonExample: 'IU/L ↔ mIU/mL',
      normalRange: 'Nữ chu kỳ: 2.4-12.6 IU/L\nRụng trứng: 14-96 IU/L\nNam: 1.7-8.6 IU/L',
      clinicalSignificance: 'Đánh giá chức năng sinh dục. LH kích thích rụng trứng ở nữ và sản xuất testosterone ở nam.',
      units: [
        ConversionUnit(
          id: 'lh_iul',
          name: 'International units per liter',
          symbol: 'IU/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'lh_miuml',
          name: 'Milli international units per milliliter',
          symbol: 'mIU/mL',
          description: 'Đơn vị khác',
          conversionFactor: 1.0, // IU/L = mIU/mL
        ),
      ],
    ),

    // FSH (Follicle Stimulating Hormone)
    ConversionCategory(
      id: 'fsh',
      name: 'FSH',
      description: 'Chuyển đổi đơn vị Follicle Stimulating Hormone',
      icon: 'reproductive_hormone',
      commonExample: 'IU/L ↔ mIU/mL',
      normalRange: 'Nữ chu kỳ: 3.5-12.5 IU/L\nMãn kinh: 25.8-134.8 IU/L\nNam: 1.5-12.4 IU/L',
      clinicalSignificance: 'Đánh giá chức năng sinh dục. FSH kích thích phát triển noãn ở nữ và tinh trung ở nam.',
      units: [
        ConversionUnit(
          id: 'fsh_iul',
          name: 'International units per liter',
          symbol: 'IU/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'fsh_miuml',
          name: 'Milli international units per milliliter',
          symbol: 'mIU/mL',
          description: 'Đơn vị khác',
          conversionFactor: 1.0, // IU/L = mIU/mL
        ),
      ],
    ),

    // Prolactin
    ConversionCategory(
      id: 'prolactin',
      name: 'Prolactin',
      description: 'Chuyển đổi đơn vị Prolactin',
      icon: 'lactation_hormone',
      commonExample: 'μg/L ↔ ng/mL',
      normalRange: 'Nam: 4.04-15.2 μg/L (4.04-15.2 ng/mL)\nNữ: 4.79-23.3 μg/L (4.79-23.3 ng/mL)\nMang thai: 34.99-386 μg/L',
      clinicalSignificance: 'Đánh giá chức năng tuyến yên và khả năng tiết sữa. Prolactin tăng trong u tuyến yên.',
      units: [
        ConversionUnit(
          id: 'prl_ugl',
          name: 'Micrograms per liter',
          symbol: 'μg/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'prl_ngml',
          name: 'Nanograms per milliliter',
          symbol: 'ng/mL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0, // μg/L = ng/mL
        ),
      ],
    ),

    // Insulin
    ConversionCategory(
      id: 'insulin',
      name: 'Insulin',
      description: 'Chuyển đổi đơn vị Insulin',
      icon: 'diabetes_hormone',
      commonExample: 'pmol/L ↔ μIU/mL',
      normalRange: 'Đói: 18-173 pmol/L (2.6-24.9 μIU/mL)\nKháng insulin: >173 pmol/L (>25 μIU/mL)',
      clinicalSignificance: 'Đánh giá chuyển hóa glucose và kháng insulin. Insulin tăng trong kháng insulin và đái tháo đường type 2.',
      units: [
        ConversionUnit(
          id: 'insulin_pmoll',
          name: 'Picomoles per liter',
          symbol: 'pmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'insulin_uiuml',
          name: 'Micro international units per milliliter',
          symbol: 'μIU/mL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.1441, // pmol/L to μIU/mL: multiply by 0.1441
        ),
      ],
    ),

    // hCG (Human Chorionic Gonadotropin)
    ConversionCategory(
      id: 'hcg',
      name: 'hCG',
      description: 'Chuyển đổi đơn vị Human Chorionic Gonadotropin',
      icon: 'pregnancy_hormone',
      commonExample: 'IU/L ↔ mIU/mL',
      normalRange: 'Không mang thai: <5 IU/L\n4 tuần thai: 5-426 IU/L\n5 tuần thai: 18-7340 IU/L',
      clinicalSignificance: 'Chẩn đoán và theo dõi thai kỳ. hCG tăng trong mang thai và một số khối u.',
      units: [
        ConversionUnit(
          id: 'hcg_iul',
          name: 'International units per liter',
          symbol: 'IU/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'hcg_miuml',
          name: 'Milli international units per milliliter',
          symbol: 'mIU/mL',
          description: 'Đơn vị khác',
          conversionFactor: 1.0, // IU/L = mIU/mL
        ),
      ],
    ),

    // Vitamin D (25-OH)
    ConversionCategory(
      id: 'vitamin_d',
      name: 'Vitamin D (25-OH)',
      description: 'Chuyển đổi đơn vị 25-Hydroxyvitamin D',
      icon: 'vitamin_d',
      commonExample: 'nmol/L ↔ ng/mL',
      normalRange: 'Đủ: 75-250 nmol/L (30-100 ng/mL)\nThiếu: <50 nmol/L (<20 ng/mL)\nDư thừa: >250 nmol/L',
      clinicalSignificance: 'Đánh giá tình trạng vitamin D. Thiếu vitamin D gây loãng xương, yếu cơ.',
      units: [
        ConversionUnit(
          id: 'vitd_nmoll',
          name: 'Nanomoles per liter',
          symbol: 'nmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'vitd_ngml',
          name: 'Nanograms per milliliter',
          symbol: 'ng/mL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.4, // nmol/L to ng/mL: multiply by 0.4
        ),
      ],
    ),

    // B12
    ConversionCategory(
      id: 'vitamin_b12',
      name: 'Vitamin B12',
      description: 'Chuyển đổi đơn vị Vitamin B12',
      icon: 'vitamin_b12',
      commonExample: 'pmol/L ↔ pg/mL',
      normalRange: '148-616 pmol/L (200-835 pg/mL)\nThiếu: <148 pmol/L (<200 pg/mL)',
      clinicalSignificance: 'Đánh giá tình trạng vitamin B12. Thiếu B12 gây thiếu máu megaloblastic và tổn thương thần kinh.',
      units: [
        ConversionUnit(
          id: 'b12_pmoll',
          name: 'Picomoles per liter',
          symbol: 'pmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'b12_pgml',
          name: 'Picograms per milliliter',
          symbol: 'pg/mL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.355, // pmol/L to pg/mL: multiply by 1.355
        ),
      ],
    ),

    // Folate
    ConversionCategory(
      id: 'folate',
      name: 'Folate',
      description: 'Chuyển đổi đơn vị Folate (Folic Acid)',
      icon: 'folate',
      commonExample: 'nmol/L ↔ ng/mL',
      normalRange: '10-42.4 nmol/L (4.4-18.7 ng/mL)\nThiếu: <6.8 nmol/L (<3 ng/mL)',
      clinicalSignificance: 'Đánh giá tình trạng folate. Thiếu folate gây thiếu máu megaloblastic và dị tật ống thần kinh ở thai nhi.',
      units: [
        ConversionUnit(
          id: 'folate_nmoll',
          name: 'Nanomoles per liter',
          symbol: 'nmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'folate_ngml',
          name: 'Nanograms per milliliter',
          symbol: 'ng/mL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.441, // nmol/L to ng/mL: multiply by 0.441
        ),
      ],
    ),

    // Ferritin
    ConversionCategory(
      id: 'ferritin',
      name: 'Ferritin',
      description: 'Chuyển đổi đơn vị Ferritin',
      icon: 'iron_storage',
      commonExample: 'μg/L ↔ ng/mL',
      normalRange: 'Nam: 15-200 μg/L (15-200 ng/mL)\nNữ: 15-150 μg/L (15-150 ng/mL)\nThiếu sắt: <15 μg/L',
      clinicalSignificance: 'Đánh giá dự trữ sắt. Ferritin thấp trong thiếu sắt, cao trong viêm và tích tụ sắt.',
      units: [
        ConversionUnit(
          id: 'ferritin_ugl',
          name: 'Micrograms per liter',
          symbol: 'μg/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'ferritin_ngml',
          name: 'Nanograms per milliliter',
          symbol: 'ng/mL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0, // μg/L = ng/mL
        ),
      ],
    ),

    // Iron
    ConversionCategory(
      id: 'iron',
      name: 'Iron (Sắt huyết thanh)',
      description: 'Chuyển đổi đơn vị Iron',
      icon: 'iron',
      commonExample: 'μmol/L ↔ μg/dL',
      normalRange: 'Nam: 14-31 μmol/L (78-173 μg/dL)\nNữ: 11-29 μmol/L (61-162 μg/dL)',
      clinicalSignificance: 'Đánh giá tình trạng sắt. Iron thấp trong thiếu sắt, cao trong tích tụ sắt.',
      units: [
        ConversionUnit(
          id: 'iron_umoll',
          name: 'Micromoles per liter',
          symbol: 'μmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'iron_ugdl',
          name: 'Micrograms per deciliter',
          symbol: 'μg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 5.587, // μmol/L to μg/dL: multiply by 5.587
        ),
      ],
    ),

    // pH
    ConversionCategory(
      id: 'ph',
      name: 'pH (Blood Gas)',
      description: 'Đánh giá pH máu động mạch',
      icon: 'blood_gas',
      commonExample: 'pH 7.35-7.45',
      normalRange: '7.35-7.45\nToan: <7.35\nKiềm: >7.45',
      clinicalSignificance: 'Đánh giá cân bằng acid-base. pH thấp trong toan chuyển hóa/hô hấp, pH cao trong kiềm chuyển hóa/hô hấp.',
      units: [
        ConversionUnit(
          id: 'ph_units',
          name: 'pH units',
          symbol: 'pH',
          description: 'Đơn vị pH',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
      ],
    ),

    // PCO2
    ConversionCategory(
      id: 'pco2',
      name: 'PCO2',
      description: 'Chuyển đổi đơn vị Partial pressure of CO2',
      icon: 'blood_gas',
      commonExample: 'kPa ↔ mmHg',
      normalRange: '4.7-6.0 kPa (35-45 mmHg)\nTăng thông khí: <4.7 kPa\nGiảm thông khí: >6.0 kPa',
      clinicalSignificance: 'Đánh giá thông khí phổi. PCO2 cao trong giảm thông khí, thấp trong tăng thông khí.',
      units: [
        ConversionUnit(
          id: 'pco2_kpa',
          name: 'Kilopascals',
          symbol: 'kPa',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'pco2_mmhg',
          name: 'Millimeters of mercury',
          symbol: 'mmHg',
          description: 'Đơn vị thường dùng',
          conversionFactor: 7.5, // kPa to mmHg: multiply by 7.5
        ),
      ],
    ),

    // PO2
    ConversionCategory(
      id: 'po2',
      name: 'PO2',
      description: 'Chuyển đổi đơn vị Partial pressure of O2',
      icon: 'blood_gas',
      commonExample: 'kPa ↔ mmHg',
      normalRange: '10.6-13.3 kPa (80-100 mmHg)\nSuy hô hấp: <8.0 kPa (<60 mmHg)',
      clinicalSignificance: 'Đánh giá oxy hóa máu. PO2 thấp trong suy hô hấp, bệnh phổi.',
      units: [
        ConversionUnit(
          id: 'po2_kpa',
          name: 'Kilopascals',
          symbol: 'kPa',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'po2_mmhg',
          name: 'Millimeters of mercury',
          symbol: 'mmHg',
          description: 'Đơn vị thường dùng',
          conversionFactor: 7.5, // kPa to mmHg: multiply by 7.5
        ),
      ],
    ),

    // HCO3
    ConversionCategory(
      id: 'hco3',
      name: 'HCO3- (Bicarbonate)',
      description: 'Chuyển đổi đơn vị Bicarbonate',
      icon: 'blood_gas',
      commonExample: 'mmol/L ↔ mEq/L',
      normalRange: '22-26 mmol/L (22-26 mEq/L)\nToan chuyển hóa: <22 mmol/L\nKiềm chuyển hóa: >26 mmol/L',
      clinicalSignificance: 'Đánh giá cân bằng acid-base. HCO3- thấp trong toan chuyển hóa, cao trong kiềm chuyển hóa.',
      units: [
        ConversionUnit(
          id: 'hco3_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'hco3_meql',
          name: 'Milliequivalents per liter',
          symbol: 'mEq/L',
          description: 'Đơn vị khác',
          conversionFactor: 1.0, // mmol/L = mEq/L for HCO3-
        ),
      ],
    ),

    // Base Excess
    ConversionCategory(
      id: 'base_excess',
      name: 'Base Excess',
      description: 'Đánh giá Base Excess',
      icon: 'blood_gas',
      commonExample: 'mmol/L ↔ mEq/L',
      normalRange: '±2 mmol/L (±2 mEq/L)\nToan chuyển hóa: <-2 mmol/L\nKiềm chuyển hóa: >+2 mmol/L',
      clinicalSignificance: 'Đánh giá thành phần chuyển hóa của rối loạn acid-base. BE âm trong toan chuyển hóa, dương trong kiềm chuyển hóa.',
      units: [
        ConversionUnit(
          id: 'be_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'be_meql',
          name: 'Milliequivalents per liter',
          symbol: 'mEq/L',
          description: 'Đơn vị khác',
          conversionFactor: 1.0, // mmol/L = mEq/L for BE
        ),
      ],
    ),

    // HDL-C (High Density Lipoprotein Cholesterol)
    ConversionCategory(
      id: 'hdl_cholesterol',
      name: 'HDL-C (Cholesterol tốt)',
      description: 'Chuyển đổi đơn vị HDL Cholesterol',
      icon: 'hdl_cholesterol',
      commonExample: 'mmol/L ↔ mg/dL',
      normalRange: 'Nam: >1.0 mmol/L (>40 mg/dL)\nNữ: >1.3 mmol/L (>50 mg/dL)\nTối ưu: >1.6 mmol/L (>60 mg/dL)',
      clinicalSignificance: 'Đánh giá nguy cơ tim mạch. HDL-C cao có tác dụng bảo vệ tim mạch, HDL-C thấp tăng nguy cơ bệnh mạch vành.',
      units: [
        ConversionUnit(
          id: 'hdl_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'hdl_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 38.67, // mmol/L to mg/dL: multiply by 38.67
        ),
      ],
    ),

    // LDL-C (Low Density Lipoprotein Cholesterol)
    ConversionCategory(
      id: 'ldl_cholesterol',
      name: 'LDL-C (Cholesterol xấu)',
      description: 'Chuyển đổi đơn vị LDL Cholesterol',
      icon: 'ldl_cholesterol',
      commonExample: 'mmol/L ↔ mg/dL',
      normalRange: 'Tối ưu: <2.6 mmol/L (<100 mg/dL)\nCao: >4.1 mmol/L (>160 mg/dL)\nRất cao: >4.9 mmol/L (>190 mg/dL)',
      clinicalSignificance: 'Đánh giá nguy cơ tim mạch. LDL-C cao là yếu tố nguy cơ chính của bệnh mạch vành và đột quỵ.',
      units: [
        ConversionUnit(
          id: 'ldl_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'ldl_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 38.67, // mmol/L to mg/dL: multiply by 38.67
        ),
      ],
    ),

    // Uric Acid
    ConversionCategory(
      id: 'uric_acid',
      name: 'Acid Uric',
      description: 'Chuyển đổi đơn vị Acid Uric',
      icon: 'uric_acid',
      commonExample: 'μmol/L ↔ mg/dL',
      normalRange: 'Nam: 208-428 μmol/L (3.5-7.2 mg/dL)\nNữ: 155-357 μmol/L (2.6-6.0 mg/dL)\nGout: >535 μmol/L (>9.0 mg/dL)',
      clinicalSignificance: 'Chẩn đoán và theo dõi gout, sỏi thận. Acid uric cao gây gout và sỏi thận acid uric.',
      units: [
        ConversionUnit(
          id: 'uric_umoll',
          name: 'Micromoles per liter',
          symbol: 'μmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'uric_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.0168, // μmol/L to mg/dL: multiply by 0.0168
        ),
      ],
    ),

    // Calcium
    ConversionCategory(
      id: 'calcium',
      name: 'Canxi (Ca2+)',
      description: 'Chuyển đổi đơn vị Calcium',
      icon: 'calcium',
      commonExample: 'mmol/L ↔ mg/dL',
      normalRange: '2.20-2.65 mmol/L (8.8-10.6 mg/dL)\nHạ canxi: <2.20 mmol/L\nTăng canxi: >2.65 mmol/L',
      clinicalSignificance: 'Đánh giá chuyển hóa xương và parathyroid. Canxi thấp gây tetany, cao gây sỏi thận.',
      units: [
        ConversionUnit(
          id: 'ca_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'ca_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 4.008, // mmol/L to mg/dL: multiply by 4.008
        ),
      ],
    ),

    // Magnesium
    ConversionCategory(
      id: 'magnesium',
      name: 'Magie (Mg2+)',
      description: 'Chuyển đổi đơn vị Magnesium',
      icon: 'magnesium',
      commonExample: 'mmol/L ↔ mg/dL',
      normalRange: '0.70-1.05 mmol/L (1.7-2.5 mg/dL)\nHạ magie: <0.70 mmol/L\nTăng magie: >1.05 mmol/L',
      clinicalSignificance: 'Đánh giá chuyển hóa điện giải. Magie thấp gây co giật, rối loạn nhịp tim.',
      units: [
        ConversionUnit(
          id: 'mg_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'mg_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 2.431, // mmol/L to mg/dL: multiply by 2.431
        ),
      ],
    ),

    // Phosphate
    ConversionCategory(
      id: 'phosphate',
      name: 'Phosphat (PO43-)',
      description: 'Chuyển đổi đơn vị Phosphate',
      icon: 'phosphate',
      commonExample: 'mmol/L ↔ mg/dL',
      normalRange: '0.81-1.45 mmol/L (2.5-4.5 mg/dL)\nHạ phosphat: <0.81 mmol/L\nTăng phosphat: >1.45 mmol/L',
      clinicalSignificance: 'Đánh giá chuyển hóa xương và thận. Phosphat cao trong suy thận, thấp trong suy dinh dưỡng.',
      units: [
        ConversionUnit(
          id: 'po4_mmoll',
          name: 'Millimoles per liter',
          symbol: 'mmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'po4_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 3.097, // mmol/L to mg/dL: multiply by 3.097
        ),
      ],
    ),

    // Bilirubin Total
    ConversionCategory(
      id: 'bilirubin_total',
      name: 'Bilirubin toàn phần',
      description: 'Chuyển đổi đơn vị Bilirubin Total',
      icon: 'bilirubin',
      commonExample: 'μmol/L ↔ mg/dL',
      normalRange: '5-21 μmol/L (0.3-1.2 mg/dL)\nVàng da: >34 μmol/L (>2.0 mg/dL)\nNặng: >85 μmol/L (>5.0 mg/dL)',
      clinicalSignificance: 'Đánh giá chức năng gan và tán huyết. Bilirubin cao gây vàng da, vàng mắt.',
      units: [
        ConversionUnit(
          id: 'bili_umoll',
          name: 'Micromoles per liter',
          symbol: 'μmol/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'bili_mgdl',
          name: 'Milligrams per deciliter',
          symbol: 'mg/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.0585, // μmol/L to mg/dL: multiply by 0.0585
        ),
      ],
    ),

    // Albumin
    ConversionCategory(
      id: 'albumin',
      name: 'Albumin',
      description: 'Chuyển đổi đơn vị Albumin',
      icon: 'albumin',
      commonExample: 'g/L ↔ g/dL',
      normalRange: '35-50 g/L (3.5-5.0 g/dL)\nHạ albumin: <35 g/L (<3.5 g/dL)\nNặng: <25 g/L (<2.5 g/dL)',
      clinicalSignificance: 'Đánh giá chức năng gan và dinh dưỡng. Albumin thấp trong bệnh gan, suy dinh dưỡng.',
      units: [
        ConversionUnit(
          id: 'alb_gl',
          name: 'Grams per liter',
          symbol: 'g/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'alb_gdl',
          name: 'Grams per deciliter',
          symbol: 'g/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.1, // g/L to g/dL: multiply by 0.1
        ),
      ],
    ),

    // Total Protein
    ConversionCategory(
      id: 'total_protein',
      name: 'Total Protein',
      description: 'Chuyển đổi đơn vị Total Protein',
      icon: 'total_protein',
      commonExample: 'g/L ↔ g/dL',
      normalRange: '60-83 g/L (6.0-8.3 g/dL)\nThấp: <60 g/L (<6.0 g/dL)\nCao: >83 g/L (>8.3 g/dL)',
      clinicalSignificance: 'Đánh giá chức năng gan và tình trạng dinh dưỡng. Protein thấp trong bệnh gan, thận.',
      units: [
        ConversionUnit(
          id: 'tp_gl',
          name: 'Grams per liter',
          symbol: 'g/L',
          description: 'Đơn vị SI',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'tp_gdl',
          name: 'Grams per deciliter',
          symbol: 'g/dL',
          description: 'Đơn vị thường dùng',
          conversionFactor: 0.1, // g/L to g/dL: multiply by 0.1
        ),
      ],
    ),

    // SGOT (AST)
    ConversionCategory(
      id: 'sgot_ast',
      name: 'SGOT (AST)',
      description: 'Chuyển đổi đơn vị Aspartate aminotransferase',
      icon: 'liver_enzyme',
      commonExample: 'U/L ↔ IU/L',
      normalRange: 'Nam: 15-40 U/L\nNữ: 13-35 U/L\nTổn thương gan: >3x bình thường',
      clinicalSignificance: 'Đánh giá tổn thương gan và tim. AST tăng trong viêm gan, nhồi máu cơ tim.',
      units: [
        ConversionUnit(
          id: 'ast_ul',
          name: 'Units per liter',
          symbol: 'U/L',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'ast_iul',
          name: 'International units per liter',
          symbol: 'IU/L',
          description: 'Đơn vị quốc tế',
          conversionFactor: 1.0, // U/L = IU/L
        ),
      ],
    ),

    // SGPT (ALT)
    ConversionCategory(
      id: 'sgpt_alt',
      name: 'SGPT (ALT)',
      description: 'Chuyển đổi đơn vị Alanine aminotransferase',
      icon: 'liver_enzyme',
      commonExample: 'U/L ↔ IU/L',
      normalRange: 'Nam: 10-40 U/L\nNữ: 7-35 U/L\nViêm gan: >2x bình thường',
      clinicalSignificance: 'Đánh giá tổn thương gan. ALT đặc hiệu cho gan hơn AST, tăng trong viêm gan.',
      units: [
        ConversionUnit(
          id: 'alt_ul',
          name: 'Units per liter',
          symbol: 'U/L',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'alt_iul',
          name: 'International units per liter',
          symbol: 'IU/L',
          description: 'Đơn vị quốc tế',
          conversionFactor: 1.0, // U/L = IU/L
        ),
      ],
    ),

    // ALP (Alkaline Phosphatase)
    ConversionCategory(
      id: 'alp',
      name: 'ALP',
      description: 'Chuyển đổi đơn vị Alkaline Phosphatase',
      icon: 'bone_liver_enzyme',
      commonExample: 'U/L ↔ IU/L',
      normalRange: 'Người lớn: 40-150 U/L\nTrẻ em: 100-320 U/L\nTăng: bệnh xương, gan',
      clinicalSignificance: 'Đánh giá bệnh gan và xương. ALP tăng trong bệnh xương, tắc mật.',
      units: [
        ConversionUnit(
          id: 'alp_ul',
          name: 'Units per liter',
          symbol: 'U/L',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'alp_iul',
          name: 'International units per liter',
          symbol: 'IU/L',
          description: 'Đơn vị quốc tế',
          conversionFactor: 1.0, // U/L = IU/L
        ),
      ],
    ),

    // GGT (Gamma-glutamyl transferase)
    ConversionCategory(
      id: 'ggt',
      name: 'GGT',
      description: 'Chuyển đổi đơn vị Gamma-glutamyl transferase',
      icon: 'liver_enzyme',
      commonExample: 'U/L ↔ IU/L',
      normalRange: 'Nam: 11-50 U/L\nNữ: 7-32 U/L\nRượu bia: >3x bình thường',
      clinicalSignificance: 'Đánh giá bệnh gan và rượu bia. GGT tăng sớm trong tổn thương gan do rượu.',
      units: [
        ConversionUnit(
          id: 'ggt_ul',
          name: 'Units per liter',
          symbol: 'U/L',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'ggt_iul',
          name: 'International units per liter',
          symbol: 'IU/L',
          description: 'Đơn vị quốc tế',
          conversionFactor: 1.0, // U/L = IU/L
        ),
      ],
    ),

    // Microalbumin/Creatinine ratio
    ConversionCategory(
      id: 'microalbumin_creatinine',
      name: 'Microalbumin/Creatinine niệu',
      description: 'Chuyển đổi đơn vị tỷ lệ Microalbumin/Creatinine',
      icon: 'kidney_function',
      commonExample: 'mg/g ↔ mg/mmol',
      normalRange: '<30 mg/g (<3.4 mg/mmol)\nTăng nhẹ: 30-300 mg/g\nNặng: >300 mg/g',
      clinicalSignificance: 'Sàng lọc bệnh thận tiểu đường. Tỷ lệ này phát hiện sớm tổn thương thận.',
      units: [
        ConversionUnit(
          id: 'malb_mgg',
          name: 'Milligrams per gram',
          symbol: 'mg/g',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'malb_mgmmol',
          name: 'Milligrams per millimole',
          symbol: 'mg/mmol',
          description: 'Đơn vị SI',
          conversionFactor: 0.113, // mg/g to mg/mmol: multiply by 0.113
        ),
      ],
    ),

    // Protein/Creatinine ratio
    ConversionCategory(
      id: 'protein_creatinine',
      name: 'Protein/Creatinine niệu',
      description: 'Chuyển đổi đơn vị tỷ lệ Protein/Creatinine',
      icon: 'kidney_function',
      commonExample: 'mg/g ↔ mg/mmol',
      normalRange: '<150 mg/g (<15 mg/mmol)\nBất thường: >150 mg/g\nNặng: >3500 mg/g',
      clinicalSignificance: 'Đánh giá protein niệu. Tỷ lệ này thay thế thu thập nước tiểu 24h.',
      units: [
        ConversionUnit(
          id: 'prot_mgg',
          name: 'Milligrams per gram',
          symbol: 'mg/g',
          description: 'Đơn vị thường dùng',
          conversionFactor: 1.0,
          isBaseUnit: true,
        ),
        ConversionUnit(
          id: 'prot_mgmmol',
          name: 'Milligrams per millimole',
          symbol: 'mg/mmol',
          description: 'Đơn vị SI',
          conversionFactor: 0.113, // mg/g to mg/mmol: multiply by 0.113
        ),
      ],
    ),
  ];

  @override
  Future<List<ConversionCategory>> getCategories() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    return _categories;
  }

  @override
  Future<List<ConversionUnit>> getUnitsInCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final category = _categories.firstWhere((cat) => cat.id == categoryId,
        orElse: () => throw Exception('Category not found'));
    return category.units;
  }

  @override
  Future<ConversionResult> convertUnits({
    required String categoryId,
    required String fromUnitId,
    required String toUnitId,
    required double inputValue,
  }) async {
    await Future.delayed(const Duration(milliseconds: 50));

    final category = _categories.firstWhere((cat) => cat.id == categoryId,
        orElse: () => throw Exception('Category not found'));

    final fromUnit = category.units.firstWhere((unit) => unit.id == fromUnitId,
        orElse: () => throw Exception('From unit not found'));

    final toUnit = category.units.firstWhere((unit) => unit.id == toUnitId,
        orElse: () => throw Exception('To unit not found'));

    double outputValue;

    // Special handling for HbA1c
    if (categoryId == 'hba1c') {
      if (fromUnit.symbol == '%' && toUnit.symbol == 'mmol/mol') {
        outputValue = (inputValue * 10.93) - 23.5;
      } else if (fromUnit.symbol == 'mmol/mol' && toUnit.symbol == '%') {
        outputValue = (inputValue + 23.5) / 10.93;
      } else {
        outputValue = inputValue; // Same unit
      }
    } else {
      // Standard conversion: Convert via base unit
      double baseValue;
      
      // Step 1: Convert from input unit to base unit
      if (fromUnit.isBaseUnit) {
        baseValue = inputValue;
      } else {
        baseValue = inputValue / fromUnit.conversionFactor;
      }
      
      // Step 2: Convert from base unit to target unit
      if (toUnit.isBaseUnit) {
        outputValue = baseValue;
      } else {
        outputValue = baseValue * toUnit.conversionFactor;
      }
    }

    // Generate result analysis
    final resultAnalysis = category.analyzeResult(outputValue, toUnit.symbol);

    return ConversionResult(
      categoryId: categoryId,
      fromUnit: fromUnit,
      toUnit: toUnit,
      inputValue: inputValue,
      outputValue: outputValue,
      resultAnalysis: resultAnalysis,
    );
  }
}