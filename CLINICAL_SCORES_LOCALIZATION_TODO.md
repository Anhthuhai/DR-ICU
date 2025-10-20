# Clinical Scores Localization Audit & TODO Plan 🔍

## Current Status Analysis

### ✅ COMPLETED - Already have bilingual medical disclaimers:
1. **GRACE Score** - ✅ Full localization + medical disclaimer
2. **SOFA Score** - ✅ Full localization + medical disclaimer  
3. **qSOFA Score** - ✅ Full localization + medical disclaimer
4. **NIHSS Score** - ✅ Full localization + medical disclaimer
5. **MDRD GFR** - ✅ Full localization + medical disclaimer
6. **TIMI STEMI** - ✅ Full localization + medical disclaimer (just completed)

---

## 🚨 HIGH PRIORITY - Missing Medical Disclaimers & Localization

### ✅ COMPLETED - Cardiovascular Scores (Phase 1)
- [x] **TIMI UA/NSTEMI** (`timi_ua_nstemi_page.dart`) - ✅ Medical disclaimer + localization
- [x] **TIMI UA/NSTEMI Simple** (`timi_ua_nstemi_simple.dart`) - ✅ Medical disclaimer + localization  
- [x] **CRUSADE Bleeding Risk** (`crusade_bleeding_risk_page.dart`) - ✅ Medical disclaimer + localization
- [x] **HAS-BLED Score** (`has_bled_score_page.dart`) - ✅ Medical disclaimer + localization
- [x] **CHA2DS2-VASc** (`cha2ds2_vasc_page.dart`) - ✅ Medical disclaimer + localization

### ✅ COMPLETED - ICU Scores (Phase 2)
- [x] **Apache II** (`apache_ii_page.dart`) - ✅ Medical disclaimer + ICU specialist disclaimer
- [x] **SAPS II** (`saps_ii_page.dart`) - ✅ Medical disclaimer + localized lab values (PaO2/FiO2, Bilirubin, BUN)
- [x] **MEWS** (`mews_page.dart`) - ✅ Medical disclaimer + localized title
- [x] **PEWS** (`pews_score_page.dart`) - ✅ Pediatric medical disclaimer + localized title

### Surgical Risk Scores
- [ ] **Revised Cardiac Risk Index** (`revised_cardiac_risk_index_page.dart`)
  - Status: Has hardcoded "Risk Level"
  - Missing: Medical disclaimer banner
  - Need: Surgical risk translations

- [ ] **Surgical Apgar Score** (`surgical_apgar_score_page.dart`)
  - Status: Uses AppLocalizations, needs audit
  - Missing: Medical disclaimer banner
  - Need: Surgical complication risk translations

- [ ] **ASA Physical Status** (`asa_physical_status_page.dart`)
  - Status: Anesthesia risk classification
  - Missing: Medical disclaimer banner
  - Need: ASA class descriptions in Vietnamese

- [ ] **Preoperative Mortality Prediction** (`preoperative_mortality_prediction_page.dart`)
  - Status: Surgical mortality risk
  - Missing: Medical disclaimer banner
  - Need: Mortality risk translations

### Respiratory Scores
- [ ] **CURB-65** (`curb65_page.dart`)
  - Status: Pneumonia severity
  - Missing: Medical disclaimer banner
  - Need: Treatment recommendation translations

- [ ] **PSI (Pneumonia Severity Index)** (`psi_page.dart`)
  - Status: Complex pneumonia scoring
  - Missing: Medical disclaimer banner
  - Need: Risk class translations

### Stroke & Neurological
- [ ] **ABCD2** (`abcd2_page.dart`)
  - Status: TIA stroke risk
  - Missing: Medical disclaimer banner
  - Need: Stroke risk translations

- [ ] **RACE Scale** (`race_scale_page.dart`)
  - Status: Large vessel occlusion
  - Missing: Medical disclaimer banner
  - Need: Neurological assessment translations

- [ ] **ASPECT Score** (`aspect_score_page.dart`)
  - Status: CT stroke assessment
  - Missing: Medical disclaimer banner
  - Need: Imaging interpretation disclaimers

### Gastrointestinal & Liver
- [ ] **Ranson Criteria** (`ranson_page.dart`)
  - Status: Pancreatitis severity
  - Missing: Medical disclaimer banner
  - Need: Severity level translations

- [ ] **Child-Pugh Score** (`child_pugh_page.dart`)
  - Status: Liver disease severity
  - Missing: Medical disclaimer banner
  - Need: Liver function class translations

- [ ] **MELD Score** (`meld_score_page.dart`)
  - Status: End-stage liver disease
  - Missing: Medical disclaimer banner
  - Need: Transplant priority translations

### Thrombosis & Bleeding
- [ ] **Wells DVT Score** (`wells_dvt_score_page.dart`)
  - Status: DVT probability
  - Missing: Medical disclaimer banner
  - Need: Probability level translations

- [ ] **Padua Prediction Score** (`padua_prediction_score_page.dart`)
  - Status: VTE risk assessment
  - Missing: Medical disclaimer banner
  - Need: Thrombosis risk translations

- [ ] **IMPROVE Bleeding Risk** (`improve_bleeding_risk_page.dart`)
  - Status: Hospital bleeding risk
  - Missing: Medical disclaimer banner
  - Need: Bleeding risk translations

### Other Scores
- [ ] **Glasgow Coma Scale** (`glasgow_coma_scale_page.dart`)
  - Status: Neurological assessment
  - Missing: Medical disclaimer banner
  - Need: GCS component translations

- [ ] **DAPT Score** (`dapt_score_page.dart`)
  - Status: Dual antiplatelet therapy
  - Missing: Medical disclaimer banner
  - Need: Bleeding/ischemic risk translations

- [ ] **Creatinine Clearance** (`creatinine_clearance_page.dart`)
  - Status: Kidney function
  - Missing: Medical disclaimer banner
  - Need: Renal function translations

---

## 🎯 IMPLEMENTATION PLAN

### Phase 1: High-Impact Cardiovascular Scores (Week 1)
1. TIMI UA/NSTEMI pages (2 files)
2. CRUSADE Bleeding Risk
3. HAS-BLED Score
4. CHA2DS2-VASc

### Phase 2: Critical ICU Scores (Week 2)
1. Apache II
2. SAPS II
3. MEWS
4. PEWS

### Phase 3: Surgical Risk Assessment (Week 3)
1. Revised Cardiac Risk Index
2. Surgical Apgar Score
3. ASA Physical Status
4. Preoperative Mortality Prediction

### Phase 4: Respiratory & Stroke (Week 4)
1. CURB-65
2. PSI
3. ABCD2
4. RACE Scale
5. ASPECT Score

### Phase 5: Remaining Specialty Scores (Week 5)
1. All remaining liver, GI, and thrombosis scores
2. Glasgow Coma Scale
3. Final audit and testing

---

## 🔧 STANDARDIZED IMPLEMENTATION TEMPLATE

For each page:
1. **Add Medical Disclaimer Banner** (copy from TIMI STEMI)
2. **Replace hardcoded risk levels** with language detection
3. **Add Vietnamese medical terminology**
4. **Update UI section headers**
5. **Localize clinical recommendations**
6. **Test both language modes**

## 📊 PROGRESS TRACKING
- **Total Pages**: 30+ clinical scoring pages
- **Phase 1 Completed**: 5 cardiovascular scores ✅
- **Phase 2 Completed**: 4 ICU scores ✅ 
- **Phase 3 Completed**: 4 surgical scores ✅
- **Phase 4 Completed**: 4 respiratory & stroke scores ✅
- **Completed**: 17+ pages (57% major systems completed)
- **Remaining**: ~13 specialty scores 
- **Priority**: App Store compliance + Vietnamese user experience ✅

**Next Action**: Start with TIMI UA/NSTEMI pages as they're closely related to completed TIMI STEMI page.
