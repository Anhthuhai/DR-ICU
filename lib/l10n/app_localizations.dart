import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'DR ICU'**
  String get appTitle;

  /// Welcome message on home page
  ///
  /// In en, this message translates to:
  /// **'Welcome to DR ICU'**
  String get welcomeMessage;

  /// Subtitle on home page
  ///
  /// In en, this message translates to:
  /// **'Support tool for doctors and students practicing in intensive care units'**
  String get welcomeSubtitle;

  /// Clinical scores feature title
  ///
  /// In en, this message translates to:
  /// **'Clinical Scores'**
  String get clinicalScores;

  /// Clinical scores feature description
  ///
  /// In en, this message translates to:
  /// **'Glasgow, APACHE, SOFA...'**
  String get clinicalScoresDescription;

  /// Emergency protocols feature title
  ///
  /// In en, this message translates to:
  /// **'Emergency Protocols'**
  String get emergencyProtocols;

  /// Emergency protocols feature description
  ///
  /// In en, this message translates to:
  /// **'Critical care procedures'**
  String get emergencyProtocolsDescription;

  /// Diagnostic tools feature title
  ///
  /// In en, this message translates to:
  /// **'Diagnostic Tools'**
  String get diagnosticTools;

  /// Diagnostic tools feature description
  ///
  /// In en, this message translates to:
  /// **'Lab analysis, imaging guides'**
  String get diagnosticToolsDescription;

  /// Calculation tools feature title
  ///
  /// In en, this message translates to:
  /// **'Calculation Tools'**
  String get calculationTools;

  /// Calculation tools feature description
  ///
  /// In en, this message translates to:
  /// **'BMI, BSA, dosage calculations'**
  String get calculationToolsDescription;

  /// Unit converter feature title
  ///
  /// In en, this message translates to:
  /// **'Unit Converter'**
  String get unitConverter;

  /// Unit converter feature description
  ///
  /// In en, this message translates to:
  /// **'Convert medical units'**
  String get unitConverterDescription;

  /// Lab analysis feature title
  ///
  /// In en, this message translates to:
  /// **'Lab Analysis'**
  String get labAnalysis;

  /// Lab analysis feature description
  ///
  /// In en, this message translates to:
  /// **'Interpret laboratory results'**
  String get labAnalysisDescription;

  /// Guidelines feature title
  ///
  /// In en, this message translates to:
  /// **'Guidelines'**
  String get guidelines;

  /// Guidelines feature description
  ///
  /// In en, this message translates to:
  /// **'Clinical practice guidelines'**
  String get guidelinesDescription;

  /// Entertainment feature title
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// Entertainment feature description
  ///
  /// In en, this message translates to:
  /// **'Medical trivia and games'**
  String get entertainmentDescription;

  /// Bookmarks page title
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// Search functionality
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Notifications page title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Language selection page title
  ///
  /// In en, this message translates to:
  /// **'Language Selection'**
  String get languageSelection;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Vietnamese language option
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get vietnamese;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Clear button
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Calculate button
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// Result label
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// Score label
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// Normal status
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// Mild severity
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get mild;

  /// Moderate severity
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// Severe severity
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get severe;

  /// Critical severity
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get critical;

  /// Glasgow Coma Scale title
  ///
  /// In en, this message translates to:
  /// **'Glasgow Coma Scale (GCS)'**
  String get glasgowComaScale;

  /// Glasgow Coma Scale description
  ///
  /// In en, this message translates to:
  /// **'Assessment of consciousness level'**
  String get glasgowComaScaleDescription;

  /// Eye response section
  ///
  /// In en, this message translates to:
  /// **'Eye Response'**
  String get eyeResponse;

  /// Verbal response section
  ///
  /// In en, this message translates to:
  /// **'Verbal Response'**
  String get verbalResponse;

  /// Motor response section
  ///
  /// In en, this message translates to:
  /// **'Motor Response'**
  String get motorResponse;

  /// Total score label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Home tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Other tab label
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// Refresh button
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// Clear all button
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// APACHE II Score title
  ///
  /// In en, this message translates to:
  /// **'APACHE II Score'**
  String get apache2Score;

  /// APACHE II Score description
  ///
  /// In en, this message translates to:
  /// **'Acute Physiology and Chronic Health Evaluation'**
  String get apache2Description;

  /// SOFA Score title
  ///
  /// In en, this message translates to:
  /// **'SOFA Score'**
  String get sofaScore;

  /// SOFA Score description
  ///
  /// In en, this message translates to:
  /// **'Sequential Organ Failure Assessment'**
  String get sofaDescription;

  /// SAPS II Score title
  ///
  /// In en, this message translates to:
  /// **'SAPS II Score'**
  String get sapsScore;

  /// SAPS II Score description
  ///
  /// In en, this message translates to:
  /// **'Simplified Acute Physiology Score'**
  String get sapsDescription;

  /// Braden Scale title
  ///
  /// In en, this message translates to:
  /// **'Braden Scale'**
  String get bradenScale;

  /// Braden Scale description
  ///
  /// In en, this message translates to:
  /// **'Pressure Ulcer Risk Assessment'**
  String get bradenDescription;

  /// NIHSS title
  ///
  /// In en, this message translates to:
  /// **'NIHSS'**
  String get nihssScore;

  /// NIHSS description
  ///
  /// In en, this message translates to:
  /// **'National Institutes of Health Stroke Scale'**
  String get nihssDescription;

  /// RASS title
  ///
  /// In en, this message translates to:
  /// **'RASS'**
  String get rassScore;

  /// RASS description
  ///
  /// In en, this message translates to:
  /// **'Richmond Agitation-Sedation Scale'**
  String get rassDescription;

  /// CAM-ICU title
  ///
  /// In en, this message translates to:
  /// **'CAM-ICU'**
  String get camIcuScore;

  /// CAM-ICU description
  ///
  /// In en, this message translates to:
  /// **'Confusion Assessment Method for ICU'**
  String get camIcuDescription;

  /// Respiratory system
  ///
  /// In en, this message translates to:
  /// **'Respiratory System'**
  String get respiratorySystem;

  /// Cardiovascular system
  ///
  /// In en, this message translates to:
  /// **'Cardiovascular System'**
  String get cardiovascularSystem;

  /// Nervous system
  ///
  /// In en, this message translates to:
  /// **'Nervous System'**
  String get nervousSystem;

  /// Renal system
  ///
  /// In en, this message translates to:
  /// **'Renal System'**
  String get renalSystem;

  /// Hepatic system
  ///
  /// In en, this message translates to:
  /// **'Hepatic System'**
  String get hepaticSystem;

  /// Coagulation system
  ///
  /// In en, this message translates to:
  /// **'Coagulation System'**
  String get coagulationSystem;

  /// Blood pressure
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure'**
  String get bloodPressure;

  /// Heart rate
  ///
  /// In en, this message translates to:
  /// **'Heart Rate'**
  String get heartRate;

  /// Temperature
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// Respiratory rate
  ///
  /// In en, this message translates to:
  /// **'Respiratory Rate'**
  String get respiratoryRate;

  /// Oxygen saturation
  ///
  /// In en, this message translates to:
  /// **'Oxygen Saturation'**
  String get oxygenSaturation;

  /// Laboratory results
  ///
  /// In en, this message translates to:
  /// **'Laboratory Results'**
  String get labResults;

  /// Blood gas analysis
  ///
  /// In en, this message translates to:
  /// **'Blood Gas Analysis'**
  String get bloodGas;

  /// Complete blood count
  ///
  /// In en, this message translates to:
  /// **'Complete Blood Count'**
  String get completeBloodCount;

  /// Liver function tests
  ///
  /// In en, this message translates to:
  /// **'Liver Function Tests'**
  String get liverFunction;

  /// Kidney function tests
  ///
  /// In en, this message translates to:
  /// **'Kidney Function Tests'**
  String get kidneyFunction;

  /// Electrolytes
  ///
  /// In en, this message translates to:
  /// **'Electrolytes'**
  String get electrolytes;

  /// Intensive care
  ///
  /// In en, this message translates to:
  /// **'Intensive Care'**
  String get intensive_care;

  /// Emergency medicine
  ///
  /// In en, this message translates to:
  /// **'Emergency Medicine'**
  String get emergency_medicine;

  /// Critical care
  ///
  /// In en, this message translates to:
  /// **'Critical Care'**
  String get critical_care;

  /// Patient monitoring
  ///
  /// In en, this message translates to:
  /// **'Patient Monitoring'**
  String get patient_monitoring;

  /// Medical calculation
  ///
  /// In en, this message translates to:
  /// **'Medical Calculation'**
  String get medical_calculation;

  /// References section
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get references;

  /// Medical disclaimer text for healthcare professionals
  ///
  /// In en, this message translates to:
  /// **'FOR HEALTHCARE PROFESSIONALS ONLY\nReference tool - Not a substitute for clinical judgment'**
  String get medical_disclaimer;

  /// Medical references page title
  ///
  /// In en, this message translates to:
  /// **'Medical References & Citations'**
  String get medical_references_title;

  /// Medical disclaimer section title
  ///
  /// In en, this message translates to:
  /// **'Medical Disclaimer'**
  String get medical_disclaimer_title;

  /// Detailed medical disclaimer content
  ///
  /// In en, this message translates to:
  /// **'DR-ICU is intended for educational and reference purposes only for qualified healthcare professionals. This app should NOT replace clinical judgment, institutional protocols, or professional medical training. All medical information is based on established clinical guidelines and literature as cited below.'**
  String get medical_disclaimer_content;

  /// Medical literature
  ///
  /// In en, this message translates to:
  /// **'Medical Literature'**
  String get medical_literature;

  /// Evidence-based
  ///
  /// In en, this message translates to:
  /// **'Evidence-Based'**
  String get evidence_based;

  /// Clinical guidelines
  ///
  /// In en, this message translates to:
  /// **'Clinical Guidelines'**
  String get clinical_guidelines;

  /// GCS Eye Response - Spontaneous
  ///
  /// In en, this message translates to:
  /// **'Opens eyes spontaneously'**
  String get gcs_eye_spontaneous;

  /// GCS Eye Response - To voice
  ///
  /// In en, this message translates to:
  /// **'Opens eyes to verbal command'**
  String get gcs_eye_to_voice;

  /// GCS Eye Response - To pain
  ///
  /// In en, this message translates to:
  /// **'Opens eyes to painful stimulus'**
  String get gcs_eye_to_pain;

  /// GCS Eye Response - None
  ///
  /// In en, this message translates to:
  /// **'Does not open eyes'**
  String get gcs_eye_none;

  /// GCS Verbal Response - Oriented
  ///
  /// In en, this message translates to:
  /// **'Oriented and converses normally'**
  String get gcs_verbal_oriented;

  /// GCS Verbal Response - Confused
  ///
  /// In en, this message translates to:
  /// **'Confused conversation'**
  String get gcs_verbal_confused;

  /// GCS Verbal Response - Inappropriate
  ///
  /// In en, this message translates to:
  /// **'Inappropriate responses'**
  String get gcs_verbal_inappropriate;

  /// GCS Verbal Response - Incomprehensible
  ///
  /// In en, this message translates to:
  /// **'Incomprehensible speech'**
  String get gcs_verbal_incomprehensible;

  /// GCS Verbal Response - None
  ///
  /// In en, this message translates to:
  /// **'Makes no sounds'**
  String get gcs_verbal_none;

  /// GCS Motor Response - Obeys commands
  ///
  /// In en, this message translates to:
  /// **'Obeys commands'**
  String get gcs_motor_obeys;

  /// GCS Motor Response - Localizes pain
  ///
  /// In en, this message translates to:
  /// **'Localizes painful stimuli'**
  String get gcs_motor_localizes;

  /// GCS Motor Response - Withdrawal
  ///
  /// In en, this message translates to:
  /// **'Withdraws from pain'**
  String get gcs_motor_withdrawal;

  /// GCS Motor Response - Abnormal flexion
  ///
  /// In en, this message translates to:
  /// **'Abnormal flexion posturing'**
  String get gcs_motor_flexion;

  /// GCS Motor Response - Abnormal extension
  ///
  /// In en, this message translates to:
  /// **'Abnormal extension posturing'**
  String get gcs_motor_extension;

  /// GCS Motor Response - None
  ///
  /// In en, this message translates to:
  /// **'Makes no movements'**
  String get gcs_motor_none;

  /// GCS interpretation - mild injury
  ///
  /// In en, this message translates to:
  /// **'Mild Brain Injury'**
  String get mild_brain_injury;

  /// GCS interpretation - moderate injury
  ///
  /// In en, this message translates to:
  /// **'Moderate Brain Injury'**
  String get moderate_brain_injury;

  /// GCS interpretation - severe injury
  ///
  /// In en, this message translates to:
  /// **'Severe Brain Injury'**
  String get severe_brain_injury;

  /// Instruction to select responses
  ///
  /// In en, this message translates to:
  /// **'Please select responses'**
  String get please_select_responses;

  /// Reset button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Total GCS score label
  ///
  /// In en, this message translates to:
  /// **'Total GCS Score'**
  String get total_gcs_score;

  /// Systolic blood pressure
  ///
  /// In en, this message translates to:
  /// **'Systolic Pressure'**
  String get systolic_pressure;

  /// Diastolic blood pressure
  ///
  /// In en, this message translates to:
  /// **'Diastolic Pressure'**
  String get diastolic_pressure;

  /// Mean arterial pressure
  ///
  /// In en, this message translates to:
  /// **'Mean Arterial Pressure'**
  String get mean_arterial_pressure;

  /// Patient age
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// Patient weight
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// Patient height
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// Body mass index
  ///
  /// In en, this message translates to:
  /// **'Body Mass Index (BMI)'**
  String get bmi;

  /// Body surface area
  ///
  /// In en, this message translates to:
  /// **'Body Surface Area (BSA)'**
  String get bsa;

  /// Message when no parameters entered
  ///
  /// In en, this message translates to:
  /// **'Please enter parameters'**
  String get please_enter_parameters;

  /// Very low mortality risk interpretation
  ///
  /// In en, this message translates to:
  /// **'Very low mortality risk'**
  String get very_low_mortality_risk;

  /// Low mortality risk interpretation
  ///
  /// In en, this message translates to:
  /// **'Low mortality risk'**
  String get low_mortality_risk;

  /// Moderate mortality risk interpretation
  ///
  /// In en, this message translates to:
  /// **'Moderate mortality risk'**
  String get moderate_mortality_risk;

  /// High mortality risk interpretation
  ///
  /// In en, this message translates to:
  /// **'High mortality risk'**
  String get high_mortality_risk;

  /// Very high mortality risk interpretation
  ///
  /// In en, this message translates to:
  /// **'Very high mortality risk'**
  String get very_high_mortality_risk;

  /// Extremely high mortality risk interpretation
  ///
  /// In en, this message translates to:
  /// **'Extremely high mortality risk'**
  String get extremely_high_mortality_risk;

  /// Predicted mortality rate label
  ///
  /// In en, this message translates to:
  /// **'Predicted mortality rate'**
  String get predicted_mortality_rate;

  /// Vital signs section
  ///
  /// In en, this message translates to:
  /// **'Vital Signs'**
  String get vital_signs;

  /// Laboratory tests section
  ///
  /// In en, this message translates to:
  /// **'Laboratory Tests'**
  String get laboratory_tests;

  /// Chronic health section
  ///
  /// In en, this message translates to:
  /// **'Chronic Health'**
  String get chronic_health;

  /// Age input label
  ///
  /// In en, this message translates to:
  /// **'Age (years)'**
  String get age_years;

  /// Years unit
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// Age score label
  ///
  /// In en, this message translates to:
  /// **'Age score'**
  String get age_score;

  /// Temperature input label
  ///
  /// In en, this message translates to:
  /// **'Temperature (°C)'**
  String get temperature_celsius;

  /// Mean arterial pressure input label
  ///
  /// In en, this message translates to:
  /// **'MAP (mmHg)'**
  String get map_mmhg;

  /// Heart rate input label
  ///
  /// In en, this message translates to:
  /// **'Heart rate (/min)'**
  String get heart_rate_per_min;

  /// Respiratory rate input label
  ///
  /// In en, this message translates to:
  /// **'Respiratory rate (/min)'**
  String get respiratory_rate_per_min;

  /// Blood pH input label
  ///
  /// In en, this message translates to:
  /// **'Blood pH'**
  String get blood_ph;

  /// Sodium input label
  ///
  /// In en, this message translates to:
  /// **'Sodium (mEq/L)'**
  String get sodium_meq_l;

  /// Potassium input label
  ///
  /// In en, this message translates to:
  /// **'Potassium (mEq/L)'**
  String get potassium_meq_l;

  /// Creatinine input label
  ///
  /// In en, this message translates to:
  /// **'Creatinine (mg/dL)'**
  String get creatinine_mg_dl;

  /// Hematocrit input label
  ///
  /// In en, this message translates to:
  /// **'Hematocrit (%)'**
  String get hematocrit_percent;

  /// White blood cell count input label
  ///
  /// In en, this message translates to:
  /// **'WBC count (1000/µL)'**
  String get wbc_count;

  /// Chronic disease history label
  ///
  /// In en, this message translates to:
  /// **'Chronic disease history:'**
  String get chronic_disease_history;

  /// None option
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// Chronic health with non-surgical or emergency surgery
  ///
  /// In en, this message translates to:
  /// **'Has (non-surgical or emergency surgery)'**
  String get has_non_surgical_or_emergency;

  /// Chronic health with elective surgery
  ///
  /// In en, this message translates to:
  /// **'Has (elective surgery)'**
  String get has_elective_surgery;

  /// SOFA score interpretation for no organ failure
  ///
  /// In en, this message translates to:
  /// **'No organ failure'**
  String get no_organ_failure;

  /// SOFA score interpretation for mild organ failure
  ///
  /// In en, this message translates to:
  /// **'Mild organ failure'**
  String get mild_organ_failure;

  /// SOFA score interpretation for moderate organ failure
  ///
  /// In en, this message translates to:
  /// **'Moderate organ failure'**
  String get moderate_organ_failure;

  /// SOFA score interpretation for severe organ failure
  ///
  /// In en, this message translates to:
  /// **'Severe organ failure'**
  String get severe_organ_failure;

  /// SOFA score interpretation for very severe multi-organ failure
  ///
  /// In en, this message translates to:
  /// **'Very severe multi-organ failure'**
  String get very_severe_multi_organ_failure;

  /// Respiratory system assessment
  ///
  /// In en, this message translates to:
  /// **'Respiratory System'**
  String get respiratory_system;

  /// Cardiovascular system assessment
  ///
  /// In en, this message translates to:
  /// **'Cardiovascular System'**
  String get cardiovascular_system;

  /// Hepatic system assessment
  ///
  /// In en, this message translates to:
  /// **'Hepatic System'**
  String get hepatic_system;

  /// Coagulation system assessment
  ///
  /// In en, this message translates to:
  /// **'Coagulation System'**
  String get coagulation_system;

  /// Renal system assessment
  ///
  /// In en, this message translates to:
  /// **'Renal System'**
  String get renal_system;

  /// Neurological system assessment
  ///
  /// In en, this message translates to:
  /// **'Neurological System'**
  String get neurological_system;

  /// Mortality rate label
  ///
  /// In en, this message translates to:
  /// **'Mortality rate'**
  String get mortality_rate;

  /// PaO2/FiO2 ratio input label
  ///
  /// In en, this message translates to:
  /// **'PaO2/FiO2 (mmHg)'**
  String get pao2_fio2_mmhg;

  /// Helper text for PaO2/FiO2 calculation
  ///
  /// In en, this message translates to:
  /// **'If not ventilated, enter SpO2/FiO2 x 315'**
  String get if_not_ventilated_helper;

  /// Cardiovascular assessment label
  ///
  /// In en, this message translates to:
  /// **'Mean arterial pressure or vasopressors'**
  String get mean_arterial_pressure_or_vasopressors;

  /// No hypotension option
  ///
  /// In en, this message translates to:
  /// **'No hypotension'**
  String get no_hypotension;

  /// MAP less than 70 mmHg
  ///
  /// In en, this message translates to:
  /// **'MAP < 70 mmHg'**
  String get map_less_than_70;

  /// Low dose vasopressor option
  ///
  /// In en, this message translates to:
  /// **'Dopamine ≤ 5 or dobutamine (any dose)'**
  String get dopamine_dobutamine;

  /// Medium dose vasopressor option
  ///
  /// In en, this message translates to:
  /// **'Dopamine 5-15 or epinephrine ≤ 0.1 or norepinephrine ≤ 0.1'**
  String get dopamine_5_15;

  /// High dose vasopressor option
  ///
  /// In en, this message translates to:
  /// **'Dopamine > 15 or epinephrine > 0.1 or norepinephrine > 0.1'**
  String get dopamine_greater_15;

  /// Bilirubin input label
  ///
  /// In en, this message translates to:
  /// **'Bilirubin (mg/dL)'**
  String get bilirubin_mg_dl;

  /// Platelet count input label
  ///
  /// In en, this message translates to:
  /// **'Platelets (1000/µL)'**
  String get platelets_1000_ul;

  /// GCS score for SOFA
  ///
  /// In en, this message translates to:
  /// **'Glasgow Coma Scale Score'**
  String get glasgow_coma_scale_score;

  /// Renal assessment label
  ///
  /// In en, this message translates to:
  /// **'Creatinine or urine output'**
  String get creatinine_or_urine_output;

  /// Creatinine input label for SOFA
  ///
  /// In en, this message translates to:
  /// **'Creatinine (mg/dL)'**
  String get creatinine_mg_dl_label;

  /// Urine output input label
  ///
  /// In en, this message translates to:
  /// **'Urine output (ml/day)'**
  String get urine_output_ml_day;

  /// Helper text for bilirubin input
  ///
  /// In en, this message translates to:
  /// **'Enter total bilirubin value'**
  String get enter_total_bilirubin_value;

  /// Helper text for platelet input
  ///
  /// In en, this message translates to:
  /// **'Enter platelet count'**
  String get enter_platelet_count;

  /// Helper text for creatinine input
  ///
  /// In en, this message translates to:
  /// **'Enter creatinine value'**
  String get enter_creatinine_value;

  /// Helper text for urine output input
  ///
  /// In en, this message translates to:
  /// **'Enter 24-hour urine output'**
  String get enter_urine_output_24h;

  /// Creatinine unit dropdown label
  ///
  /// In en, this message translates to:
  /// **'Creatinine unit'**
  String get creatinine_unit;

  /// Unit conversion note
  ///
  /// In en, this message translates to:
  /// **'Conversion: 1 mg/dL = 88.4 umol/L'**
  String get conversion_note;

  /// Score label with colon
  ///
  /// In en, this message translates to:
  /// **'Score: '**
  String get score_colon;

  /// Bilirubin unit dropdown label
  ///
  /// In en, this message translates to:
  /// **'Bilirubin Unit'**
  String get bilirubin_unit_label;

  /// Bilirubin unit conversion note
  ///
  /// In en, this message translates to:
  /// **'Conversion: 1 mg/dL = 17.1 umol/L'**
  String get bilirubin_conversion_note;

  /// SAPS II scoring system title
  ///
  /// In en, this message translates to:
  /// **'SAPS II Score'**
  String get saps2Score;

  /// Physiological parameters section
  ///
  /// In en, this message translates to:
  /// **'Physiological Score'**
  String get physiological_score;

  /// Type of ICU admission
  ///
  /// In en, this message translates to:
  /// **'Admission Type'**
  String get admission_type;

  /// Chronic disease conditions
  ///
  /// In en, this message translates to:
  /// **'Chronic Diseases'**
  String get chronic_diseases;

  /// Scheduled surgical admission
  ///
  /// In en, this message translates to:
  /// **'Scheduled surgery'**
  String get scheduled_surgery;

  /// Emergency surgical admission
  ///
  /// In en, this message translates to:
  /// **'Unscheduled surgery'**
  String get unscheduled_surgery;

  /// Non-surgical medical admission
  ///
  /// In en, this message translates to:
  /// **'Medical admission'**
  String get medical_admission;

  /// SAPS II mortality prediction note
  ///
  /// In en, this message translates to:
  /// **'SAPS II mortality prediction is based on the first 24 hours of ICU admission'**
  String get saps2_mortality_note;

  /// Basic information section header
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basic_information;

  /// Heart rate input field with beats per minute unit
  ///
  /// In en, this message translates to:
  /// **'Heart rate (/min)'**
  String get heart_rate_bpm;

  /// Systolic blood pressure input field with mmHg unit
  ///
  /// In en, this message translates to:
  /// **'Systolic blood pressure (mmHg)'**
  String get systolic_bp_mmhg;

  /// Urine output input field with liters per day unit
  ///
  /// In en, this message translates to:
  /// **'Urine output (L/day)'**
  String get urine_output_l_day;

  /// NIHSS score title
  ///
  /// In en, this message translates to:
  /// **'NIHSS Score'**
  String get nihss_score;

  /// NIHSS mild stroke severity
  ///
  /// In en, this message translates to:
  /// **'Mild stroke'**
  String get nihss_mild_stroke;

  /// NIHSS moderate stroke severity
  ///
  /// In en, this message translates to:
  /// **'Moderate stroke'**
  String get nihss_moderate_stroke;

  /// NIHSS severe stroke severity
  ///
  /// In en, this message translates to:
  /// **'Severe stroke'**
  String get nihss_severe_stroke;

  /// NIHSS very severe stroke severity
  ///
  /// In en, this message translates to:
  /// **'Very severe stroke'**
  String get nihss_very_severe_stroke;

  /// NIHSS good prognosis description
  ///
  /// In en, this message translates to:
  /// **'Good prognosis, high recovery potential'**
  String get nihss_good_prognosis;

  /// NIHSS fair prognosis description
  ///
  /// In en, this message translates to:
  /// **'Fair prognosis, requires rehabilitation'**
  String get nihss_fair_prognosis;

  /// NIHSS poor prognosis description
  ///
  /// In en, this message translates to:
  /// **'Poor prognosis, severe dependency'**
  String get nihss_poor_prognosis;

  /// NIHSS very poor prognosis description
  ///
  /// In en, this message translates to:
  /// **'Very poor prognosis, high mortality'**
  String get nihss_very_poor_prognosis;

  /// Prognosis label
  ///
  /// In en, this message translates to:
  /// **'Prognosis:'**
  String get prognosis;

  /// Potassium level input field
  ///
  /// In en, this message translates to:
  /// **'Potassium (mmol/L)'**
  String get potassium_mmol;

  /// Sodium level input field
  ///
  /// In en, this message translates to:
  /// **'Sodium (mmol/L)'**
  String get sodium_mmol;

  /// Bicarbonate level input field
  ///
  /// In en, this message translates to:
  /// **'HCO3⁻ (mmol/L)'**
  String get bicarbonate_mmol;

  /// Glasgow Coma Scale assessment label
  ///
  /// In en, this message translates to:
  /// **'Glasgow Coma Scale'**
  String get glasgow_coma_scale;

  /// Admission and chronic disease section header
  ///
  /// In en, this message translates to:
  /// **'Admission Type & Chronic Disease'**
  String get admission_chronic_disease;

  /// Glasgow Coma Scale less than 6
  ///
  /// In en, this message translates to:
  /// **'GCS < 6'**
  String get gcs_less_than_6;

  /// Glasgow Coma Scale 6 to 8
  ///
  /// In en, this message translates to:
  /// **'GCS 6-8'**
  String get gcs_6_to_8;

  /// Glasgow Coma Scale 9 to 10
  ///
  /// In en, this message translates to:
  /// **'GCS 9-10'**
  String get gcs_9_to_10;

  /// Glasgow Coma Scale 11 to 13
  ///
  /// In en, this message translates to:
  /// **'GCS 11-13'**
  String get gcs_11_to_13;

  /// Glasgow Coma Scale 14 to 15
  ///
  /// In en, this message translates to:
  /// **'GCS 14-15'**
  String get gcs_14_to_15;

  /// Admission type selection label
  ///
  /// In en, this message translates to:
  /// **'Admission Type:'**
  String get admission_type_label;

  /// Chronic diseases selection label
  ///
  /// In en, this message translates to:
  /// **'Chronic Diseases:'**
  String get chronic_diseases_label;

  /// Quick Sequential Organ Failure Assessment title
  ///
  /// In en, this message translates to:
  /// **'qSOFA Score'**
  String get qsofa_score;

  /// qSOFA score description
  ///
  /// In en, this message translates to:
  /// **'Quick SOFA for Sepsis Screening'**
  String get qsofa_description;

  /// Low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Routine monitoring, no special intervention needed'**
  String get routine_monitoring;

  /// High risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Consider sepsis evaluation and immediate management'**
  String get sepsis_evaluation;

  /// Low risk level
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get low_risk;

  /// High risk level
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get high_risk;

  /// Low mortality risk percentage
  ///
  /// In en, this message translates to:
  /// **'< 10%'**
  String get mortality_low;

  /// High mortality risk percentage
  ///
  /// In en, this message translates to:
  /// **'≥ 10%'**
  String get mortality_high;

  /// Mortality label
  ///
  /// In en, this message translates to:
  /// **'Mortality'**
  String get mortality;

  /// Clinical action label
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// Recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get recommendations;

  /// qSOFA criteria section title
  ///
  /// In en, this message translates to:
  /// **'qSOFA Criteria'**
  String get qsofa_criteria;

  /// Respiratory rate label
  ///
  /// In en, this message translates to:
  /// **'Respiratory Rate'**
  String get respiratory_rate;

  /// Systolic blood pressure label
  ///
  /// In en, this message translates to:
  /// **'Systolic Blood Pressure'**
  String get systolic_bp;

  /// Altered mental status label
  ///
  /// In en, this message translates to:
  /// **'Altered Mental Status'**
  String get altered_mentation;

  /// Respiratory rate helper text
  ///
  /// In en, this message translates to:
  /// **'+1 point if ≥22 breaths/min'**
  String get respiratory_rate_helper;

  /// Systolic BP helper text
  ///
  /// In en, this message translates to:
  /// **'+1 point if ≤100 mmHg'**
  String get systolic_bp_helper;

  /// No option
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Yes with GCS less than 15
  ///
  /// In en, this message translates to:
  /// **'Yes (GCS <15)'**
  String get yes_gcs_less_15;

  /// Positive criteria count
  ///
  /// In en, this message translates to:
  /// **'Positive Criteria ({count})'**
  String positive_criteria(int count);

  /// Low risk clinical action
  ///
  /// In en, this message translates to:
  /// **'Continue current monitoring and treatment'**
  String get continue_current_treatment;

  /// High risk clinical action
  ///
  /// In en, this message translates to:
  /// **'Initiate sepsis bundle protocol within 1 hour'**
  String get initiate_sepsis_bundle;

  /// NIHSS consciousness assessment
  ///
  /// In en, this message translates to:
  /// **'1a. Level of Consciousness'**
  String get nihss_1a_consciousness;

  /// NIHSS questions assessment
  ///
  /// In en, this message translates to:
  /// **'1b. Questions (current month, age)'**
  String get nihss_1b_questions;

  /// NIHSS commands assessment
  ///
  /// In en, this message translates to:
  /// **'1c. Commands (open/close eyes, grip/release hand)'**
  String get nihss_1c_commands;

  /// NIHSS gaze assessment
  ///
  /// In en, this message translates to:
  /// **'2. Horizontal Eye Movement'**
  String get nihss_2_gaze;

  /// NIHSS visual fields assessment
  ///
  /// In en, this message translates to:
  /// **'3. Visual Fields'**
  String get nihss_3_visual;

  /// NIHSS facial palsy assessment
  ///
  /// In en, this message translates to:
  /// **'4. Facial Palsy'**
  String get nihss_4_facial;

  /// NIHSS left arm motor assessment
  ///
  /// In en, this message translates to:
  /// **'5a. Left Arm Motor'**
  String get nihss_5a_left_arm;

  /// NIHSS right arm motor assessment
  ///
  /// In en, this message translates to:
  /// **'5b. Right Arm Motor'**
  String get nihss_5b_right_arm;

  /// NIHSS left leg motor assessment
  ///
  /// In en, this message translates to:
  /// **'6a. Left Leg Motor'**
  String get nihss_6a_left_leg;

  /// NIHSS right leg motor assessment
  ///
  /// In en, this message translates to:
  /// **'6b. Right Leg Motor'**
  String get nihss_6b_right_leg;

  /// NIHSS ataxia assessment
  ///
  /// In en, this message translates to:
  /// **'7. Limb Ataxia (finger-nose, heel-shin)'**
  String get nihss_7_ataxia;

  /// NIHSS sensory assessment
  ///
  /// In en, this message translates to:
  /// **'8. Sensory'**
  String get nihss_8_sensory;

  /// NIHSS language assessment
  ///
  /// In en, this message translates to:
  /// **'9. Best Language (aphasia)'**
  String get nihss_9_language;

  /// NIHSS dysarthria assessment
  ///
  /// In en, this message translates to:
  /// **'10. Dysarthria (speech articulation)'**
  String get nihss_10_dysarthria;

  /// NIHSS extinction assessment
  ///
  /// In en, this message translates to:
  /// **'11. Extinction and Inattention'**
  String get nihss_11_extinction;

  /// NIHSS consciousness level 0
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get nihss_consciousness_0;

  /// NIHSS consciousness level 1
  ///
  /// In en, this message translates to:
  /// **'Drowsy but arousable'**
  String get nihss_consciousness_1;

  /// NIHSS consciousness level 2
  ///
  /// In en, this message translates to:
  /// **'Obtunded, requires repeated stimulation'**
  String get nihss_consciousness_2;

  /// NIHSS consciousness level 3
  ///
  /// In en, this message translates to:
  /// **'Responds only with reflex motor or autonomic effects or totally unresponsive'**
  String get nihss_consciousness_3;

  /// NIHSS questions level 0
  ///
  /// In en, this message translates to:
  /// **'Answers both questions correctly'**
  String get nihss_questions_0;

  /// NIHSS questions level 1
  ///
  /// In en, this message translates to:
  /// **'Answers one question correctly'**
  String get nihss_questions_1;

  /// NIHSS questions level 2
  ///
  /// In en, this message translates to:
  /// **'Answers neither question correctly'**
  String get nihss_questions_2;

  /// NIHSS commands level 0
  ///
  /// In en, this message translates to:
  /// **'Performs both tasks correctly'**
  String get nihss_commands_0;

  /// NIHSS commands level 1
  ///
  /// In en, this message translates to:
  /// **'Performs one task correctly'**
  String get nihss_commands_1;

  /// NIHSS commands level 2
  ///
  /// In en, this message translates to:
  /// **'Performs neither task correctly'**
  String get nihss_commands_2;

  /// NIHSS gaze level 0
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get nihss_gaze_0;

  /// NIHSS gaze level 1
  ///
  /// In en, this message translates to:
  /// **'Partial gaze palsy'**
  String get nihss_gaze_1;

  /// NIHSS gaze level 2
  ///
  /// In en, this message translates to:
  /// **'Forced deviation or total gaze paresis'**
  String get nihss_gaze_2;

  /// NIHSS visual level 0
  ///
  /// In en, this message translates to:
  /// **'No visual loss'**
  String get nihss_visual_0;

  /// NIHSS visual level 1
  ///
  /// In en, this message translates to:
  /// **'Partial hemianopia'**
  String get nihss_visual_1;

  /// NIHSS visual level 2
  ///
  /// In en, this message translates to:
  /// **'Complete hemianopia'**
  String get nihss_visual_2;

  /// NIHSS visual level 3
  ///
  /// In en, this message translates to:
  /// **'Bilateral hemianopia'**
  String get nihss_visual_3;

  /// NIHSS facial level 0
  ///
  /// In en, this message translates to:
  /// **'Normal symmetric movements'**
  String get nihss_facial_0;

  /// NIHSS facial level 1
  ///
  /// In en, this message translates to:
  /// **'Minor paralysis'**
  String get nihss_facial_1;

  /// NIHSS facial level 2
  ///
  /// In en, this message translates to:
  /// **'Partial paralysis'**
  String get nihss_facial_2;

  /// NIHSS facial level 3
  ///
  /// In en, this message translates to:
  /// **'Complete paralysis'**
  String get nihss_facial_3;

  /// NIHSS arm level 0
  ///
  /// In en, this message translates to:
  /// **'No drift, limb holds 90° for 10 seconds'**
  String get nihss_arm_0;

  /// NIHSS arm level 1
  ///
  /// In en, this message translates to:
  /// **'Drift, limb holds 90° but drifts down before 10 seconds'**
  String get nihss_arm_1;

  /// NIHSS arm level 2
  ///
  /// In en, this message translates to:
  /// **'Some effort against gravity, limb cannot get to or maintain 90°'**
  String get nihss_arm_2;

  /// NIHSS arm level 3
  ///
  /// In en, this message translates to:
  /// **'No effort against gravity, limb falls'**
  String get nihss_arm_3;

  /// NIHSS arm level 4
  ///
  /// In en, this message translates to:
  /// **'No movement (amputation, joint fusion)'**
  String get nihss_arm_4;

  /// NIHSS leg level 0
  ///
  /// In en, this message translates to:
  /// **'No drift, leg holds 30° for 5 seconds'**
  String get nihss_leg_0;

  /// NIHSS leg level 1
  ///
  /// In en, this message translates to:
  /// **'Drift, leg falls by the end of the 5-second period'**
  String get nihss_leg_1;

  /// NIHSS leg level 2
  ///
  /// In en, this message translates to:
  /// **'Some effort against gravity, leg falls to bed by 5 seconds'**
  String get nihss_leg_2;

  /// NIHSS leg level 3
  ///
  /// In en, this message translates to:
  /// **'No effort against gravity, leg falls immediately'**
  String get nihss_leg_3;

  /// NIHSS leg level 4
  ///
  /// In en, this message translates to:
  /// **'No movement (amputation, joint fusion)'**
  String get nihss_leg_4;

  /// NIHSS ataxia level 0
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get nihss_ataxia_0;

  /// NIHSS ataxia level 1
  ///
  /// In en, this message translates to:
  /// **'Present in one limb'**
  String get nihss_ataxia_1;

  /// NIHSS ataxia level 2
  ///
  /// In en, this message translates to:
  /// **'Present in two limbs'**
  String get nihss_ataxia_2;

  /// NIHSS sensory level 0
  ///
  /// In en, this message translates to:
  /// **'Normal; no sensory loss'**
  String get nihss_sensory_0;

  /// NIHSS sensory level 1
  ///
  /// In en, this message translates to:
  /// **'Mild-to-moderate sensory loss'**
  String get nihss_sensory_1;

  /// NIHSS sensory level 2
  ///
  /// In en, this message translates to:
  /// **'Severe or total sensory loss'**
  String get nihss_sensory_2;

  /// NIHSS language level 0
  ///
  /// In en, this message translates to:
  /// **'No aphasia; normal'**
  String get nihss_language_0;

  /// NIHSS language level 1
  ///
  /// In en, this message translates to:
  /// **'Mild-to-moderate aphasia'**
  String get nihss_language_1;

  /// NIHSS language level 2
  ///
  /// In en, this message translates to:
  /// **'Severe aphasia'**
  String get nihss_language_2;

  /// NIHSS language level 3
  ///
  /// In en, this message translates to:
  /// **'Mute, global aphasia'**
  String get nihss_language_3;

  /// NIHSS dysarthria level 0
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get nihss_dysarthria_0;

  /// NIHSS dysarthria level 1
  ///
  /// In en, this message translates to:
  /// **'Mild-to-moderate dysarthria'**
  String get nihss_dysarthria_1;

  /// NIHSS dysarthria level 2
  ///
  /// In en, this message translates to:
  /// **'Severe dysarthria'**
  String get nihss_dysarthria_2;

  /// NIHSS extinction level 0
  ///
  /// In en, this message translates to:
  /// **'No abnormality'**
  String get nihss_extinction_0;

  /// NIHSS extinction level 1
  ///
  /// In en, this message translates to:
  /// **'Visual, tactile, auditory, spatial, or personal inattention'**
  String get nihss_extinction_1;

  /// NIHSS extinction level 2
  ///
  /// In en, this message translates to:
  /// **'Profound hemi-inattention or extinction'**
  String get nihss_extinction_2;

  /// NIHSS mild recommendation
  ///
  /// In en, this message translates to:
  /// **'Medical treatment, early rehabilitation'**
  String get nihss_recommendation_mild;

  /// NIHSS moderate recommendation
  ///
  /// In en, this message translates to:
  /// **'Consider vascular intervention, active rehabilitation'**
  String get nihss_recommendation_moderate;

  /// NIHSS severe recommendation
  ///
  /// In en, this message translates to:
  /// **'Active intervention if within golden time, ICU monitoring'**
  String get nihss_recommendation_severe;

  /// NIHSS very severe recommendation
  ///
  /// In en, this message translates to:
  /// **'Supportive care, consider limitation of treatment'**
  String get nihss_recommendation_very_severe;

  /// NIHSS score display title
  ///
  /// In en, this message translates to:
  /// **'NIHSS Score'**
  String get nihss_score_display;

  /// NIHSS severity classification title
  ///
  /// In en, this message translates to:
  /// **'Stroke Severity Classification'**
  String get nihss_severity_classification;

  /// NIHSS mild score range
  ///
  /// In en, this message translates to:
  /// **'0-4 points'**
  String get nihss_score_range_mild;

  /// NIHSS moderate score range
  ///
  /// In en, this message translates to:
  /// **'5-15 points'**
  String get nihss_score_range_moderate;

  /// NIHSS severe score range
  ///
  /// In en, this message translates to:
  /// **'16-20 points'**
  String get nihss_score_range_severe;

  /// NIHSS very severe score range
  ///
  /// In en, this message translates to:
  /// **'21-42 points'**
  String get nihss_score_range_very_severe;

  /// NIHSS clinical assessment note
  ///
  /// In en, this message translates to:
  /// **'Note: NIHSS is assessed within the first 24 hours and monitored for progression. Decreasing scores indicate improvement, increasing scores indicate worsening. Should be combined with clinical assessment and imaging to determine treatment.'**
  String get nihss_clinical_note;

  /// Reference materials section title
  ///
  /// In en, this message translates to:
  /// **'Reference Materials'**
  String get reference_materials;

  /// Score label for assessment items
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score_label;

  /// qSOFA sepsis risk stratification title
  ///
  /// In en, this message translates to:
  /// **'Sepsis Risk Stratification'**
  String get sepsis_risk_stratification;

  /// Clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get clinical_information;

  /// qSOFA clinical information content
  ///
  /// In en, this message translates to:
  /// **'qSOFA (Quick SOFA) is a simple and rapid sepsis screening tool\n\nAdvantages:\n• Simple, no laboratory tests required\n• Quick bedside implementation\n• Early sepsis recognition\n• Activates treatment protocols\n\nLimitations:\n• Lower sensitivity than full SOFA\n• Does not replace clinical assessment\n• May miss early sepsis\n• Must be combined with infection suspicion\n\nSepsis 3.0 Definition:\n• Sepsis = Infection + qSOFA ≥2\n• Septic shock = Sepsis + vasopressor + lactate >2\n• Treatment within \"Golden Hour\"\n\nImportant notes:\n• qSOFA does not diagnose sepsis\n• Only a screening tool\n• Requires comprehensive clinical assessment\n• Continuous monitoring needed'**
  String get qsofa_clinical_content;

  /// qSOFA respiratory rate criterion
  ///
  /// In en, this message translates to:
  /// **'Respiratory rate ≥22'**
  String get qsofa_respiratory_rate_criterion;

  /// qSOFA respiratory rate description
  ///
  /// In en, this message translates to:
  /// **'Respiratory rate ≥22 breaths/min'**
  String get qsofa_respiratory_rate_description;

  /// qSOFA altered mental status criterion
  ///
  /// In en, this message translates to:
  /// **'Altered mental status'**
  String get qsofa_altered_mentation_criterion;

  /// qSOFA altered mental status description
  ///
  /// In en, this message translates to:
  /// **'Change in mental status (GCS <15)'**
  String get qsofa_altered_mentation_description;

  /// qSOFA systolic blood pressure criterion
  ///
  /// In en, this message translates to:
  /// **'Systolic BP ≤100'**
  String get qsofa_systolic_bp_criterion;

  /// qSOFA systolic blood pressure description
  ///
  /// In en, this message translates to:
  /// **'Systolic blood pressure ≤100 mmHg'**
  String get qsofa_systolic_bp_description;

  /// qSOFA low risk level
  ///
  /// In en, this message translates to:
  /// **'Low risk'**
  String get qsofa_low_risk;

  /// qSOFA high risk level
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get qsofa_high_risk;

  /// qSOFA low risk management
  ///
  /// In en, this message translates to:
  /// **'Routine monitoring'**
  String get qsofa_routine_monitoring;

  /// qSOFA high risk management
  ///
  /// In en, this message translates to:
  /// **'Immediate sepsis bundle'**
  String get qsofa_immediate_sepsis_bundle;

  /// Sepsis bundle title
  ///
  /// In en, this message translates to:
  /// **'Sepsis Bundle - Hour 1'**
  String get sepsis_bundle_hour_1;

  /// Sepsis bundle item 1
  ///
  /// In en, this message translates to:
  /// **'1. Lactate measurement'**
  String get lactate_measurement;

  /// Lactate measurement description
  ///
  /// In en, this message translates to:
  /// **'Obtain blood lactate test'**
  String get lactate_description;

  /// Sepsis bundle item 2
  ///
  /// In en, this message translates to:
  /// **'2. Blood culture'**
  String get blood_culture;

  /// Blood culture description
  ///
  /// In en, this message translates to:
  /// **'Blood culture before antibiotics'**
  String get blood_culture_description;

  /// Sepsis bundle item 3
  ///
  /// In en, this message translates to:
  /// **'3. Antibiotics'**
  String get antibiotics;

  /// Antibiotics description
  ///
  /// In en, this message translates to:
  /// **'Broad-spectrum antibiotics within 1 hour'**
  String get antibiotics_description;

  /// Sepsis bundle item 4
  ///
  /// In en, this message translates to:
  /// **'4. Fluid resuscitation'**
  String get fluid_resuscitation;

  /// Fluid resuscitation description
  ///
  /// In en, this message translates to:
  /// **'30ml/kg if hypotensive or lactate ≥4'**
  String get fluid_description;

  /// Sepsis bundle item 5
  ///
  /// In en, this message translates to:
  /// **'5. Vasopressor'**
  String get vasopressor;

  /// Vasopressor description
  ///
  /// In en, this message translates to:
  /// **'If hypotension not responsive to fluids'**
  String get vasopressor_description;

  /// Child-Pugh score title
  ///
  /// In en, this message translates to:
  /// **'Child-Pugh Score'**
  String get child_pugh_score;

  /// Child-Pugh classification title
  ///
  /// In en, this message translates to:
  /// **'Child-Pugh Classification'**
  String get child_pugh_classification;

  /// Child-Pugh Class A description
  ///
  /// In en, this message translates to:
  /// **'Mild liver disease'**
  String get mild_liver_disease;

  /// Child-Pugh Class B description
  ///
  /// In en, this message translates to:
  /// **'Moderate liver disease'**
  String get moderate_liver_disease;

  /// Child-Pugh Class C description
  ///
  /// In en, this message translates to:
  /// **'Severe liver disease'**
  String get severe_liver_disease;

  /// Child-Pugh Class A operative risk
  ///
  /// In en, this message translates to:
  /// **'Low operative risk (10%)'**
  String get low_operative_risk;

  /// Child-Pugh Class B operative risk
  ///
  /// In en, this message translates to:
  /// **'Moderate operative risk (30%)'**
  String get moderate_operative_risk;

  /// Child-Pugh Class C operative risk
  ///
  /// In en, this message translates to:
  /// **'High operative risk (82%)'**
  String get high_operative_risk;

  /// Child-Pugh laboratory tests section title
  ///
  /// In en, this message translates to:
  /// **'Laboratory Tests'**
  String get child_pugh_laboratory_tests;

  /// Clinical symptoms section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Symptoms'**
  String get clinical_symptoms;

  /// Ascites assessment
  ///
  /// In en, this message translates to:
  /// **'Ascites'**
  String get ascites;

  /// Hepatic encephalopathy assessment
  ///
  /// In en, this message translates to:
  /// **'Hepatic Encephalopathy'**
  String get hepatic_encephalopathy;

  /// No ascites option
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get ascites_none;

  /// Mild to moderate ascites option
  ///
  /// In en, this message translates to:
  /// **'Mild-moderate (treatable)'**
  String get ascites_mild_moderate;

  /// Severe ascites option
  ///
  /// In en, this message translates to:
  /// **'Severe (refractory to treatment)'**
  String get ascites_severe;

  /// No encephalopathy option
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get encephalopathy_none;

  /// Grade 1-2 encephalopathy option
  ///
  /// In en, this message translates to:
  /// **'Grade I-II (mild-moderate)'**
  String get encephalopathy_grade_1_2;

  /// Grade 3-4 encephalopathy option
  ///
  /// In en, this message translates to:
  /// **'Grade III-IV (severe)'**
  String get encephalopathy_grade_3_4;

  /// One year survival label
  ///
  /// In en, this message translates to:
  /// **'1-year survival'**
  String get one_year_survival;

  /// Two year survival label
  ///
  /// In en, this message translates to:
  /// **'2-year survival'**
  String get two_year_survival;

  /// Reference material section title
  ///
  /// In en, this message translates to:
  /// **'Reference Material'**
  String get reference_material;

  /// Bilirubin lab test
  ///
  /// In en, this message translates to:
  /// **'Bilirubin'**
  String get bilirubin;

  /// Albumin lab test
  ///
  /// In en, this message translates to:
  /// **'Albumin'**
  String get albumin;

  /// INR/Prothrombin Time lab test
  ///
  /// In en, this message translates to:
  /// **'INR/Prothrombin Time'**
  String get inr_prothrombin_time;

  /// Input field placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter value'**
  String get enter_value;

  /// Child-Pugh score display label
  ///
  /// In en, this message translates to:
  /// **'Score: {score}'**
  String child_pugh_score_display(int score);

  /// Class A clinical information
  ///
  /// In en, this message translates to:
  /// **'• Class A (5-6 points): Good prognosis, suitable for surgery'**
  String get class_a_info;

  /// Class B clinical information
  ///
  /// In en, this message translates to:
  /// **'• Class B (7-9 points): Moderate prognosis, consider intervention'**
  String get class_b_info;

  /// Class C clinical information
  ///
  /// In en, this message translates to:
  /// **'• Class C (10-15 points): Poor prognosis, liver transplant priority'**
  String get class_c_info;

  /// Child-Pugh clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get child_pugh_clinical_information;

  /// Child-Pugh usage description
  ///
  /// In en, this message translates to:
  /// **'• Child-Pugh is used to assess the severity of cirrhosis'**
  String get child_pugh_usage;

  /// MELD score combination note
  ///
  /// In en, this message translates to:
  /// **'• Often combined with MELD score in liver disease assessment'**
  String get meld_combination;

  /// Submit button
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Edit button
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Add button
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// View button
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// Print button
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// Export button
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// Import button
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// Share button
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Copy button
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// Paste button
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// Cut button
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get cut;

  /// Undo button
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// Redo button
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get redo;

  /// Help button
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// About button
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Contact button
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// Feedback button
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// Report issue button
  ///
  /// In en, this message translates to:
  /// **'Report Issue'**
  String get report_issue;

  /// Privacy policy link
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// Terms of service link
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_of_service;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Update button
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Loading status
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// Error status
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success status
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Warning status
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// Information status
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// Confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// OK button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Minimize button
  ///
  /// In en, this message translates to:
  /// **'Minimize'**
  String get minimize;

  /// Maximize button
  ///
  /// In en, this message translates to:
  /// **'Maximize'**
  String get maximize;

  /// Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Previous button
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// First button
  ///
  /// In en, this message translates to:
  /// **'First'**
  String get first;

  /// Last button
  ///
  /// In en, this message translates to:
  /// **'Last'**
  String get last;

  /// Page label
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// Show button
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// Hide button
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hide;

  /// Expand button
  ///
  /// In en, this message translates to:
  /// **'Expand'**
  String get expand;

  /// Collapse button
  ///
  /// In en, this message translates to:
  /// **'Collapse'**
  String get collapse;

  /// Sort button
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// Filter button
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// Group button
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group;

  /// Ungroup button
  ///
  /// In en, this message translates to:
  /// **'Ungroup'**
  String get ungroup;

  /// Select all button
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get select_all;

  /// Deselect all button
  ///
  /// In en, this message translates to:
  /// **'Deselect All'**
  String get deselect_all;

  /// Invert selection button
  ///
  /// In en, this message translates to:
  /// **'Invert Selection'**
  String get invert_selection;

  /// CHA2DS2-VASc score title
  ///
  /// In en, this message translates to:
  /// **'CHA₂DS₂-VASc Score'**
  String get cha2ds2_vasc_score;

  /// Very low risk level
  ///
  /// In en, this message translates to:
  /// **'Very low risk'**
  String get risk_very_low;

  /// Low risk level
  ///
  /// In en, this message translates to:
  /// **'Low risk'**
  String get risk_low;

  /// Moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate risk'**
  String get risk_moderate;

  /// High risk level
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get risk_high;

  /// Annual stroke risk display
  ///
  /// In en, this message translates to:
  /// **'Stroke risk/year: {risk}'**
  String stroke_risk_per_year(String risk);

  /// No anticoagulation recommendation
  ///
  /// In en, this message translates to:
  /// **'No anticoagulation needed'**
  String get no_anticoagulation_needed;

  /// Consider anticoagulation recommendation
  ///
  /// In en, this message translates to:
  /// **'Consider anticoagulation or aspirin'**
  String get consider_anticoagulation_or_aspirin;

  /// Oral anticoagulation recommendation
  ///
  /// In en, this message translates to:
  /// **'Oral anticoagulation recommended'**
  String get oral_anticoagulation_recommended;

  /// Major risk factors section title
  ///
  /// In en, this message translates to:
  /// **'Major Risk Factors'**
  String get major_risk_factors;

  /// CHA2DS2-VASc usage description
  ///
  /// In en, this message translates to:
  /// **'• CHA₂DS₂-VASc is used to assess stroke risk in patients with non-valvular atrial fibrillation'**
  String get cha2ds2_vasc_usage;

  /// Male anticoagulation recommendation
  ///
  /// In en, this message translates to:
  /// **'• Score ≥ 2 (male) or ≥ 3 (female): anticoagulation recommended'**
  String get anticoagulation_male_recommendation;

  /// Anticoagulation consideration note
  ///
  /// In en, this message translates to:
  /// **'• Score = 1 (male) or = 2 (female): consider anticoagulation'**
  String get anticoagulation_consideration;

  /// HAS-BLED combination note
  ///
  /// In en, this message translates to:
  /// **'• Should be considered together with HAS-BLED score to assess bleeding risk'**
  String get hasbled_combination;

  /// Acquired immunodeficiency syndrome
  ///
  /// In en, this message translates to:
  /// **'AIDS'**
  String get aids;

  /// Blood cancer conditions
  ///
  /// In en, this message translates to:
  /// **'Hematologic malignancy'**
  String get hematologic_malignancy;

  /// Cancer with metastases
  ///
  /// In en, this message translates to:
  /// **'Metastatic cancer'**
  String get metastatic_cancer;

  /// Systolic BP measurement
  ///
  /// In en, this message translates to:
  /// **'Systolic blood pressure'**
  String get systolic_blood_pressure;

  /// BUN lab value
  ///
  /// In en, this message translates to:
  /// **'Blood urea nitrogen (BUN)'**
  String get blood_urea_nitrogen;

  /// Serum bicarbonate level
  ///
  /// In en, this message translates to:
  /// **'Bicarbonate'**
  String get bicarbonate;

  /// SAPS II low-moderate risk interpretation
  ///
  /// In en, this message translates to:
  /// **'Low-moderate risk'**
  String get low_moderate_risk;

  /// SAPS II moderate risk interpretation
  ///
  /// In en, this message translates to:
  /// **'Moderate risk'**
  String get moderate_risk;

  /// SAPS II extremely high risk interpretation
  ///
  /// In en, this message translates to:
  /// **'Extremely high risk'**
  String get extremely_high_risk;

  /// Age and gender factors section title
  ///
  /// In en, this message translates to:
  /// **'Age and Gender Factors'**
  String get age_and_gender_factors;

  /// Important information section title
  ///
  /// In en, this message translates to:
  /// **'Important Information'**
  String get important_information;

  /// Age input label
  ///
  /// In en, this message translates to:
  /// **'Age:'**
  String get age_label;

  /// Age input placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter age'**
  String get enter_age;

  /// CHA2DS2-VASc age score display
  ///
  /// In en, this message translates to:
  /// **'Age score: {score} (65-74: 1pt, ≥75: 2pts)'**
  String cha2ds2_age_score(int score);

  /// CHA2DS2-VASc CHF description
  ///
  /// In en, this message translates to:
  /// **'Congestive heart failure'**
  String get cha2ds2_chf_description;

  /// CHA2DS2-VASc hypertension description
  ///
  /// In en, this message translates to:
  /// **'Hypertension'**
  String get cha2ds2_hypertension_description;

  /// CHA2DS2-VASc diabetes description
  ///
  /// In en, this message translates to:
  /// **'Diabetes mellitus'**
  String get cha2ds2_diabetes_description;

  /// CHA2DS2-VASc stroke history description
  ///
  /// In en, this message translates to:
  /// **'History of stroke/TIA'**
  String get cha2ds2_stroke_description;

  /// CHA2DS2-VASc vascular disease description
  ///
  /// In en, this message translates to:
  /// **'Peripheral vascular disease/MI/aortic plaque'**
  String get cha2ds2_vascular_description;

  /// Gender selection label
  ///
  /// In en, this message translates to:
  /// **'Gender:'**
  String get gender_label;

  /// Male gender option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Female gender option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Zero points indication
  ///
  /// In en, this message translates to:
  /// **'0 points'**
  String get zero_points;

  /// One point indication
  ///
  /// In en, this message translates to:
  /// **'1 point'**
  String get one_point;

  /// MELD score title
  ///
  /// In en, this message translates to:
  /// **'MELD Score'**
  String get meld_score;

  /// MELD parameters section title
  ///
  /// In en, this message translates to:
  /// **'MELD Parameters'**
  String get meld_parameters;

  /// Transplant guidelines section title
  ///
  /// In en, this message translates to:
  /// **'Transplant Guidelines'**
  String get transplant_guidelines;

  /// MELD low risk level
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get meld_risk_low;

  /// MELD low-moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Low-moderate'**
  String get meld_risk_low_moderate;

  /// MELD moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get meld_risk_moderate;

  /// MELD high risk level
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get meld_risk_high;

  /// MELD very high risk level
  ///
  /// In en, this message translates to:
  /// **'Very high'**
  String get meld_risk_very_high;

  /// Risk text
  ///
  /// In en, this message translates to:
  /// **'risk'**
  String get risk_text;

  /// Low transplant priority
  ///
  /// In en, this message translates to:
  /// **'Low priority'**
  String get priority_low;

  /// Moderate transplant priority
  ///
  /// In en, this message translates to:
  /// **'Moderate priority'**
  String get priority_moderate;

  /// High transplant priority
  ///
  /// In en, this message translates to:
  /// **'High priority'**
  String get priority_high;

  /// Dialysis checkbox label
  ///
  /// In en, this message translates to:
  /// **'Dialysis'**
  String get dialysis;

  /// Dialysis checkbox description
  ///
  /// In en, this message translates to:
  /// **'Has undergone dialysis at least twice in the past week or CVVHD for 24h'**
  String get dialysis_description;

  /// Creatinine input helper text
  ///
  /// In en, this message translates to:
  /// **'Maximum 4.0 mg/dL (354 umol/L), minimum 1.0 mg/dL (88 umol/L)'**
  String get creatinine_helper;

  /// Bilirubin input helper text
  ///
  /// In en, this message translates to:
  /// **'Total bilirubin, minimum 1.0 mg/dL (17 umol/L)'**
  String get bilirubin_helper;

  /// INR input helper text
  ///
  /// In en, this message translates to:
  /// **'International Normalized Ratio, minimum 1.0'**
  String get inr_helper;

  /// 3-month mortality risk label
  ///
  /// In en, this message translates to:
  /// **'3-month mortality'**
  String get mortality_3_month;

  /// Transplant priority label
  ///
  /// In en, this message translates to:
  /// **'Transplant priority'**
  String get transplant_priority;

  /// MELD Recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get meld_recommendations;

  /// MELD low score recommendation
  ///
  /// In en, this message translates to:
  /// **'Regular follow-up, manage cirrhosis complications'**
  String get meld_follow_up;

  /// MELD moderate-low score recommendation
  ///
  /// In en, this message translates to:
  /// **'Liver transplant evaluation, screen for complications'**
  String get meld_evaluation;

  /// MELD moderate score recommendation
  ///
  /// In en, this message translates to:
  /// **'Add to transplant waitlist'**
  String get meld_waitlist;

  /// MELD high score recommendation
  ///
  /// In en, this message translates to:
  /// **'High priority transplant, close monitoring'**
  String get meld_high_priority;

  /// MELD very high score recommendation
  ///
  /// In en, this message translates to:
  /// **'Urgent transplant needed, consider ICU'**
  String get meld_urgent;

  /// MELD risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'MELD Risk Stratification'**
  String get meld_risk_stratification;

  /// MELD low score action
  ///
  /// In en, this message translates to:
  /// **'Regular follow-up'**
  String get meld_follow_up_action;

  /// MELD moderate-low score action
  ///
  /// In en, this message translates to:
  /// **'Liver transplant evaluation'**
  String get meld_evaluation_action;

  /// MELD moderate score action
  ///
  /// In en, this message translates to:
  /// **'Waitlist'**
  String get meld_waitlist_action;

  /// MELD high score action
  ///
  /// In en, this message translates to:
  /// **'High priority'**
  String get meld_high_priority_action;

  /// MELD very high score action
  ///
  /// In en, this message translates to:
  /// **'Urgent transplant'**
  String get meld_urgent_action;

  /// MELD follow-up guideline title
  ///
  /// In en, this message translates to:
  /// **'MELD <15: Follow-up'**
  String get meld_follow_up_title;

  /// MELD waitlist guideline title
  ///
  /// In en, this message translates to:
  /// **'MELD 15-24: Waitlist'**
  String get meld_waitlist_title;

  /// MELD high priority guideline title
  ///
  /// In en, this message translates to:
  /// **'MELD ≥25: High Priority'**
  String get meld_high_priority_title;

  /// Routine medical visit guideline
  ///
  /// In en, this message translates to:
  /// **'Routine visit every 6 months'**
  String get routine_visit_6_months;

  /// Liver ultrasound guideline
  ///
  /// In en, this message translates to:
  /// **'Liver ultrasound every 6 months'**
  String get liver_ultrasound_6_months;

  /// AFP test guideline
  ///
  /// In en, this message translates to:
  /// **'AFP every 6 months'**
  String get afp_every_6_months;

  /// Complication screening guideline
  ///
  /// In en, this message translates to:
  /// **'Screen for complications'**
  String get screen_complications;

  /// Transplant waitlist guideline
  ///
  /// In en, this message translates to:
  /// **'Add to transplant waitlist'**
  String get add_to_waitlist;

  /// Medical evaluation guideline
  ///
  /// In en, this message translates to:
  /// **'Comprehensive evaluation'**
  String get comprehensive_evaluation;

  /// GRACE score title
  ///
  /// In en, this message translates to:
  /// **'GRACE Score'**
  String get grace_score_title;

  /// GRACE low risk
  ///
  /// In en, this message translates to:
  /// **'Low risk'**
  String get grace_risk_low;

  /// GRACE moderate risk
  ///
  /// In en, this message translates to:
  /// **'Moderate risk'**
  String get grace_risk_moderate;

  /// GRACE high risk
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get grace_risk_high;

  /// GRACE very high risk
  ///
  /// In en, this message translates to:
  /// **'Very high risk'**
  String get grace_risk_very_high;

  /// GRACE recommendation label
  ///
  /// In en, this message translates to:
  /// **'Recommendation:'**
  String get grace_recommendation;

  /// GRACE intervention strategy label
  ///
  /// In en, this message translates to:
  /// **'Intervention strategy:'**
  String get grace_intervention_strategy;

  /// GRACE intervention timing label
  ///
  /// In en, this message translates to:
  /// **'Intervention timing:'**
  String get grace_intervention_timing;

  /// GRACE detailed intervention timing label
  ///
  /// In en, this message translates to:
  /// **'Detailed intervention timing:'**
  String get grace_detailed_intervention_timing;

  /// GRACE reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get grace_reference_title;

  /// GRACE reference citation text
  ///
  /// In en, this message translates to:
  /// **'Fox KA, et al. Prediction of risk of death and myocardial infarction in the six months after presentation with acute coronary syndrome: prospective multinational observational study (GRACE). BMJ. 2006;333(7578):1091.'**
  String get grace_reference_text;

  /// GRACE 6-month mortality low risk
  ///
  /// In en, this message translates to:
  /// **'< 1%'**
  String get grace_mortality_6_month_low;

  /// GRACE 6-month mortality moderate risk
  ///
  /// In en, this message translates to:
  /// **'1-3%'**
  String get grace_mortality_6_month_moderate;

  /// GRACE 6-month mortality high risk
  ///
  /// In en, this message translates to:
  /// **'3-8%'**
  String get grace_mortality_6_month_high;

  /// GRACE 6-month mortality very high risk
  ///
  /// In en, this message translates to:
  /// **'> 8%'**
  String get grace_mortality_6_month_very_high;

  /// GRACE hospital mortality low risk
  ///
  /// In en, this message translates to:
  /// **'< 2%'**
  String get grace_mortality_hospital_low;

  /// GRACE hospital mortality moderate risk
  ///
  /// In en, this message translates to:
  /// **'2-5%'**
  String get grace_mortality_hospital_moderate;

  /// GRACE hospital mortality high risk
  ///
  /// In en, this message translates to:
  /// **'5-12%'**
  String get grace_mortality_hospital_high;

  /// GRACE hospital mortality very high risk
  ///
  /// In en, this message translates to:
  /// **'> 12%'**
  String get grace_mortality_hospital_very_high;

  /// GRACE conservative intervention strategy
  ///
  /// In en, this message translates to:
  /// **'Conservative strategy'**
  String get grace_strategy_conservative;

  /// GRACE selective intervention strategy
  ///
  /// In en, this message translates to:
  /// **'Selective intervention strategy'**
  String get grace_strategy_selective;

  /// GRACE early intervention strategy
  ///
  /// In en, this message translates to:
  /// **'Early intervention strategy'**
  String get grace_strategy_early;

  /// GRACE immediate intervention strategy
  ///
  /// In en, this message translates to:
  /// **'Immediate intervention strategy'**
  String get grace_strategy_immediate;

  /// GRACE intervention timing 72 hours
  ///
  /// In en, this message translates to:
  /// **'Intervention within 72 hours'**
  String get grace_timing_72h;

  /// GRACE intervention timing 24-72 hours
  ///
  /// In en, this message translates to:
  /// **'Intervention within 24-72 hours'**
  String get grace_timing_24_72h;

  /// GRACE intervention timing 24 hours
  ///
  /// In en, this message translates to:
  /// **'Intervention within 24 hours'**
  String get grace_timing_24h;

  /// GRACE intervention timing 2 hours
  ///
  /// In en, this message translates to:
  /// **'Emergency intervention within 2 hours'**
  String get grace_timing_2h;

  /// GRACE detailed timing for low risk
  ///
  /// In en, this message translates to:
  /// **'Intervention timing: Within 72 hours\\n• PCI can be delayed if no complications\\n• Monitoring at cardiology ward\\n• Optimal medical therapy first'**
  String get grace_detailed_timing_low;

  /// GRACE detailed timing for moderate risk
  ///
  /// In en, this message translates to:
  /// **'Intervention timing: Within 24-72 hours\\n• Selective PCI based on symptoms\\n• Close monitoring at CCU\\n• Ready for intervention when needed'**
  String get grace_detailed_timing_moderate;

  /// GRACE detailed timing for high risk
  ///
  /// In en, this message translates to:
  /// **'Intervention timing: Within 24 hours\\n• Early PCI recommended\\n• Intensive CCU monitoring\\n• Prepare for urgent intervention'**
  String get grace_detailed_timing_high;

  /// GRACE detailed timing for very high risk
  ///
  /// In en, this message translates to:
  /// **'Intervention timing: Emergency within 2 hours\\n• Immediate PCI required\\n• ICU monitoring\\n• Emergency cardiac catheterization'**
  String get grace_detailed_timing_very_high;

  /// GRACE 6-month mortality label
  ///
  /// In en, this message translates to:
  /// **'6-month mortality'**
  String get grace_6_month_mortality;

  /// GRACE hospital mortality label
  ///
  /// In en, this message translates to:
  /// **'Hospital mortality'**
  String get grace_hospital_mortality;

  /// GRACE intervention strategy label
  ///
  /// In en, this message translates to:
  /// **'Treatment strategy:'**
  String get grace_intervention_strategy_label;

  /// GRACE clinical information title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get grace_clinical_info_title;

  /// GRACE clinical information content
  ///
  /// In en, this message translates to:
  /// **'GRACE Score assesses mortality risk in patients with acute coronary syndrome (ACS)\\n\\nClinical applications:\\n• Risk stratification and treatment strategy selection\\n• Decide early intervention vs conservative treatment\\n• Prognosis counseling for patients and families\\n• Assessment of referral indications\\n\\nIntervention strategy by timing:\\n• Low risk (≤108): Intervention within 72h - PCI can be delayed\\n• Moderate risk (109-140): Intervention within 24-72h - Selective PCI\\n• High risk (141-200): Intervention within 24h - Early PCI recommended\\n• Very high risk (>200): Emergency intervention within 2h - Emergency PCI\\n\\nNotes:\\n• Higher score indicates greater mortality risk\\n• Must combine with overall clinical assessment\\n• Regular monitoring and reassessment\\n• Applies to both STEMI and NSTEMI/UA'**
  String get grace_clinical_info_content;

  /// GRACE detailed timing section title
  ///
  /// In en, this message translates to:
  /// **'Detailed intervention timing:'**
  String get grace_detailed_timing_title;

  /// GRACE age input label
  ///
  /// In en, this message translates to:
  /// **'Age (years)'**
  String get grace_age_label;

  /// GRACE heart rate input label
  ///
  /// In en, this message translates to:
  /// **'Heart rate (/min)'**
  String get grace_heart_rate_label;

  /// GRACE systolic BP input label
  ///
  /// In en, this message translates to:
  /// **'Systolic blood pressure (mmHg)'**
  String get grace_systolic_bp_label;

  /// GRACE creatinine input label
  ///
  /// In en, this message translates to:
  /// **'Creatinine'**
  String get grace_creatinine_label;

  /// GRACE creatinine unit label
  ///
  /// In en, this message translates to:
  /// **'Creatinine unit'**
  String get grace_creatinine_unit_label;

  /// GRACE heart failure checkbox title
  ///
  /// In en, this message translates to:
  /// **'Heart failure or left ventricular dysfunction'**
  String get grace_heart_failure_title;

  /// GRACE cardiac arrest checkbox title
  ///
  /// In en, this message translates to:
  /// **'In-hospital cardiac arrest'**
  String get grace_cardiac_arrest_title;

  /// GRACE ST elevation checkbox title
  ///
  /// In en, this message translates to:
  /// **'ST elevation on ECG'**
  String get grace_st_elevation_title;

  /// GRACE elevated markers checkbox title
  ///
  /// In en, this message translates to:
  /// **'Elevated cardiac enzymes (Troponin/CK-MB)'**
  String get grace_elevated_markers_title;

  /// GRACE input parameters section title
  ///
  /// In en, this message translates to:
  /// **'Input Parameters'**
  String get grace_input_parameters;

  /// GRACE clinical factors section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Factors'**
  String get grace_clinical_factors;

  /// GRACE risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'Risk Stratification'**
  String get grace_risk_stratification;

  /// GRACE risk level column header
  ///
  /// In en, this message translates to:
  /// **'Risk Level'**
  String get grace_risk_level;

  /// GRACE 6-month mortality column header
  ///
  /// In en, this message translates to:
  /// **'6-month Mortality'**
  String get grace_6_month_mort;

  /// GRACE hospital mortality column header
  ///
  /// In en, this message translates to:
  /// **'Hospital Mortality'**
  String get grace_hospital_mort;

  /// GRACE intervention timing column header
  ///
  /// In en, this message translates to:
  /// **'Intervention Timing'**
  String get grace_intervention_timing_column;

  /// GRACE low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Outpatient treatment may be considered, regular monitoring'**
  String get grace_recommendation_low;

  /// GRACE moderate risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Hospital admission for monitoring, treatment according to ACS guidelines'**
  String get grace_recommendation_moderate;

  /// GRACE high risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Early intervention needed, consider high-level referral'**
  String get grace_recommendation_high;

  /// GRACE very high risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Immediate emergency intervention, ICU monitoring, early PCI'**
  String get grace_recommendation_very_high;

  /// GRACE recommendations section label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get grace_recommendations_label;

  /// GRACE intervention timing section label
  ///
  /// In en, this message translates to:
  /// **'Intervention timing:'**
  String get grace_intervention_timing_label;

  /// GRACE per minute unit for heart rate
  ///
  /// In en, this message translates to:
  /// **'/min'**
  String get grace_per_minute_unit;

  /// Follow-up guideline
  ///
  /// In en, this message translates to:
  /// **'Follow-up every 3 months'**
  String get follow_up_3_months;

  /// Liver cancer screening guideline
  ///
  /// In en, this message translates to:
  /// **'Screen for liver cancer'**
  String get screen_liver_cancer;

  /// High priority transplant guideline
  ///
  /// In en, this message translates to:
  /// **'High priority transplant'**
  String get high_priority_transplant;

  /// Weekly monitoring guideline
  ///
  /// In en, this message translates to:
  /// **'Weekly monitoring'**
  String get weekly_monitoring;

  /// Living donor transplant guideline
  ///
  /// In en, this message translates to:
  /// **'Consider living donor transplant'**
  String get consider_living_donor;

  /// Intensive medical support guideline
  ///
  /// In en, this message translates to:
  /// **'Intensive support'**
  String get intensive_support;

  /// MELD clinical information text
  ///
  /// In en, this message translates to:
  /// **'MELD Score assesses the severity of end-stage liver disease\n\nMELD Formula:\n3.78 × ln(bilirubin) + 11.2 × ln(INR) + 9.57 × ln(creatinine) + 6.43\n\nAdjustments:\n• Creatinine: minimum 1.0, maximum 4.0 mg/dL\n• If on dialysis: creatinine = 4.0 mg/dL\n• Bilirubin and INR: minimum 1.0\n• MELD score: minimum 6, maximum 40\n\nClinical applications:\n• Liver transplant prioritization per UNOS\n• Short-term mortality prediction\n• Intervention decisions\n• Disease progression monitoring\n\nMELD-Na (improved):\n• Adds serum sodium\n• Improves accuracy\n• Widely used currently\n\nPriority exceptions:\n• Liver cancer (HCC)\n• Fulminant liver disease\n• Rare diseases\n• Special circumstances\n\nLimitations:\n• Does not include complications\n• Changes over time\n• Requires comprehensive assessment\n• Does not predict post-transplant function'**
  String get meld_clinical_info;

  /// MELD score reference citation
  ///
  /// In en, this message translates to:
  /// **'Kamath PS, et al. A model to predict survival in patients with end-stage liver disease. Hepatology. 2001;33(2):464-70.'**
  String get meld_reference_text;

  /// Clinical scores page title
  ///
  /// In en, this message translates to:
  /// **'Clinical Scores'**
  String get clinical_scores_title;

  /// Clinical scores page subtitle
  ///
  /// In en, this message translates to:
  /// **'Common scores used in ICU'**
  String get clinical_scores_subtitle;

  /// Glasgow Coma Scale list description
  ///
  /// In en, this message translates to:
  /// **'Eye, verbal, motor response assessment'**
  String get gcs_list_description;

  /// APACHE II list description
  ///
  /// In en, this message translates to:
  /// **'ICU mortality prediction'**
  String get apache_list_description;

  /// SOFA Score list description
  ///
  /// In en, this message translates to:
  /// **'Multi-organ failure assessment'**
  String get sofa_list_description;

  /// SAPS II list description
  ///
  /// In en, this message translates to:
  /// **'ICU patient mortality prediction'**
  String get saps_list_description;

  /// qSOFA Score list description
  ///
  /// In en, this message translates to:
  /// **'Sepsis screening outside ICU'**
  String get qsofa_list_description;

  /// MEWS list description
  ///
  /// In en, this message translates to:
  /// **'Early warning system for patient status'**
  String get mews_list_description;

  /// PEWS list description
  ///
  /// In en, this message translates to:
  /// **'Pediatric early warning system'**
  String get pews_list_description;

  /// GRACE Score list description
  ///
  /// In en, this message translates to:
  /// **'Risk assessment in acute coronary syndrome'**
  String get grace_list_description;

  /// TIMI STEMI list description
  ///
  /// In en, this message translates to:
  /// **'STEMI mortality risk assessment'**
  String get timi_stemi_list_description;

  /// TIMI UA/NSTEMI list description
  ///
  /// In en, this message translates to:
  /// **'UA/NSTEMI risk assessment'**
  String get timi_ua_nstemi_list_description;

  /// CRUSADE Score list description
  ///
  /// In en, this message translates to:
  /// **'Bleeding risk in acute coronary syndrome'**
  String get crusade_list_description;

  /// HAS-BLED Score list description
  ///
  /// In en, this message translates to:
  /// **'Bleeding risk assessment during anticoagulation'**
  String get has_bled_list_description;

  /// IMPROVE Bleeding Risk list description
  ///
  /// In en, this message translates to:
  /// **'Bleeding risk in medical patients'**
  String get improve_list_description;

  /// CHA2DS2-VASc list description
  ///
  /// In en, this message translates to:
  /// **'Stroke risk assessment in atrial fibrillation'**
  String get cha2ds2_vasc_list_description;

  /// Wells DVT Score list description
  ///
  /// In en, this message translates to:
  /// **'Deep vein thrombosis probability assessment'**
  String get wells_dvt_list_description;

  /// Padua Prediction Score list description
  ///
  /// In en, this message translates to:
  /// **'Venous thromboembolism risk assessment'**
  String get padua_list_description;

  /// ABCD2 Score list description
  ///
  /// In en, this message translates to:
  /// **'Stroke risk after transient ischemic attack'**
  String get abcd2_list_description;

  /// NIHSS list description
  ///
  /// In en, this message translates to:
  /// **'Stroke severity assessment'**
  String get nihss_list_description;

  /// RACE Scale list description
  ///
  /// In en, this message translates to:
  /// **'Large vessel occlusion screening'**
  String get race_list_description;

  /// ASPECT Score list description
  ///
  /// In en, this message translates to:
  /// **'Brain infarct area assessment on CT'**
  String get aspect_list_description;

  /// Modified Sgarbossa Criteria list description
  ///
  /// In en, this message translates to:
  /// **'STEMI diagnosis with left bundle branch block'**
  String get sgarbossa_list_description;

  /// Ranson Criteria list description
  ///
  /// In en, this message translates to:
  /// **'Acute pancreatitis severity assessment'**
  String get ranson_list_description;

  /// Child-Pugh Score list description
  ///
  /// In en, this message translates to:
  /// **'Liver disease severity assessment'**
  String get child_pugh_list_description;

  /// MELD Score list description
  ///
  /// In en, this message translates to:
  /// **'End-stage liver disease mortality prediction'**
  String get meld_list_description;

  /// CURB-65 list description
  ///
  /// In en, this message translates to:
  /// **'Community-acquired pneumonia severity assessment'**
  String get curb65_list_description;

  /// PSI list description
  ///
  /// In en, this message translates to:
  /// **'Pneumonia severity index'**
  String get psi_list_description;

  /// ASA Physical Status list description
  ///
  /// In en, this message translates to:
  /// **'Preoperative physical status classification'**
  String get asa_list_description;

  /// Revised Cardiac Risk Index list description
  ///
  /// In en, this message translates to:
  /// **'Perioperative cardiac risk assessment'**
  String get cardiac_risk_list_description;

  /// Surgical Apgar Score list description
  ///
  /// In en, this message translates to:
  /// **'Postoperative outcome prediction'**
  String get apgar_list_description;

  /// Preoperative Mortality Prediction list description
  ///
  /// In en, this message translates to:
  /// **'Preoperative mortality prediction'**
  String get preop_mortality_list_description;

  /// DAPT Score list description
  ///
  /// In en, this message translates to:
  /// **'Dual antiplatelet therapy duration decision'**
  String get dapt_list_description;

  /// DAPT Score page title
  ///
  /// In en, this message translates to:
  /// **'DAPT Score'**
  String get dapt_title;

  /// Recommendation to continue DAPT
  ///
  /// In en, this message translates to:
  /// **'Continue DAPT'**
  String get dapt_continue;

  /// Recommendation to discontinue DAPT
  ///
  /// In en, this message translates to:
  /// **'Discontinue DAPT'**
  String get dapt_discontinue;

  /// High ischemic benefit text
  ///
  /// In en, this message translates to:
  /// **'Reduces 41% risk of MACE'**
  String get dapt_ischemic_benefit_high;

  /// Low ischemic benefit text
  ///
  /// In en, this message translates to:
  /// **'Reduces 7% risk of MACE'**
  String get dapt_ischemic_benefit_low;

  /// High bleeding risk text
  ///
  /// In en, this message translates to:
  /// **'Increases 31% risk of major bleeding'**
  String get dapt_bleeding_risk_high;

  /// Low bleeding risk text
  ///
  /// In en, this message translates to:
  /// **'Increases 61% risk of major bleeding'**
  String get dapt_bleeding_risk_low;

  /// Reasoning for continuing DAPT
  ///
  /// In en, this message translates to:
  /// **'Ischemic benefit reduction > Bleeding risk'**
  String get dapt_reasoning_continue;

  /// Reasoning for discontinuing DAPT
  ///
  /// In en, this message translates to:
  /// **'Bleeding risk > Ischemic benefit reduction'**
  String get dapt_reasoning_discontinue;

  /// Label for ischemic benefit section
  ///
  /// In en, this message translates to:
  /// **'Ischemic benefit'**
  String get dapt_ischemic_benefit_label;

  /// Label for bleeding risk section
  ///
  /// In en, this message translates to:
  /// **'Bleeding risk'**
  String get dapt_bleeding_risk_label;

  /// Label for clinical rationale
  ///
  /// In en, this message translates to:
  /// **'Rationale:'**
  String get dapt_rationale_label;

  /// Patient factors section title
  ///
  /// In en, this message translates to:
  /// **'Patient Factors'**
  String get dapt_patient_factors;

  /// Age input label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get dapt_age_label;

  /// Age unit text
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get dapt_age_unit;

  /// Age scoring help text
  ///
  /// In en, this message translates to:
  /// **'≥75 years: -2 points, 65-74 years: -1 point'**
  String get dapt_age_help;

  /// Smoking risk factor
  ///
  /// In en, this message translates to:
  /// **'Cigarette smoking'**
  String get dapt_smoking;

  /// Smoking description
  ///
  /// In en, this message translates to:
  /// **'Current or within 1 year'**
  String get dapt_smoking_desc;

  /// Diabetes risk factor
  ///
  /// In en, this message translates to:
  /// **'Diabetes mellitus'**
  String get dapt_diabetes;

  /// Diabetes description
  ///
  /// In en, this message translates to:
  /// **'On medical treatment'**
  String get dapt_diabetes_desc;

  /// Clinical factors section title
  ///
  /// In en, this message translates to:
  /// **'Clinical & Procedural Factors'**
  String get dapt_clinical_factors;

  /// Myocardial infarction risk factor
  ///
  /// In en, this message translates to:
  /// **'MI prior to PCI'**
  String get dapt_mi;

  /// MI description
  ///
  /// In en, this message translates to:
  /// **'MI at presentation or previous'**
  String get dapt_mi_desc;

  /// Heart failure risk factor
  ///
  /// In en, this message translates to:
  /// **'Heart failure or LVEF <30%'**
  String get dapt_heart_failure;

  /// Heart failure description
  ///
  /// In en, this message translates to:
  /// **'Clinical heart failure or ejection fraction <30%'**
  String get dapt_heart_failure_desc;

  /// Vein graft intervention risk factor
  ///
  /// In en, this message translates to:
  /// **'Vein graft intervention'**
  String get dapt_vein_graft;

  /// Vein graft description
  ///
  /// In en, this message translates to:
  /// **'PCI on saphenous vein graft'**
  String get dapt_vein_graft_desc;

  /// Stent characteristics subtitle
  ///
  /// In en, this message translates to:
  /// **'Stent characteristics'**
  String get dapt_stent_characteristics;

  /// Bare metal stent risk factor
  ///
  /// In en, this message translates to:
  /// **'Bare metal stent (BMS)'**
  String get dapt_bms;

  /// BMS description
  ///
  /// In en, this message translates to:
  /// **'Compared to drug-eluting stent'**
  String get dapt_bms_desc;

  /// Small stent risk factor
  ///
  /// In en, this message translates to:
  /// **'Stent diameter <3mm'**
  String get dapt_small_stent;

  /// Small stent description
  ///
  /// In en, this message translates to:
  /// **'Small stents have higher risk'**
  String get dapt_small_stent_desc;

  /// Points suffix for scoring
  ///
  /// In en, this message translates to:
  /// **'point'**
  String get dapt_points_suffix;

  /// Risk-benefit analysis section title
  ///
  /// In en, this message translates to:
  /// **'Risk-Benefit Analysis'**
  String get dapt_risk_benefit_analysis;

  /// Continue DAPT analysis title
  ///
  /// In en, this message translates to:
  /// **'DAPT Score ≥2: Continue DAPT'**
  String get dapt_continue_title;

  /// MACE reduction with continued DAPT
  ///
  /// In en, this message translates to:
  /// **'41% reduction in MACE risk'**
  String get dapt_continue_mace;

  /// MI reduction with continued DAPT
  ///
  /// In en, this message translates to:
  /// **'43% reduction in MI risk'**
  String get dapt_continue_mi;

  /// Stent thrombosis reduction
  ///
  /// In en, this message translates to:
  /// **'67% reduction in stent thrombosis'**
  String get dapt_continue_stent;

  /// Bleeding increase with continued DAPT
  ///
  /// In en, this message translates to:
  /// **'31% increase in major bleeding'**
  String get dapt_continue_bleeding;

  /// Conclusion for continuing DAPT
  ///
  /// In en, this message translates to:
  /// **'Benefit > Risk'**
  String get dapt_continue_conclusion;

  /// Discontinue DAPT analysis title
  ///
  /// In en, this message translates to:
  /// **'DAPT Score <2: Discontinue DAPT'**
  String get dapt_discontinue_title;

  /// MACE reduction with discontinued DAPT
  ///
  /// In en, this message translates to:
  /// **'7% reduction in MACE risk (not significant)'**
  String get dapt_discontinue_mace;

  /// Bleeding increase if DAPT continued
  ///
  /// In en, this message translates to:
  /// **'61% increase in major bleeding risk'**
  String get dapt_discontinue_bleeding;

  /// GI bleeding reduction
  ///
  /// In en, this message translates to:
  /// **'Reduced GI bleeding risk'**
  String get dapt_discontinue_gi;

  /// Intracranial bleeding reduction
  ///
  /// In en, this message translates to:
  /// **'Reduced intracranial bleeding risk'**
  String get dapt_discontinue_ich;

  /// Conclusion for discontinuing DAPT
  ///
  /// In en, this message translates to:
  /// **'Risk > Benefit'**
  String get dapt_discontinue_conclusion;

  /// Clinical guidelines section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Guidelines'**
  String get dapt_clinical_guidelines;

  /// Guidelines for continuing DAPT
  ///
  /// In en, this message translates to:
  /// **'DAPT Score ≥2: Recommend extended DAPT'**
  String get dapt_guideline_continue_title;

  /// Continue dual therapy guideline
  ///
  /// In en, this message translates to:
  /// **'Continue aspirin + P2Y12 inhibitor'**
  String get dapt_guideline_continue_1;

  /// Duration guideline
  ///
  /// In en, this message translates to:
  /// **'Duration: additional 18-30 months'**
  String get dapt_guideline_continue_2;

  /// Monitoring guideline
  ///
  /// In en, this message translates to:
  /// **'Monitor kidney and liver function'**
  String get dapt_guideline_continue_3;

  /// Patient counseling guideline
  ///
  /// In en, this message translates to:
  /// **'Counsel on bleeding signs'**
  String get dapt_guideline_continue_4;

  /// Guidelines for discontinuing DAPT
  ///
  /// In en, this message translates to:
  /// **'DAPT Score <2: Discontinue DAPT'**
  String get dapt_guideline_discontinue_title;

  /// Switch to monotherapy guideline
  ///
  /// In en, this message translates to:
  /// **'Switch to aspirin monotherapy'**
  String get dapt_guideline_discontinue_1;

  /// Aspirin dosing guideline
  ///
  /// In en, this message translates to:
  /// **'Aspirin dose 75-100mg daily'**
  String get dapt_guideline_discontinue_2;

  /// CV monitoring guideline
  ///
  /// In en, this message translates to:
  /// **'Monitor cardiovascular events'**
  String get dapt_guideline_discontinue_3;

  /// Follow-up guideline
  ///
  /// In en, this message translates to:
  /// **'Regular follow-up visits'**
  String get dapt_guideline_discontinue_4;

  /// Special cases guidelines
  ///
  /// In en, this message translates to:
  /// **'Special cases'**
  String get dapt_guideline_special_title;

  /// High bleeding risk guideline
  ///
  /// In en, this message translates to:
  /// **'High bleeding risk: consider discontinuation'**
  String get dapt_guideline_special_1;

  /// Elderly patients guideline
  ///
  /// In en, this message translates to:
  /// **'Elderly patients: careful assessment'**
  String get dapt_guideline_special_2;

  /// Drug interactions guideline
  ///
  /// In en, this message translates to:
  /// **'Drug interactions: adjust dosing'**
  String get dapt_guideline_special_3;

  /// Surgery guideline
  ///
  /// In en, this message translates to:
  /// **'Surgery: minimal interruption'**
  String get dapt_guideline_special_4;

  /// Clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get dapt_clinical_info;

  /// Clinical information text about DAPT Score
  ///
  /// In en, this message translates to:
  /// **'The DAPT Score helps decide whether to continue or discontinue dual antiplatelet therapy\n\nBackground:\n• DAPT Trial study (n=25,682)\n• Compared DAPT vs placebo after 12 months\n• Developed in 2016\n• Validated in multiple studies\n\nDAPT Components:\n• Aspirin 75-100mg\n• P2Y12 inhibitor (clopidogrel/ticagrelor/prasugrel)\n• Minimum 12 months after ACS/PCI\n\nMechanism of action:\n• COX-1 inhibition (aspirin)\n• P2Y12 receptor inhibition\n• Reduced platelet aggregation\n• Thrombosis prevention\n\nDAPT Complications:\n• Gastrointestinal bleeding\n• Intracranial hemorrhage\n• Mucosal bleeding\n• Drug interactions\n\nApplications:\n• Post-myocardial infarction\n• Post-percutaneous coronary intervention\n• Stable coronary artery disease\n• Secondary prevention\n\nLimitations:\n• Not applicable to all patients\n• Need bleeding risk assessment\n• Changes over time\n• Requires clinical judgment'**
  String get dapt_clinical_text;

  /// Reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get dapt_reference_title;

  /// DAPT Score reference citation
  ///
  /// In en, this message translates to:
  /// **'Yeh RW, Secemsky EA, Kereiakes DJ, et al. Development and validation of a prediction rule for benefit and harm of dual antiplatelet therapy beyond 1 year after percutaneous coronary intervention. JAMA. 2016;315(16):1735-49.'**
  String get dapt_reference_text;

  /// Creatinine Clearance list description
  ///
  /// In en, this message translates to:
  /// **'Kidney function assessment'**
  String get creatinine_clearance_list_description;

  /// Creatinine Clearance page title
  ///
  /// In en, this message translates to:
  /// **'Creatinine Clearance'**
  String get creatinine_clearance_title;

  /// Result section title
  ///
  /// In en, this message translates to:
  /// **'Creatinine Clearance'**
  String get creatinine_clearance_result;

  /// Creatinine clearance unit
  ///
  /// In en, this message translates to:
  /// **'ml/min'**
  String get creatinine_clearance_unit;

  /// Prompt when no values entered
  ///
  /// In en, this message translates to:
  /// **'Enter parameters to calculate'**
  String get creatinine_clearance_input_prompt;

  /// Input section title
  ///
  /// In en, this message translates to:
  /// **'Input Parameters (Cockcroft-Gault)'**
  String get creatinine_clearance_input_title;

  /// Age input label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get creatinine_clearance_age;

  /// Age unit
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get creatinine_clearance_age_unit;

  /// Weight input label
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get creatinine_clearance_weight;

  /// Weight unit
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get creatinine_clearance_weight_unit;

  /// Creatinine input label
  ///
  /// In en, this message translates to:
  /// **'Serum creatinine'**
  String get creatinine_clearance_creatinine;

  /// Normal creatinine values
  ///
  /// In en, this message translates to:
  /// **'Normal values: Male 0.7-1.3 mg/dL (62-115 umol/L), Female 0.6-1.1 mg/dL (53-97 umol/L)'**
  String get creatinine_clearance_creatinine_normal;

  /// Gender selection label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get creatinine_clearance_gender;

  /// Male option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get creatinine_clearance_male;

  /// Female option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get creatinine_clearance_female;

  /// Normal kidney function
  ///
  /// In en, this message translates to:
  /// **'Normal/High'**
  String get creatinine_clearance_function_normal;

  /// Mild kidney function decrease
  ///
  /// In en, this message translates to:
  /// **'Mild decrease'**
  String get creatinine_clearance_function_mild;

  /// Mild-moderate kidney function decrease
  ///
  /// In en, this message translates to:
  /// **'Mild-moderate decrease'**
  String get creatinine_clearance_function_mild_moderate;

  /// Moderate-severe kidney function decrease
  ///
  /// In en, this message translates to:
  /// **'Moderate-severe decrease'**
  String get creatinine_clearance_function_moderate_severe;

  /// Severe kidney function decrease
  ///
  /// In en, this message translates to:
  /// **'Severe decrease'**
  String get creatinine_clearance_function_severe;

  /// End-stage renal disease
  ///
  /// In en, this message translates to:
  /// **'End-stage renal disease'**
  String get creatinine_clearance_function_esrd;

  /// CKD Stage 1
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 1 (or normal)'**
  String get creatinine_clearance_stage_1;

  /// CKD Stage 2
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 2'**
  String get creatinine_clearance_stage_2;

  /// CKD Stage 3a
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 3a'**
  String get creatinine_clearance_stage_3a;

  /// CKD Stage 3b
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 3b'**
  String get creatinine_clearance_stage_3b;

  /// CKD Stage 4
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 4'**
  String get creatinine_clearance_stage_4;

  /// CKD Stage 5
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 5'**
  String get creatinine_clearance_stage_5;

  /// Normal drug dosing
  ///
  /// In en, this message translates to:
  /// **'Normal dose'**
  String get creatinine_clearance_dosing_normal;

  /// Reduce dose 25-50%
  ///
  /// In en, this message translates to:
  /// **'Reduce dose 25-50%'**
  String get creatinine_clearance_dosing_reduce_25_50;

  /// Reduce dose 50-75%
  ///
  /// In en, this message translates to:
  /// **'Reduce dose 50-75%'**
  String get creatinine_clearance_dosing_reduce_50_75;

  /// Drug contraindicated or dialysis needed
  ///
  /// In en, this message translates to:
  /// **'Contraindicated or dialysis needed'**
  String get creatinine_clearance_dosing_contraindicated;

  /// Recommendation for normal function
  ///
  /// In en, this message translates to:
  /// **'Normal monitoring, control risk factors'**
  String get creatinine_clearance_recommendation_normal;

  /// Recommendation for mild decrease
  ///
  /// In en, this message translates to:
  /// **'Screen for CKD complications, control risk factors'**
  String get creatinine_clearance_recommendation_mild;

  /// Recommendation for mild-moderate decrease
  ///
  /// In en, this message translates to:
  /// **'Evaluate and treat CKD complications'**
  String get creatinine_clearance_recommendation_mild_moderate;

  /// Recommendation for moderate-severe decrease
  ///
  /// In en, this message translates to:
  /// **'Prepare for renal replacement therapy'**
  String get creatinine_clearance_recommendation_moderate_severe;

  /// Recommendation for severe decrease
  ///
  /// In en, this message translates to:
  /// **'Renal replacement therapy if symptomatic'**
  String get creatinine_clearance_recommendation_severe;

  /// Recommendation for ESRD
  ///
  /// In en, this message translates to:
  /// **'Dialysis or kidney transplant'**
  String get creatinine_clearance_recommendation_esrd;

  /// Drug dosing section label
  ///
  /// In en, this message translates to:
  /// **'Drug dose adjustment'**
  String get creatinine_clearance_drug_dosing;

  /// Clinical recommendation label
  ///
  /// In en, this message translates to:
  /// **'Clinical recommendation:'**
  String get creatinine_clearance_clinical_recommendation;

  /// Reference values section title
  ///
  /// In en, this message translates to:
  /// **'Reference Values'**
  String get creatinine_clearance_reference_values;

  /// Normal range ≥90
  ///
  /// In en, this message translates to:
  /// **'≥ 90 ml/min'**
  String get creatinine_clearance_range_90;

  /// Range 60-89
  ///
  /// In en, this message translates to:
  /// **'60-89 ml/min'**
  String get creatinine_clearance_range_60_89;

  /// Range 45-59
  ///
  /// In en, this message translates to:
  /// **'45-59 ml/min'**
  String get creatinine_clearance_range_45_59;

  /// Range 30-44
  ///
  /// In en, this message translates to:
  /// **'30-44 ml/min'**
  String get creatinine_clearance_range_30_44;

  /// Range 15-29
  ///
  /// In en, this message translates to:
  /// **'15-29 ml/min'**
  String get creatinine_clearance_range_15_29;

  /// Range under 15
  ///
  /// In en, this message translates to:
  /// **'< 15 ml/min'**
  String get creatinine_clearance_range_under_15;

  /// Clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get creatinine_clearance_clinical_info;

  /// Clinical information text
  ///
  /// In en, this message translates to:
  /// **'Cockcroft-Gault Formula:\nCrCl = [(140 - age) × weight] / (72 × creatinine)\nFemale: multiply by 0.85\n\nImportant Notes:\n• Accuracy decreases when GFR > 60 ml/min\n• Not accurate in obese, elderly, acute illness\n• Drug dosing should be adjusted based on creatinine clearance\n• Monitor kidney function regularly in CKD patients\n• Consider CKD-EPI equation for higher accuracy'**
  String get creatinine_clearance_clinical_text;

  /// Reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get creatinine_clearance_reference_title;

  /// Reference citation
  ///
  /// In en, this message translates to:
  /// **'Cockcroft DW, Gault MH. Prediction of creatinine clearance from serum creatinine. Nephron. 1976;16(1):31-41.'**
  String get creatinine_clearance_reference_text;

  /// MDRD GFR list description
  ///
  /// In en, this message translates to:
  /// **'Glomerular filtration rate calculation'**
  String get mdrd_list_description;

  /// Hint text for search field in clinical scores
  ///
  /// In en, this message translates to:
  /// **'Search clinical scores...'**
  String get search_scores_hint;

  /// MEWS page title
  ///
  /// In en, this message translates to:
  /// **'MEWS Score'**
  String get mews_title;

  /// MEWS interpretation when no data entered
  ///
  /// In en, this message translates to:
  /// **'Please enter vital signs'**
  String get mews_interpretation_enter_data;

  /// MEWS interpretation for low scores
  ///
  /// In en, this message translates to:
  /// **'Stable condition - routine monitoring'**
  String get mews_interpretation_stable;

  /// MEWS interpretation for moderate scores
  ///
  /// In en, this message translates to:
  /// **'Increased monitoring required'**
  String get mews_interpretation_increased;

  /// MEWS interpretation for high scores
  ///
  /// In en, this message translates to:
  /// **'Warning - urgent medical assessment required'**
  String get mews_interpretation_warning;

  /// MEWS interpretation for critical scores
  ///
  /// In en, this message translates to:
  /// **'High alert - immediate intervention required'**
  String get mews_interpretation_critical;

  /// MEWS action for routine monitoring
  ///
  /// In en, this message translates to:
  /// **'Monitor every 12 hours'**
  String get mews_action_routine;

  /// MEWS action for increased monitoring
  ///
  /// In en, this message translates to:
  /// **'Monitor every 4-6 hours, notify doctor'**
  String get mews_action_increased;

  /// MEWS action for urgent cases
  ///
  /// In en, this message translates to:
  /// **'Monitor hourly, call doctor immediately'**
  String get mews_action_urgent;

  /// MEWS action for critical cases
  ///
  /// In en, this message translates to:
  /// **'Continuous monitoring, emergency report'**
  String get mews_action_critical;

  /// MEWS systolic blood pressure parameter
  ///
  /// In en, this message translates to:
  /// **'Systolic Blood Pressure (mmHg)'**
  String get mews_systolic_bp;

  /// MEWS heart rate parameter
  ///
  /// In en, this message translates to:
  /// **'Heart Rate (bpm)'**
  String get mews_heart_rate;

  /// MEWS respiratory rate parameter
  ///
  /// In en, this message translates to:
  /// **'Respiratory Rate (breaths/min)'**
  String get mews_respiratory_rate;

  /// MEWS temperature parameter
  ///
  /// In en, this message translates to:
  /// **'Temperature (°C)'**
  String get mews_temperature;

  /// MEWS consciousness level parameter
  ///
  /// In en, this message translates to:
  /// **'Consciousness Level (AVPU)'**
  String get mews_consciousness_level;

  /// Hint text for MEWS input fields
  ///
  /// In en, this message translates to:
  /// **'Enter value'**
  String get mews_enter_value;

  /// MEWS score label
  ///
  /// In en, this message translates to:
  /// **'Score: {score}'**
  String mews_score_label(int score);

  /// MEWS AVPU Alert option
  ///
  /// In en, this message translates to:
  /// **'Alert (Alert)'**
  String get mews_avpu_alert;

  /// MEWS AVPU Alert description
  ///
  /// In en, this message translates to:
  /// **'Patient alert, well oriented'**
  String get mews_avpu_alert_subtitle;

  /// MEWS AVPU Voice option
  ///
  /// In en, this message translates to:
  /// **'Voice (Responds to voice)'**
  String get mews_avpu_voice;

  /// MEWS AVPU Voice description
  ///
  /// In en, this message translates to:
  /// **'Only responds to loud voice'**
  String get mews_avpu_voice_subtitle;

  /// MEWS AVPU Pain option
  ///
  /// In en, this message translates to:
  /// **'Pain (Responds to pain)'**
  String get mews_avpu_pain;

  /// MEWS AVPU Pain description
  ///
  /// In en, this message translates to:
  /// **'Only responds to painful stimuli'**
  String get mews_avpu_pain_subtitle;

  /// MEWS AVPU Unresponsive option
  ///
  /// In en, this message translates to:
  /// **'Unresponsive (Unresponsive)'**
  String get mews_avpu_unresponsive;

  /// MEWS AVPU Unresponsive description
  ///
  /// In en, this message translates to:
  /// **'No response to any stimuli'**
  String get mews_avpu_unresponsive_subtitle;

  /// MEWS references section title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get mews_references_title;

  /// PEWS page title
  ///
  /// In en, this message translates to:
  /// **'PEWS Score'**
  String get pews_title;

  /// PEWS low risk level
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get pews_risk_low;

  /// PEWS medium risk level
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get pews_risk_medium;

  /// PEWS high risk level
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get pews_risk_high;

  /// PEWS critical risk level
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get pews_risk_critical;

  /// PEWS age input label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get pews_age_label;

  /// PEWS age input helper text
  ///
  /// In en, this message translates to:
  /// **'Needed to calculate normal values by age'**
  String get pews_age_helper;

  /// PEWS heart rate input label
  ///
  /// In en, this message translates to:
  /// **'Heart Rate'**
  String get pews_heart_rate_label;

  /// PEWS heart rate input helper text
  ///
  /// In en, this message translates to:
  /// **'Abnormal monitoring by age'**
  String get pews_heart_rate_helper;

  /// PEWS respiratory rate input label
  ///
  /// In en, this message translates to:
  /// **'Respiratory Rate'**
  String get pews_respiratory_rate_label;

  /// PEWS respiratory rate input helper text
  ///
  /// In en, this message translates to:
  /// **'Normal values vary by age group'**
  String get pews_respiratory_rate_helper;

  /// PEWS systolic BP input label
  ///
  /// In en, this message translates to:
  /// **'Systolic Blood Pressure'**
  String get pews_systolic_bp_label;

  /// PEWS systolic BP input helper text
  ///
  /// In en, this message translates to:
  /// **'Hypotension is a late sign in children'**
  String get pews_systolic_bp_helper;

  /// PEWS consciousness level section title
  ///
  /// In en, this message translates to:
  /// **'Consciousness Level'**
  String get pews_consciousness_level;

  /// PEWS consciousness alert option
  ///
  /// In en, this message translates to:
  /// **'Alert (0)'**
  String get pews_consciousness_alert;

  /// PEWS consciousness voice option
  ///
  /// In en, this message translates to:
  /// **'Responds to voice (+1)'**
  String get pews_consciousness_voice;

  /// PEWS consciousness pain option
  ///
  /// In en, this message translates to:
  /// **'Responds to pain (+2)'**
  String get pews_consciousness_pain;

  /// PEWS consciousness unresponsive option
  ///
  /// In en, this message translates to:
  /// **'Unresponsive (+3)'**
  String get pews_consciousness_unresponsive;

  /// PEWS oxygen therapy section title
  ///
  /// In en, this message translates to:
  /// **'Oxygen Therapy'**
  String get pews_oxygen_therapy;

  /// PEWS oxygen room air option
  ///
  /// In en, this message translates to:
  /// **'Room air (0)'**
  String get pews_oxygen_room_air;

  /// PEWS oxygen nasal cannula option
  ///
  /// In en, this message translates to:
  /// **'Nasal cannula (+1)'**
  String get pews_oxygen_nasal_cannula;

  /// PEWS oxygen face mask option
  ///
  /// In en, this message translates to:
  /// **'Face mask (+2)'**
  String get pews_oxygen_face_mask;

  /// PEWS oxygen high flow option
  ///
  /// In en, this message translates to:
  /// **'High flow oxygen/Non-invasive ventilation (+3)'**
  String get pews_oxygen_high_flow;

  /// PEWS risk level display
  ///
  /// In en, this message translates to:
  /// **'Risk {level}'**
  String pews_risk_level(String level);

  /// PEWS response level section title
  ///
  /// In en, this message translates to:
  /// **'Response Level'**
  String get pews_response_level;

  /// PEWS monitoring frequency section title
  ///
  /// In en, this message translates to:
  /// **'Monitoring Frequency'**
  String get pews_monitoring_frequency;

  /// PEWS clinical response section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Response'**
  String get pews_clinical_response;

  /// PEWS routine response level
  ///
  /// In en, this message translates to:
  /// **'Routine monitoring'**
  String get pews_response_routine;

  /// PEWS increased monitoring response
  ///
  /// In en, this message translates to:
  /// **'Increased monitoring'**
  String get pews_response_increased;

  /// PEWS active intervention response
  ///
  /// In en, this message translates to:
  /// **'Active intervention'**
  String get pews_response_active;

  /// PEWS monitoring frequency for low risk
  ///
  /// In en, this message translates to:
  /// **'Every 4-6 hours'**
  String get pews_frequency_4_6_hours;

  /// PEWS monitoring frequency for medium risk
  ///
  /// In en, this message translates to:
  /// **'Every hour'**
  String get pews_frequency_1_hour;

  /// PEWS monitoring frequency for high risk
  ///
  /// In en, this message translates to:
  /// **'Continuous'**
  String get pews_frequency_continuous;

  /// PEWS action for low scores
  ///
  /// In en, this message translates to:
  /// **'Continue current care, routine monitoring'**
  String get pews_action_continue_care;

  /// PEWS action for medium scores
  ///
  /// In en, this message translates to:
  /// **'Notify doctor, increase monitoring, consider transfer'**
  String get pews_action_notify_doctor;

  /// PEWS action for high scores
  ///
  /// In en, this message translates to:
  /// **'Call pediatric emergency team immediately, prepare ICU transfer'**
  String get pews_action_emergency_team;

  /// PEWS consciousness level section header
  ///
  /// In en, this message translates to:
  /// **'Consciousness Level'**
  String get pews_consciousness_title;

  /// PEWS routine care protocol title
  ///
  /// In en, this message translates to:
  /// **'PEWS 0-3: Routine Care'**
  String get pews_protocol_routine_title;

  /// PEWS increased monitoring protocol title
  ///
  /// In en, this message translates to:
  /// **'PEWS 4-6: Increased Monitoring'**
  String get pews_protocol_increased_title;

  /// PEWS urgent intervention protocol title
  ///
  /// In en, this message translates to:
  /// **'PEWS ≥7: Urgent Intervention'**
  String get pews_protocol_urgent_title;

  /// PEWS routine care protocol step 1
  ///
  /// In en, this message translates to:
  /// **'Monitor vital signs every 4-6 hours'**
  String get pews_protocol_routine_1;

  /// PEWS routine care protocol step 2
  ///
  /// In en, this message translates to:
  /// **'Record PEWS score'**
  String get pews_protocol_routine_2;

  /// PEWS routine care protocol step 3
  ///
  /// In en, this message translates to:
  /// **'Continue treatment plan'**
  String get pews_protocol_routine_3;

  /// PEWS routine care protocol step 4
  ///
  /// In en, this message translates to:
  /// **'Reassess if condition changes'**
  String get pews_protocol_routine_4;

  /// PEWS increased monitoring protocol step 1
  ///
  /// In en, this message translates to:
  /// **'Notify attending physician'**
  String get pews_protocol_increased_1;

  /// PEWS increased monitoring protocol step 2
  ///
  /// In en, this message translates to:
  /// **'Monitor vital signs every 1-2 hours'**
  String get pews_protocol_increased_2;

  /// PEWS increased monitoring protocol step 3
  ///
  /// In en, this message translates to:
  /// **'Review underlying cause'**
  String get pews_protocol_increased_3;

  /// PEWS increased monitoring protocol step 4
  ///
  /// In en, this message translates to:
  /// **'Consider pediatric consultation'**
  String get pews_protocol_increased_4;

  /// PEWS urgent intervention protocol step 1
  ///
  /// In en, this message translates to:
  /// **'Call pediatric emergency team immediately'**
  String get pews_protocol_urgent_1;

  /// PEWS urgent intervention protocol step 2
  ///
  /// In en, this message translates to:
  /// **'Continuous monitoring'**
  String get pews_protocol_urgent_2;

  /// PEWS urgent intervention protocol step 3
  ///
  /// In en, this message translates to:
  /// **'Prepare for PICU transfer'**
  String get pews_protocol_urgent_3;

  /// PEWS urgent intervention protocol step 4
  ///
  /// In en, this message translates to:
  /// **'ABC assessment'**
  String get pews_protocol_urgent_4;

  /// PEWS clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get pews_clinical_info_title;

  /// PEWS clinical information content
  ///
  /// In en, this message translates to:
  /// **'PEWS (Pediatric Early Warning Score) is a screening tool to identify children at risk of deterioration early\n\nAdvantages:\n• Early identification of critically ill children\n• Guides level of intervention\n• Improves treatment outcomes\n• Reduces cardiac arrest outside ICU\n\nNormal values by age:\n• <1 year: HR 100-170, RR 30-45\n• 1-5 years: HR 90-130, RR 20-35\n• 6-12 years: HR 80-110, RR 15-25\n• >12 years: HR 70-90, RR 12-22\n\nPediatric physiological characteristics:\n• Limited cardiopulmonary reserve\n• Hypotension is a late sign\n• Tachycardia and tachypnea are early signs\n• Altered consciousness indicates danger\n\nImportant considerations:\n• Adjust for age\n• Assess overall clinical picture\n• Monitor trends in changes\n• Combine with physical examination'**
  String get pews_clinical_info_description;

  /// PEWS references section title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get pews_references_title;

  /// PEWS references text
  ///
  /// In en, this message translates to:
  /// **'Monaghan A. Detecting and managing deterioration in children. Paediatr Nurs. 2005;17(1):32-5.\n\nPearson GA, et al. Should paediatric early warning scores be used in all pediatric wards? Arch Dis Child. 2017;102(1):4-6.\n\nLambert V, et al. The Paediatric Early Warning System (PEWS): where we are now and where we need to go. Clin Risk. 2017;23(1):12-19.'**
  String get pews_references_text;

  /// PEWS response protocol section title
  ///
  /// In en, this message translates to:
  /// **'Response Protocol'**
  String get pews_response_protocol_title;

  /// PEWS low risk interpretation
  ///
  /// In en, this message translates to:
  /// **'Low risk'**
  String get pews_interp_low_risk;

  /// PEWS moderate risk interpretation
  ///
  /// In en, this message translates to:
  /// **'Moderate risk'**
  String get pews_interp_moderate_risk;

  /// PEWS high risk interpretation
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get pews_interp_high_risk;

  /// PEWS monitoring frequency 4-6 hours
  ///
  /// In en, this message translates to:
  /// **'Every 4-6h'**
  String get pews_interp_frequency_4_6h;

  /// PEWS monitoring frequency 1-2 hours
  ///
  /// In en, this message translates to:
  /// **'Every 1-2h'**
  String get pews_interp_frequency_1_2h;

  /// PEWS continuous monitoring
  ///
  /// In en, this message translates to:
  /// **'Continuous'**
  String get pews_interp_frequency_continuous;

  /// PEWS routine care action
  ///
  /// In en, this message translates to:
  /// **'Routine care'**
  String get pews_interp_routine_care;

  /// PEWS notify physician action
  ///
  /// In en, this message translates to:
  /// **'Notify physician'**
  String get pews_interp_notify_physician;

  /// PEWS emergency team action
  ///
  /// In en, this message translates to:
  /// **'Pediatric emergency team'**
  String get pews_interp_emergency_team;

  /// PEWS risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'PEWS Risk Stratification'**
  String get pews_risk_stratification_title;

  /// PEWS recommendation section title
  ///
  /// In en, this message translates to:
  /// **'Recommendation:'**
  String get pews_recommendation_title;

  /// PEWS vital signs section title
  ///
  /// In en, this message translates to:
  /// **'Vital Signs'**
  String get pews_vital_signs_title;

  /// PEWS age unit
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get pews_age_unit;

  /// No description provided for @unit_per_minute.
  ///
  /// In en, this message translates to:
  /// **'/min'**
  String get unit_per_minute;

  /// No description provided for @sepsis_bundle_lactate_title.
  ///
  /// In en, this message translates to:
  /// **'1. Lactate Measurement'**
  String get sepsis_bundle_lactate_title;

  /// No description provided for @sepsis_bundle_lactate_desc.
  ///
  /// In en, this message translates to:
  /// **'Obtain serum lactate level'**
  String get sepsis_bundle_lactate_desc;

  /// No description provided for @sepsis_bundle_blood_culture_title.
  ///
  /// In en, this message translates to:
  /// **'2. Blood Cultures'**
  String get sepsis_bundle_blood_culture_title;

  /// No description provided for @sepsis_bundle_blood_culture_desc.
  ///
  /// In en, this message translates to:
  /// **'Obtain before antibiotic administration'**
  String get sepsis_bundle_blood_culture_desc;

  /// No description provided for @sepsis_bundle_antibiotics_title.
  ///
  /// In en, this message translates to:
  /// **'3. Broad-spectrum Antibiotics'**
  String get sepsis_bundle_antibiotics_title;

  /// No description provided for @sepsis_bundle_antibiotics_desc.
  ///
  /// In en, this message translates to:
  /// **'Administer within 1 hour'**
  String get sepsis_bundle_antibiotics_desc;

  /// No description provided for @sepsis_bundle_fluid_title.
  ///
  /// In en, this message translates to:
  /// **'4. Fluid Resuscitation'**
  String get sepsis_bundle_fluid_title;

  /// No description provided for @sepsis_bundle_fluid_desc.
  ///
  /// In en, this message translates to:
  /// **'30ml/kg if hypotensive or lactate ≥4'**
  String get sepsis_bundle_fluid_desc;

  /// No description provided for @sepsis_bundle_vasopressor_title.
  ///
  /// In en, this message translates to:
  /// **'5. Vasopressor'**
  String get sepsis_bundle_vasopressor_title;

  /// No description provided for @sepsis_bundle_vasopressor_desc.
  ///
  /// In en, this message translates to:
  /// **'If hypotension persists after fluid resuscitation'**
  String get sepsis_bundle_vasopressor_desc;

  /// TIMI STEMI page title
  ///
  /// In en, this message translates to:
  /// **'TIMI Score - STEMI'**
  String get timi_stemi_title;

  /// TIMI STEMI low risk level
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get timi_stemi_risk_low;

  /// TIMI STEMI moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get timi_stemi_risk_moderate;

  /// TIMI STEMI high risk level
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get timi_stemi_risk_high;

  /// TIMI STEMI very high risk level
  ///
  /// In en, this message translates to:
  /// **'Very High Risk'**
  String get timi_stemi_risk_very_high;

  /// TIMI STEMI 30-day mortality label
  ///
  /// In en, this message translates to:
  /// **'30-day mortality rate'**
  String get timi_stemi_mortality_30day;

  /// TIMI STEMI treatment recommendations label
  ///
  /// In en, this message translates to:
  /// **'Treatment recommendations:'**
  String get timi_stemi_treatment_recommendations;

  /// TIMI STEMI low risk treatment recommendation
  ///
  /// In en, this message translates to:
  /// **'Early PCI within 12h, standard guideline treatment'**
  String get timi_stemi_recommendation_low;

  /// TIMI STEMI moderate risk treatment recommendation
  ///
  /// In en, this message translates to:
  /// **'Emergency PCI, close monitoring for complications'**
  String get timi_stemi_recommendation_moderate;

  /// TIMI STEMI high risk treatment recommendation
  ///
  /// In en, this message translates to:
  /// **'Immediate PCI, circulatory support, ICU monitoring'**
  String get timi_stemi_recommendation_high;

  /// TIMI STEMI very high risk treatment recommendation
  ///
  /// In en, this message translates to:
  /// **'Maximum emergency intervention, consider mechanical circulatory support'**
  String get timi_stemi_recommendation_very_high;

  /// TIMI STEMI age 65-74 risk factor
  ///
  /// In en, this message translates to:
  /// **'Age 65-74'**
  String get timi_stemi_age_65_74;

  /// TIMI STEMI age 75+ risk factor
  ///
  /// In en, this message translates to:
  /// **'Age ≥75'**
  String get timi_stemi_age_75_plus;

  /// TIMI STEMI low weight risk factor
  ///
  /// In en, this message translates to:
  /// **'Weight <67kg'**
  String get timi_stemi_weight_low;

  /// TIMI STEMI diabetes/hypertension/angina risk factor
  ///
  /// In en, this message translates to:
  /// **'DM/HTN/Angina'**
  String get timi_stemi_dm_htn_angina;

  /// TIMI STEMI anterior MI or LBBB risk factor
  ///
  /// In en, this message translates to:
  /// **'Anterior MI/LBBB'**
  String get timi_stemi_anterior_mi_lbbb;

  /// TIMI STEMI time to treatment risk factor
  ///
  /// In en, this message translates to:
  /// **'Time to treatment >4h'**
  String get timi_stemi_time_to_treatment;

  /// TIMI STEMI heart rate ≥100 risk factor
  ///
  /// In en, this message translates to:
  /// **'Heart rate ≥100'**
  String get timi_stemi_hr_100_plus;

  /// TIMI STEMI low systolic BP risk factor
  ///
  /// In en, this message translates to:
  /// **'Systolic BP <100'**
  String get timi_stemi_sbp_low;

  /// TIMI STEMI age input label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get timi_stemi_age_label;

  /// TIMI STEMI weight input label
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get timi_stemi_weight_label;

  /// TIMI STEMI heart rate input label
  ///
  /// In en, this message translates to:
  /// **'Heart Rate'**
  String get timi_stemi_hr_label;

  /// TIMI STEMI systolic BP input label
  ///
  /// In en, this message translates to:
  /// **'Systolic BP'**
  String get timi_stemi_sbp_label;

  /// TIMI STEMI diabetes checkbox label
  ///
  /// In en, this message translates to:
  /// **'Diabetes'**
  String get timi_stemi_diabetes_label;

  /// TIMI STEMI hypertension checkbox label
  ///
  /// In en, this message translates to:
  /// **'Hypertension'**
  String get timi_stemi_hypertension_label;

  /// TIMI STEMI angina checkbox label
  ///
  /// In en, this message translates to:
  /// **'Angina'**
  String get timi_stemi_angina_label;

  /// TIMI STEMI anterior MI checkbox label
  ///
  /// In en, this message translates to:
  /// **'Anterior MI/LBBB'**
  String get timi_stemi_anterior_mi_label;

  /// TIMI STEMI time to treatment checkbox label
  ///
  /// In en, this message translates to:
  /// **'Time to treatment >4h'**
  String get timi_stemi_time_4h_label;

  /// TIMI STEMI systolic blood pressure input label
  ///
  /// In en, this message translates to:
  /// **'Systolic BP'**
  String get timi_stemi_systolic_bp_label;

  /// TIMI STEMI systolic blood pressure unit
  ///
  /// In en, this message translates to:
  /// **'mmHg'**
  String get timi_stemi_systolic_bp_unit;

  /// TIMI UA/NSTEMI page title
  ///
  /// In en, this message translates to:
  /// **'TIMI Score - UA/NSTEMI'**
  String get timi_ua_nstemi_title;

  /// TIMI UA/NSTEMI age input label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get timi_ua_nstemi_age_label;

  /// TIMI UA/NSTEMI age unit
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get timi_ua_nstemi_age_unit;

  /// TIMI UA/NSTEMI CAD risk factors checkbox
  ///
  /// In en, this message translates to:
  /// **'≥3 CAD risk factors'**
  String get timi_ua_nstemi_cad_risk_factors;

  /// TIMI UA/NSTEMI CAD risk factors description
  ///
  /// In en, this message translates to:
  /// **'Family history, HTN, DM, smoking, high cholesterol'**
  String get timi_ua_nstemi_cad_risk_factors_subtitle;

  /// TIMI UA/NSTEMI known CAD checkbox
  ///
  /// In en, this message translates to:
  /// **'Known CAD (stenosis ≥50%)'**
  String get timi_ua_nstemi_known_cad;

  /// TIMI UA/NSTEMI known CAD description
  ///
  /// In en, this message translates to:
  /// **'Prior intervention or imaging evidence'**
  String get timi_ua_nstemi_known_cad_subtitle;

  /// TIMI UA/NSTEMI aspirin use checkbox
  ///
  /// In en, this message translates to:
  /// **'Aspirin use in prior 7 days'**
  String get timi_ua_nstemi_aspirin_use;

  /// TIMI UA/NSTEMI aspirin use description
  ///
  /// In en, this message translates to:
  /// **'Aspirin use before admission'**
  String get timi_ua_nstemi_aspirin_use_subtitle;

  /// TIMI UA/NSTEMI severe angina checkbox
  ///
  /// In en, this message translates to:
  /// **'≥2 severe anginal events in 24h'**
  String get timi_ua_nstemi_severe_angina;

  /// TIMI UA/NSTEMI severe angina description
  ///
  /// In en, this message translates to:
  /// **'Progressive or recurrent angina'**
  String get timi_ua_nstemi_severe_angina_subtitle;

  /// TIMI UA/NSTEMI ST changes checkbox
  ///
  /// In en, this message translates to:
  /// **'ST changes ≥0.5mm'**
  String get timi_ua_nstemi_st_changes;

  /// TIMI UA/NSTEMI ST changes description
  ///
  /// In en, this message translates to:
  /// **'ST segment changes on ECG'**
  String get timi_ua_nstemi_st_changes_subtitle;

  /// TIMI UA/NSTEMI elevated markers checkbox
  ///
  /// In en, this message translates to:
  /// **'Elevated cardiac markers'**
  String get timi_ua_nstemi_elevated_markers;

  /// TIMI UA/NSTEMI elevated markers description
  ///
  /// In en, this message translates to:
  /// **'Elevated troponin or CK-MB'**
  String get timi_ua_nstemi_elevated_markers_subtitle;

  /// TIMI UA/NSTEMI risk factors section title
  ///
  /// In en, this message translates to:
  /// **'Risk Factors'**
  String get timi_ua_nstemi_risk_factors_title;

  /// TIMI UA/NSTEMI patient parameters title
  ///
  /// In en, this message translates to:
  /// **'Patient Parameters'**
  String get timi_ua_nstemi_patient_parameters;

  /// TIMI UA/NSTEMI clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get timi_ua_nstemi_clinical_info;

  /// TIMI UA/NSTEMI low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Medical treatment, outpatient follow-up may be considered'**
  String get timi_ua_nstemi_recommendation_low;

  /// TIMI UA/NSTEMI moderate risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Hospital admission, consider early intervention within 24-48h'**
  String get timi_ua_nstemi_recommendation_moderate;

  /// TIMI UA/NSTEMI high risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Early coronary intervention within 24h, aggressive treatment'**
  String get timi_ua_nstemi_recommendation_high;

  /// TIMI UA/NSTEMI conservative management strategy
  ///
  /// In en, this message translates to:
  /// **'Conservative strategy'**
  String get timi_ua_nstemi_strategy_conservative;

  /// TIMI UA/NSTEMI selective intervention strategy
  ///
  /// In en, this message translates to:
  /// **'Selective intervention strategy'**
  String get timi_ua_nstemi_strategy_selective;

  /// TIMI UA/NSTEMI early intervention strategy
  ///
  /// In en, this message translates to:
  /// **'Early intervention strategy'**
  String get timi_ua_nstemi_strategy_early;

  /// TIMI UA/NSTEMI references section title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get timi_ua_nstemi_references;

  /// TIMI UA/NSTEMI 14-day events column header
  ///
  /// In en, this message translates to:
  /// **'14-day Events'**
  String get timi_ua_nstemi_14_day_events;

  /// TIMI UA/NSTEMI treatment strategy label
  ///
  /// In en, this message translates to:
  /// **'Treatment Strategy:'**
  String get timi_ua_nstemi_treatment_strategy;

  /// TIMI UA/NSTEMI mortality column header
  ///
  /// In en, this message translates to:
  /// **'Mortality'**
  String get timi_ua_nstemi_mortality;

  /// TIMI UA/NSTEMI recommendation label
  ///
  /// In en, this message translates to:
  /// **'Recommendation:'**
  String get timi_ua_nstemi_recommendation;

  /// CRUSADE page title
  ///
  /// In en, this message translates to:
  /// **'CRUSADE Bleeding Risk'**
  String get crusade_title;

  /// CRUSADE score label
  ///
  /// In en, this message translates to:
  /// **'CRUSADE Score'**
  String get crusade_score;

  /// CRUSADE very low risk level
  ///
  /// In en, this message translates to:
  /// **'Very Low Risk'**
  String get crusade_risk_very_low;

  /// CRUSADE low risk level
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get crusade_risk_low;

  /// CRUSADE moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get crusade_risk_moderate;

  /// CRUSADE high risk level
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get crusade_risk_high;

  /// CRUSADE very high risk level
  ///
  /// In en, this message translates to:
  /// **'Very High Risk'**
  String get crusade_risk_very_high;

  /// CRUSADE bleeding risk label
  ///
  /// In en, this message translates to:
  /// **'Bleeding Risk'**
  String get crusade_bleeding_risk;

  /// CRUSADE major bleeding label
  ///
  /// In en, this message translates to:
  /// **'Major Bleeding'**
  String get crusade_major_bleeding;

  /// CRUSADE recommendation label
  ///
  /// In en, this message translates to:
  /// **'Recommendation:'**
  String get crusade_recommendation;

  /// CRUSADE clinical parameters section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Parameters'**
  String get crusade_clinical_parameters;

  /// CRUSADE hematocrit input label
  ///
  /// In en, this message translates to:
  /// **'Hematocrit'**
  String get crusade_hematocrit;

  /// CRUSADE creatinine input label
  ///
  /// In en, this message translates to:
  /// **'Creatinine'**
  String get crusade_creatinine;

  /// CRUSADE creatinine helper text
  ///
  /// In en, this message translates to:
  /// **'Serum creatinine concentration'**
  String get crusade_creatinine_helper;

  /// CRUSADE unit label
  ///
  /// In en, this message translates to:
  /// **'Unit:'**
  String get crusade_unit;

  /// CRUSADE heart rate input label
  ///
  /// In en, this message translates to:
  /// **'Heart Rate'**
  String get crusade_heart_rate;

  /// CRUSADE heart rate unit
  ///
  /// In en, this message translates to:
  /// **'bpm'**
  String get crusade_heart_rate_unit;

  /// CRUSADE heart rate helper text
  ///
  /// In en, this message translates to:
  /// **'Heart rate on admission'**
  String get crusade_heart_rate_helper;

  /// CRUSADE systolic BP input label
  ///
  /// In en, this message translates to:
  /// **'Systolic Blood Pressure'**
  String get crusade_systolic_bp;

  /// CRUSADE systolic BP helper text
  ///
  /// In en, this message translates to:
  /// **'To assess signs of heart failure'**
  String get crusade_systolic_bp_helper;

  /// CRUSADE gender label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get crusade_gender;

  /// CRUSADE male option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get crusade_male;

  /// CRUSADE female option with points
  ///
  /// In en, this message translates to:
  /// **'Female (+8)'**
  String get crusade_female;

  /// CRUSADE diabetes label
  ///
  /// In en, this message translates to:
  /// **'Diabetes Mellitus'**
  String get crusade_diabetes;

  /// CRUSADE no option
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get crusade_no;

  /// CRUSADE yes option for diabetes with points
  ///
  /// In en, this message translates to:
  /// **'Yes (+6)'**
  String get crusade_yes;

  /// CRUSADE prior vascular disease label
  ///
  /// In en, this message translates to:
  /// **'Prior Vascular Disease'**
  String get crusade_vascular_disease;

  /// CRUSADE yes option for vascular disease with points
  ///
  /// In en, this message translates to:
  /// **'Yes (+6)'**
  String get crusade_vascular_yes;

  /// CRUSADE very low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Can use early invasive strategy and strong anticoagulation'**
  String get crusade_recommendation_very_low;

  /// CRUSADE low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Consider benefit/risk of invasive strategy and anticoagulation'**
  String get crusade_recommendation_low;

  /// CRUSADE moderate risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Cautious with invasive strategy, close monitoring'**
  String get crusade_recommendation_moderate;

  /// CRUSADE high risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Prefer conservative strategy, limit strong anticoagulation'**
  String get crusade_recommendation_high;

  /// CRUSADE very high risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Conservative strategy, avoid strong anticoagulation unless necessary'**
  String get crusade_recommendation_very_high;

  /// CRUSADE very low major bleeding risk
  ///
  /// In en, this message translates to:
  /// **'Very Low (<5%)'**
  String get crusade_major_bleeding_very_low;

  /// CRUSADE low major bleeding risk
  ///
  /// In en, this message translates to:
  /// **'Low (5-10%)'**
  String get crusade_major_bleeding_low;

  /// CRUSADE moderate major bleeding risk
  ///
  /// In en, this message translates to:
  /// **'Moderate (10-15%)'**
  String get crusade_major_bleeding_moderate;

  /// CRUSADE high major bleeding risk
  ///
  /// In en, this message translates to:
  /// **'High (15-20%)'**
  String get crusade_major_bleeding_high;

  /// CRUSADE very high major bleeding risk
  ///
  /// In en, this message translates to:
  /// **'Very High (>20%)'**
  String get crusade_major_bleeding_very_high;

  /// CRUSADE risk category display
  ///
  /// In en, this message translates to:
  /// **'Risk {riskLevel}'**
  String crusade_risk_category(String riskLevel);

  /// CRUSADE bleeding risk label
  ///
  /// In en, this message translates to:
  /// **'Bleeding Risk'**
  String get crusade_bleeding_risk_label;

  /// CRUSADE major bleeding label
  ///
  /// In en, this message translates to:
  /// **'Major Bleeding'**
  String get crusade_major_bleeding_label;

  /// CRUSADE recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get crusade_recommendation_label;

  /// CRUSADE hematocrit input label
  ///
  /// In en, this message translates to:
  /// **'Hematocrit'**
  String get crusade_hematocrit_label;

  /// CRUSADE hematocrit helper text
  ///
  /// In en, this message translates to:
  /// **'Red blood cell volume percentage'**
  String get crusade_hematocrit_helper;

  /// CRUSADE creatinine input label
  ///
  /// In en, this message translates to:
  /// **'Creatinine'**
  String get crusade_creatinine_label;

  /// CRUSADE references section title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get crusade_references;

  /// CRUSADE unit label
  ///
  /// In en, this message translates to:
  /// **'Unit:'**
  String get crusade_unit_label;

  /// CRUSADE systolic BP unit
  ///
  /// In en, this message translates to:
  /// **'mmHg'**
  String get crusade_systolic_bp_unit;

  /// CRUSADE gender label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get crusade_gender_label;

  /// CRUSADE male option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get crusade_male_label;

  /// CRUSADE female option with points
  ///
  /// In en, this message translates to:
  /// **'Female (+8)'**
  String get crusade_female_label;

  /// CRUSADE diabetes label
  ///
  /// In en, this message translates to:
  /// **'Diabetes Mellitus'**
  String get crusade_diabetes_label;

  /// CRUSADE no option
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get crusade_no_label;

  /// CRUSADE yes option for diabetes with points
  ///
  /// In en, this message translates to:
  /// **'Yes (+6)'**
  String get crusade_yes_diabetes;

  /// CRUSADE prior vascular disease label
  ///
  /// In en, this message translates to:
  /// **'Prior Vascular Disease'**
  String get crusade_vascular_disease_label;

  /// CRUSADE yes option for vascular disease with points
  ///
  /// In en, this message translates to:
  /// **'Yes (+6)'**
  String get crusade_yes_vascular;

  /// CRUSADE risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'CRUSADE Risk Stratification'**
  String get crusade_risk_stratification;

  /// CRUSADE very low risk strategy
  ///
  /// In en, this message translates to:
  /// **'Aggressive invasive'**
  String get crusade_strategy_very_low;

  /// CRUSADE low risk strategy
  ///
  /// In en, this message translates to:
  /// **'Consider invasive'**
  String get crusade_strategy_low;

  /// CRUSADE moderate risk strategy
  ///
  /// In en, this message translates to:
  /// **'Cautious'**
  String get crusade_strategy_moderate;

  /// CRUSADE high risk strategy
  ///
  /// In en, this message translates to:
  /// **'Prefer conservative'**
  String get crusade_strategy_high;

  /// CRUSADE very high risk strategy
  ///
  /// In en, this message translates to:
  /// **'Conservative'**
  String get crusade_strategy_very_high;

  /// CRUSADE clinical approach section title
  ///
  /// In en, this message translates to:
  /// **'Treatment Strategy'**
  String get crusade_clinical_approach;

  /// CRUSADE invasive strategy title
  ///
  /// In en, this message translates to:
  /// **'Invasive Strategy (Low Risk)'**
  String get crusade_invasive_strategy;

  /// CRUSADE conservative strategy title
  ///
  /// In en, this message translates to:
  /// **'Conservative Strategy (High Risk)'**
  String get crusade_conservative_strategy;

  /// CRUSADE invasive strategy item 1
  ///
  /// In en, this message translates to:
  /// **'Early coronary intervention'**
  String get crusade_invasive_item1;

  /// CRUSADE invasive strategy item 2
  ///
  /// In en, this message translates to:
  /// **'GPIIb/IIIa inhibitor'**
  String get crusade_invasive_item2;

  /// CRUSADE invasive strategy item 3
  ///
  /// In en, this message translates to:
  /// **'Dual antiplatelet therapy'**
  String get crusade_invasive_item3;

  /// CRUSADE invasive strategy item 4
  ///
  /// In en, this message translates to:
  /// **'Full anticoagulation'**
  String get crusade_invasive_item4;

  /// CRUSADE conservative strategy item 1
  ///
  /// In en, this message translates to:
  /// **'Optimal medical therapy'**
  String get crusade_conservative_item1;

  /// CRUSADE conservative strategy item 2
  ///
  /// In en, this message translates to:
  /// **'Avoid GPIIb/IIIa inhibitor'**
  String get crusade_conservative_item2;

  /// CRUSADE conservative strategy item 3
  ///
  /// In en, this message translates to:
  /// **'Consider aspirin monotherapy'**
  String get crusade_conservative_item3;

  /// CRUSADE conservative strategy item 4
  ///
  /// In en, this message translates to:
  /// **'Low-dose heparin'**
  String get crusade_conservative_item4;

  /// CRUSADE clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get crusade_clinical_info;

  /// CRUSADE clinical information content
  ///
  /// In en, this message translates to:
  /// **'CRUSADE Score assesses bleeding risk in acute coronary syndrome\n\nClinical applications:\n• Selection of invasive vs conservative strategy\n• Decision on GPIIb/IIIa inhibitor use\n• Consideration of dual antiplatelet therapy\n• Optimization of anticoagulation dosing\n\nKey factors:\n• Hematocrit: reflects anemia\n• Creatinine: kidney function\n• Heart rate: severity of illness\n• Female gender: higher risk\n• Diabetes mellitus: vascular complications\n• Prior vascular disease: high risk\n\nImportant notes:\n• Do not exclude treatment when score is high\n• Balance ischemic vs bleeding risk\n• May adjust medication dosing\n• Monitor high-risk patients closely\n• Reassess when condition changes'**
  String get crusade_clinical_info_content;

  /// HAS-BLED score page title
  ///
  /// In en, this message translates to:
  /// **'HAS-BLED Score'**
  String get has_bled_title;

  /// HAS-BLED low risk level
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get has_bled_risk_low;

  /// HAS-BLED moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get has_bled_risk_moderate;

  /// HAS-BLED high risk level
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get has_bled_risk_high;

  /// HAS-BLED bleeding risk label
  ///
  /// In en, this message translates to:
  /// **'Bleeding Risk'**
  String get has_bled_bleeding_risk;

  /// HAS-BLED clinical approach label
  ///
  /// In en, this message translates to:
  /// **'Clinical Approach'**
  String get has_bled_clinical_approach;

  /// HAS-BLED recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get has_bled_recommendations;

  /// HAS-BLED low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Can use anticoagulation with routine monitoring'**
  String get has_bled_recommendation_low;

  /// HAS-BLED moderate risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Use caution, consider benefit/risk ratio, monitor closely'**
  String get has_bled_recommendation_moderate;

  /// HAS-BLED high risk recommendation
  ///
  /// In en, this message translates to:
  /// **'High bleeding risk, thorough assessment before anticoagulation'**
  String get has_bled_recommendation_high;

  /// HAS-BLED low risk clinical approach
  ///
  /// In en, this message translates to:
  /// **'Continue/start anticoagulation with regular monitoring'**
  String get has_bled_approach_low;

  /// HAS-BLED moderate risk clinical approach
  ///
  /// In en, this message translates to:
  /// **'Consider dose reduction or more frequent monitoring'**
  String get has_bled_approach_moderate;

  /// HAS-BLED high risk clinical approach
  ///
  /// In en, this message translates to:
  /// **'Consider stopping anticoagulation or switching medication'**
  String get has_bled_approach_high;

  /// HAS-BLED risk factors section title
  ///
  /// In en, this message translates to:
  /// **'HAS-BLED Risk Factors'**
  String get has_bled_risk_factors;

  /// HAS-BLED hypertension factor
  ///
  /// In en, this message translates to:
  /// **'Hypertension (H) (+1)'**
  String get has_bled_hypertension;

  /// HAS-BLED hypertension description
  ///
  /// In en, this message translates to:
  /// **'Uncontrolled hypertension (>160 mmHg)'**
  String get has_bled_hypertension_desc;

  /// HAS-BLED abnormal renal factor
  ///
  /// In en, this message translates to:
  /// **'Abnormal renal function (A) (+1)'**
  String get has_bled_abnormal_renal;

  /// HAS-BLED abnormal renal description
  ///
  /// In en, this message translates to:
  /// **'Abnormal kidney function (Cr >2.26 mg/dL)'**
  String get has_bled_abnormal_renal_desc;

  /// HAS-BLED abnormal liver factor
  ///
  /// In en, this message translates to:
  /// **'Abnormal liver function (S) (+1)'**
  String get has_bled_abnormal_liver;

  /// HAS-BLED abnormal liver description
  ///
  /// In en, this message translates to:
  /// **'Abnormal liver function (bilirubin >2x, AST/ALT >3x)'**
  String get has_bled_abnormal_liver_desc;

  /// HAS-BLED stroke factor
  ///
  /// In en, this message translates to:
  /// **'Stroke (B) (+1)'**
  String get has_bled_stroke;

  /// HAS-BLED stroke description
  ///
  /// In en, this message translates to:
  /// **'History of stroke'**
  String get has_bled_stroke_desc;

  /// HAS-BLED bleeding factor
  ///
  /// In en, this message translates to:
  /// **'Bleeding (L) (+1)'**
  String get has_bled_bleeding;

  /// HAS-BLED bleeding description
  ///
  /// In en, this message translates to:
  /// **'History of bleeding or bleeding tendency'**
  String get has_bled_bleeding_desc;

  /// HAS-BLED labile INR factor
  ///
  /// In en, this message translates to:
  /// **'Labile INR (E) (+1)'**
  String get has_bled_labile_inr;

  /// HAS-BLED labile INR description
  ///
  /// In en, this message translates to:
  /// **'Unstable INR (TTR <60%)'**
  String get has_bled_labile_inr_desc;

  /// HAS-BLED elderly factor
  ///
  /// In en, this message translates to:
  /// **'Elderly (D) (+1)'**
  String get has_bled_elderly;

  /// HAS-BLED elderly description
  ///
  /// In en, this message translates to:
  /// **'Age >65'**
  String get has_bled_elderly_desc;

  /// HAS-BLED drugs factor
  ///
  /// In en, this message translates to:
  /// **'Drugs (+1)'**
  String get has_bled_drugs;

  /// HAS-BLED drugs description
  ///
  /// In en, this message translates to:
  /// **'Concomitant drugs/alcohol'**
  String get has_bled_drugs_desc;

  /// HAS-BLED alcohol factor
  ///
  /// In en, this message translates to:
  /// **'Alcohol (+1)'**
  String get has_bled_alcohol;

  /// HAS-BLED alcohol description
  ///
  /// In en, this message translates to:
  /// **'Alcohol abuse'**
  String get has_bled_alcohol_desc;

  /// HAS-BLED active factors section title
  ///
  /// In en, this message translates to:
  /// **'Current Risk Factors ({count})'**
  String has_bled_active_factors(int count);

  /// HAS-BLED risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'Bleeding Risk Stratification'**
  String get has_bled_risk_stratification;

  /// HAS-BLED continue anticoagulation action
  ///
  /// In en, this message translates to:
  /// **'Continue anticoagulation'**
  String get has_bled_continue_anticoag;

  /// HAS-BLED caution monitor action
  ///
  /// In en, this message translates to:
  /// **'Caution, monitor closely'**
  String get has_bled_caution_monitor;

  /// HAS-BLED consider stopping action
  ///
  /// In en, this message translates to:
  /// **'Consider stopping medication'**
  String get has_bled_consider_stop;

  /// HAS-BLED clinical approach section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Approach'**
  String get has_bled_clinical_approach_title;

  /// HAS-BLED approach for specific score
  ///
  /// In en, this message translates to:
  /// **'Approach for score {score}:'**
  String has_bled_approach_for_score(int score);

  /// HAS-BLED clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get has_bled_clinical_info;

  /// HAS-BLED clinical information content
  ///
  /// In en, this message translates to:
  /// **'HAS-BLED Score assesses bleeding risk when using anticoagulation\n\nClinical applications:\n• Assess bleeding risk before starting anticoagulation\n• Balance benefit/risk in treatment\n• Determine dosage and monitoring frequency\n• Patient counseling about risks\n\nFactor explanations:\n• H (Hypertension): Systolic BP >160 mmHg\n• A (Abnormal): Cr >2.26 mg/dL or dialysis\n• S (Stroke): History of stroke regardless of cause\n• B (Bleeding): History of major bleeding\n• L (Labile): Unstable INR, TTR <60%\n• E (Elderly): Age >65\n• D (Drugs): NSAID, aspirin, corticosteroids\n\nImportant notes:\n• High score does not mean contraindication to anticoagulation\n• Must consider with thromboembolism risk\n• Risk factors can be modified\n• Monitor closely if high score'**
  String get has_bled_clinical_info_content;

  /// HAS-BLED references section title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get has_bled_references;

  /// HAS-BLED low risk range
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get has_bled_risk_low_range;

  /// HAS-BLED moderate risk range
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get has_bled_risk_moderate_range;

  /// HAS-BLED high risk range
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get has_bled_risk_high_range;

  /// HAS-BLED hypertension factor name
  ///
  /// In en, this message translates to:
  /// **'Hypertension (H)'**
  String get has_bled_factor_hypertension;

  /// HAS-BLED abnormal renal factor name
  ///
  /// In en, this message translates to:
  /// **'Abnormal renal (A)'**
  String get has_bled_factor_abnormal_renal;

  /// HAS-BLED abnormal liver factor name
  ///
  /// In en, this message translates to:
  /// **'Abnormal liver (S)'**
  String get has_bled_factor_abnormal_liver;

  /// HAS-BLED stroke factor name
  ///
  /// In en, this message translates to:
  /// **'Stroke (B)'**
  String get has_bled_factor_stroke;

  /// HAS-BLED bleeding factor name
  ///
  /// In en, this message translates to:
  /// **'Bleeding (L)'**
  String get has_bled_factor_bleeding;

  /// HAS-BLED labile INR factor name
  ///
  /// In en, this message translates to:
  /// **'Labile INR (E)'**
  String get has_bled_factor_labile_inr;

  /// HAS-BLED elderly factor name
  ///
  /// In en, this message translates to:
  /// **'Elderly (D)'**
  String get has_bled_factor_elderly;

  /// HAS-BLED drugs factor name
  ///
  /// In en, this message translates to:
  /// **'Drugs'**
  String get has_bled_factor_drugs;

  /// HAS-BLED alcohol factor name
  ///
  /// In en, this message translates to:
  /// **'Alcohol'**
  String get has_bled_factor_alcohol;

  /// IMPROVE Bleeding Risk score title
  ///
  /// In en, this message translates to:
  /// **'IMPROVE Bleeding Risk'**
  String get improve_bleeding_risk_title;

  /// IMPROVE Bleeding Risk score name
  ///
  /// In en, this message translates to:
  /// **'IMPROVE Bleeding Risk Score'**
  String get improve_bleeding_risk_score;

  /// IMPROVE low risk level
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get improve_low_risk;

  /// IMPROVE moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get improve_moderate_risk;

  /// IMPROVE high risk level
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get improve_high_risk;

  /// IMPROVE bleeding risk label
  ///
  /// In en, this message translates to:
  /// **'Bleeding Risk'**
  String get improve_bleeding_risk;

  /// IMPROVE major bleeding label
  ///
  /// In en, this message translates to:
  /// **'Major Bleeding'**
  String get improve_major_bleeding;

  /// IMPROVE prophylaxis strategy label
  ///
  /// In en, this message translates to:
  /// **'Prophylaxis strategy:'**
  String get improve_prophylaxis_strategy;

  /// IMPROVE recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get improve_recommendations;

  /// IMPROVE standard prophylaxis strategy
  ///
  /// In en, this message translates to:
  /// **'Standard prophylaxis'**
  String get improve_standard_prophylaxis;

  /// IMPROVE careful prophylaxis strategy
  ///
  /// In en, this message translates to:
  /// **'Careful prophylaxis, reduce dose'**
  String get improve_careful_prophylaxis;

  /// IMPROVE mechanical prophylaxis strategy
  ///
  /// In en, this message translates to:
  /// **'Consider mechanical prophylaxis'**
  String get improve_mechanical_prophylaxis;

  /// IMPROVE standard anticoagulation recommendation
  ///
  /// In en, this message translates to:
  /// **'Standard anticoagulation prophylaxis may be used'**
  String get improve_standard_anticoagulation;

  /// IMPROVE careful consideration recommendation
  ///
  /// In en, this message translates to:
  /// **'Careful benefit/risk consideration, close monitoring when using anticoagulants'**
  String get improve_careful_consideration;

  /// IMPROVE caution with anticoagulants recommendation
  ///
  /// In en, this message translates to:
  /// **'Caution with anticoagulants, consider mechanical thromboprophylaxis'**
  String get improve_caution_anticoagulants;

  /// IMPROVE patient information section title
  ///
  /// In en, this message translates to:
  /// **'Patient Information'**
  String get improve_patient_information;

  /// IMPROVE age field label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get improve_age;

  /// IMPROVE age field helper text
  ///
  /// In en, this message translates to:
  /// **'+1 point if ≥40 years'**
  String get improve_age_helper;

  /// IMPROVE years unit
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get improve_years;

  /// IMPROVE bleeding risk factors section title
  ///
  /// In en, this message translates to:
  /// **'Bleeding Risk Factors'**
  String get improve_bleeding_risk_factors;

  /// IMPROVE female factor
  ///
  /// In en, this message translates to:
  /// **'Female (+1)'**
  String get improve_female;

  /// IMPROVE female factor description
  ///
  /// In en, this message translates to:
  /// **'Female gender'**
  String get improve_female_desc;

  /// IMPROVE cancer factor
  ///
  /// In en, this message translates to:
  /// **'Cancer (+2)'**
  String get improve_cancer;

  /// IMPROVE cancer factor description
  ///
  /// In en, this message translates to:
  /// **'Current or history of cancer'**
  String get improve_cancer_desc;

  /// IMPROVE dialysis factor
  ///
  /// In en, this message translates to:
  /// **'Dialysis (+2)'**
  String get improve_dialysis;

  /// IMPROVE dialysis factor description
  ///
  /// In en, this message translates to:
  /// **'Hemodialysis'**
  String get improve_dialysis_desc;

  /// IMPROVE liver disease factor
  ///
  /// In en, this message translates to:
  /// **'Liver disease (+2)'**
  String get improve_liver_disease;

  /// IMPROVE liver disease factor description
  ///
  /// In en, this message translates to:
  /// **'Chronic liver disease'**
  String get improve_liver_disease_desc;

  /// IMPROVE ICU stay factor
  ///
  /// In en, this message translates to:
  /// **'ICU stay (+2)'**
  String get improve_icu_stay;

  /// IMPROVE ICU stay factor description
  ///
  /// In en, this message translates to:
  /// **'Currently treated in ICU'**
  String get improve_icu_stay_desc;

  /// IMPROVE ICU >48h factor
  ///
  /// In en, this message translates to:
  /// **'ICU >48h (+1)'**
  String get improve_icu_48h;

  /// IMPROVE ICU >48h factor description
  ///
  /// In en, this message translates to:
  /// **'ICU stay over 48 hours'**
  String get improve_icu_48h_desc;

  /// IMPROVE anticoagulants factor
  ///
  /// In en, this message translates to:
  /// **'Anticoagulants (+1)'**
  String get improve_anticoagulants;

  /// IMPROVE anticoagulants factor description
  ///
  /// In en, this message translates to:
  /// **'Currently using anticoagulants'**
  String get improve_anticoagulants_desc;

  /// IMPROVE current risk factors title
  ///
  /// In en, this message translates to:
  /// **'Current Risk Factors ({count})'**
  String improve_current_risk_factors(int count);

  /// IMPROVE age factor name
  ///
  /// In en, this message translates to:
  /// **'Age ≥40'**
  String get improve_age_factor;

  /// IMPROVE age factor description
  ///
  /// In en, this message translates to:
  /// **'Age 40 years or older'**
  String get improve_age_factor_desc;

  /// IMPROVE female factor name
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get improve_female_factor;

  /// IMPROVE cancer factor name
  ///
  /// In en, this message translates to:
  /// **'Cancer'**
  String get improve_cancer_factor;

  /// IMPROVE dialysis factor name
  ///
  /// In en, this message translates to:
  /// **'Dialysis'**
  String get improve_dialysis_factor;

  /// IMPROVE liver disease factor name
  ///
  /// In en, this message translates to:
  /// **'Liver disease'**
  String get improve_liver_disease_factor;

  /// IMPROVE ICU stay factor name
  ///
  /// In en, this message translates to:
  /// **'ICU stay'**
  String get improve_icu_stay_factor;

  /// IMPROVE ICU >48h factor name
  ///
  /// In en, this message translates to:
  /// **'ICU >48h'**
  String get improve_icu_48h_factor;

  /// IMPROVE anticoagulants factor name
  ///
  /// In en, this message translates to:
  /// **'Anticoagulants'**
  String get improve_anticoagulants_factor;

  /// IMPROVE risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'Bleeding Risk Stratification'**
  String get improve_risk_stratification;

  /// IMPROVE clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get improve_clinical_information;

  /// IMPROVE clinical information detailed text
  ///
  /// In en, this message translates to:
  /// **'IMPROVE Bleeding Risk Score assesses bleeding risk during thromboembolism prophylaxis\n\nClinical applications:\n• Decision on type of thromboembolism prophylaxis\n• Benefit/risk consideration of anticoagulants\n• Choice between pharmacological vs mechanical prophylaxis\n• Close monitoring of high-risk patients\n\nMechanical prophylaxis includes:\n• Compression stockings\n• Intermittent pneumatic compression\n• Early mobilization\n• Leg elevation\n\nImportant notes:\n• Balance bleeding risk vs thromboembolism risk\n• Reassess when condition changes\n• Combine with other clinical factors\n• Monitor for bleeding signs'**
  String get improve_clinical_info_text;

  /// IMPROVE reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get improve_reference_title;

  /// IMPROVE reference citation text
  ///
  /// In en, this message translates to:
  /// **'Hostler DC, Marx ES, Moores LK, et al. Validation of the International Medical Prevention Registry on Venous Thromboembolism bleeding risk score. Chest. 2016;149(2):372-9.'**
  String get improve_reference_text;

  /// Wells DVT Score page title
  ///
  /// In en, this message translates to:
  /// **'Wells DVT Score'**
  String get wells_dvt_title;

  /// Wells DVT Score name
  ///
  /// In en, this message translates to:
  /// **'Wells DVT Score'**
  String get wells_dvt_score;

  /// Wells DVT low risk level
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get wells_low_risk;

  /// Wells DVT moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get wells_moderate_risk;

  /// Wells DVT high risk level
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get wells_high_risk;

  /// Wells DVT probability label
  ///
  /// In en, this message translates to:
  /// **'DVT Probability'**
  String get wells_dvt_probability;

  /// Wells DVT next step label
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get wells_next_step;

  /// Wells DVT check D-dimer action
  ///
  /// In en, this message translates to:
  /// **'Check D-dimer'**
  String get wells_check_ddimer;

  /// Wells DVT D-dimer or ultrasound action
  ///
  /// In en, this message translates to:
  /// **'D-dimer or doppler ultrasound'**
  String get wells_ddimer_or_ultrasound;

  /// Wells DVT immediate ultrasound action
  ///
  /// In en, this message translates to:
  /// **'Immediate doppler ultrasound'**
  String get wells_immediate_ultrasound;

  /// Wells DVT recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get wells_recommendations;

  /// Wells DVT low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Negative D-dimer can exclude DVT. If D-dimer positive, consider doppler ultrasound'**
  String get wells_low_risk_recommendation;

  /// Wells DVT moderate risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Additional D-dimer or doppler ultrasound testing needed for confirmation'**
  String get wells_moderate_risk_recommendation;

  /// Wells DVT high risk recommendation
  ///
  /// In en, this message translates to:
  /// **'High probability of DVT, immediate doppler ultrasound required'**
  String get wells_high_risk_recommendation;

  /// Wells DVT criteria section title
  ///
  /// In en, this message translates to:
  /// **'Wells DVT Criteria'**
  String get wells_criteria_title;

  /// Wells DVT active cancer criterion
  ///
  /// In en, this message translates to:
  /// **'Active cancer (+1)'**
  String get wells_active_cancer;

  /// Wells DVT active cancer description
  ///
  /// In en, this message translates to:
  /// **'Current cancer or treatment within 6 months'**
  String get wells_active_cancer_desc;

  /// Wells DVT paralysis criterion
  ///
  /// In en, this message translates to:
  /// **'Paralysis or lower limb weakness (+1)'**
  String get wells_paralysis;

  /// Wells DVT paralysis description
  ///
  /// In en, this message translates to:
  /// **'Complete paralysis or recent lower limb weakness'**
  String get wells_paralysis_desc;

  /// Wells DVT bed rest criterion
  ///
  /// In en, this message translates to:
  /// **'Bed rest >3 days (+1)'**
  String get wells_bed_rest;

  /// Wells DVT bed rest description
  ///
  /// In en, this message translates to:
  /// **'Bed rest >3 days or major surgery within 4 weeks'**
  String get wells_bed_rest_desc;

  /// Wells DVT major surgery criterion
  ///
  /// In en, this message translates to:
  /// **'Major surgery (+1)'**
  String get wells_major_surgery;

  /// Wells DVT major surgery description
  ///
  /// In en, this message translates to:
  /// **'Major surgery within 4 weeks'**
  String get wells_major_surgery_desc;

  /// Wells DVT localized tenderness criterion
  ///
  /// In en, this message translates to:
  /// **'Localized tenderness (+1)'**
  String get wells_localized_tenderness;

  /// Wells DVT localized tenderness description
  ///
  /// In en, this message translates to:
  /// **'Localized tenderness along deep venous system'**
  String get wells_localized_tenderness_desc;

  /// Wells DVT entire leg swollen criterion
  ///
  /// In en, this message translates to:
  /// **'Entire leg swollen (+1)'**
  String get wells_entire_leg_swollen;

  /// Wells DVT entire leg swollen description
  ///
  /// In en, this message translates to:
  /// **'Entire leg swollen'**
  String get wells_entire_leg_swollen_desc;

  /// Wells DVT calf swelling criterion
  ///
  /// In en, this message translates to:
  /// **'Calf swelling (+1)'**
  String get wells_calf_swelling;

  /// Wells DVT calf swelling description
  ///
  /// In en, this message translates to:
  /// **'Calf circumference >3cm compared to opposite side'**
  String get wells_calf_swelling_desc;

  /// Wells DVT pitting edema criterion
  ///
  /// In en, this message translates to:
  /// **'Pitting edema (+1)'**
  String get wells_pitting_edema;

  /// Wells DVT pitting edema description
  ///
  /// In en, this message translates to:
  /// **'Pitting edema of affected leg'**
  String get wells_pitting_edema_desc;

  /// Wells DVT collateral veins criterion
  ///
  /// In en, this message translates to:
  /// **'Collateral veins (+1)'**
  String get wells_collateral_veins;

  /// Wells DVT collateral veins description
  ///
  /// In en, this message translates to:
  /// **'Collateral superficial veins (non-varicose)'**
  String get wells_collateral_veins_desc;

  /// Wells DVT previous DVT criterion
  ///
  /// In en, this message translates to:
  /// **'Previous DVT (+1)'**
  String get wells_previous_dvt;

  /// Wells DVT previous DVT description
  ///
  /// In en, this message translates to:
  /// **'History of deep vein thrombosis'**
  String get wells_previous_dvt_desc;

  /// Wells DVT alternative diagnosis criterion
  ///
  /// In en, this message translates to:
  /// **'Alternative diagnosis likely (-2)'**
  String get wells_alternative_diagnosis;

  /// Wells DVT alternative diagnosis description
  ///
  /// In en, this message translates to:
  /// **'Alternative diagnosis more likely than DVT'**
  String get wells_alternative_diagnosis_desc;

  /// Wells DVT current criteria title
  ///
  /// In en, this message translates to:
  /// **'Current Criteria ({count})'**
  String wells_current_criteria(int count);

  /// Wells DVT risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'DVT Risk Stratification'**
  String get wells_risk_stratification;

  /// Wells DVT clinical approach section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Approach'**
  String get wells_clinical_approach;

  /// Wells DVT approach for score label
  ///
  /// In en, this message translates to:
  /// **'Approach for score {score}:'**
  String wells_approach_for_score(int score);

  /// Wells DVT low risk clinical approach
  ///
  /// In en, this message translates to:
  /// **'If D-dimer (-): Exclude DVT\nIf D-dimer (+): Doppler ultrasound'**
  String get wells_low_risk_approach;

  /// Wells DVT moderate risk clinical approach
  ///
  /// In en, this message translates to:
  /// **'If D-dimer (-): Exclude DVT\nIf D-dimer (+): Doppler ultrasound\nOr direct doppler ultrasound'**
  String get wells_moderate_risk_approach;

  /// Wells DVT high risk clinical approach
  ///
  /// In en, this message translates to:
  /// **'Doppler ultrasound mandatory\nConsider immediate anticoagulation'**
  String get wells_high_risk_approach;

  /// Wells DVT clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get wells_clinical_information;

  /// Wells DVT clinical information detailed text
  ///
  /// In en, this message translates to:
  /// **'Wells DVT Score assesses probability of deep vein thrombosis\n\nUsage:\n• Initial clinical assessment for suspected DVT\n• Combine with D-dimer and doppler ultrasound\n• Guide diagnostic strategy\n• Avoid unnecessary testing\n\nImportant notes:\n• Low score + negative D-dimer → exclude DVT\n• High score → doppler ultrasound mandatory\n• Always consider clinical context\n• Reassess if symptoms progress\n\nAlternative diagnoses to consider:\n• Superficial thrombophlebitis\n• Heart, liver, kidney edema\n• Muscle hematoma\n• Soft tissue injury\n• Compartment syndrome\n• Arthritis'**
  String get wells_clinical_info_text;

  /// Wells DVT reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get wells_reference_title;

  /// Wells DVT reference citation text
  ///
  /// In en, this message translates to:
  /// **'Wells PS, et al. Evaluation of D-dimer in the diagnosis of suspected deep-vein thrombosis. N Engl J Med. 2003;349(13):1227-35.'**
  String get wells_reference_text;

  /// Padua Prediction Score page title
  ///
  /// In en, this message translates to:
  /// **'Padua Prediction Score'**
  String get padua_prediction_score_title;

  /// Padua score label
  ///
  /// In en, this message translates to:
  /// **'Padua Prediction Score'**
  String get padua_prediction_score;

  /// Padua low risk level
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get padua_low_risk;

  /// Padua high risk level
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get padua_high_risk;

  /// VTE risk probability label
  ///
  /// In en, this message translates to:
  /// **'VTE Risk'**
  String get padua_vte_risk;

  /// Prophylaxis strategy label
  ///
  /// In en, this message translates to:
  /// **'Prophylaxis'**
  String get padua_prophylaxis;

  /// Recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get padua_recommendations;

  /// Low risk recommendations
  ///
  /// In en, this message translates to:
  /// **'No pharmacological prophylaxis required. Mechanical measures may be used'**
  String get padua_no_prophylaxis;

  /// High risk recommendations
  ///
  /// In en, this message translates to:
  /// **'Pharmacological prophylaxis required if no contraindications'**
  String get padua_pharmacological_prophylaxis;

  /// Mechanical prophylaxis strategy
  ///
  /// In en, this message translates to:
  /// **'Mechanical prophylaxis'**
  String get padua_mechanical_prophylaxis;

  /// Combined prophylaxis strategy
  ///
  /// In en, this message translates to:
  /// **'Pharmacological + mechanical prophylaxis'**
  String get padua_pharmacological_mechanical;

  /// Padua risk factors section title
  ///
  /// In en, this message translates to:
  /// **'VTE Risk Factors'**
  String get padua_risk_factors_title;

  /// Current risk factors title
  ///
  /// In en, this message translates to:
  /// **'Current Risk Factors ({count})'**
  String padua_current_risk_factors(int count);

  /// Risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'VTE Risk Stratification'**
  String get padua_risk_stratification;

  /// Prophylaxis recommendations section title
  ///
  /// In en, this message translates to:
  /// **'VTE Prophylaxis Recommendations'**
  String get padua_prophylaxis_recommendations;

  /// Clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get padua_clinical_information;

  /// Active cancer risk factor
  ///
  /// In en, this message translates to:
  /// **'Cancer (+3)'**
  String get padua_cancer;

  /// Active cancer description
  ///
  /// In en, this message translates to:
  /// **'Active cancer (excluding skin cancer)'**
  String get padua_cancer_desc;

  /// Previous VTE risk factor
  ///
  /// In en, this message translates to:
  /// **'Previous VTE (+3)'**
  String get padua_previous_vte;

  /// Previous VTE description
  ///
  /// In en, this message translates to:
  /// **'Previous venous thromboembolism (DVT/PE)'**
  String get padua_previous_vte_desc;

  /// Reduced mobility risk factor
  ///
  /// In en, this message translates to:
  /// **'Reduced Mobility (+3)'**
  String get padua_reduced_mobility;

  /// Reduced mobility description
  ///
  /// In en, this message translates to:
  /// **'Reduced mobility (bed rest >3 days)'**
  String get padua_reduced_mobility_desc;

  /// Thrombophilia risk factor
  ///
  /// In en, this message translates to:
  /// **'Thrombophilia (+3)'**
  String get padua_thrombophilia;

  /// Thrombophilia description
  ///
  /// In en, this message translates to:
  /// **'Known thrombophilia (hereditary or acquired)'**
  String get padua_thrombophilia_desc;

  /// Recent trauma risk factor
  ///
  /// In en, this message translates to:
  /// **'Recent Trauma (+2)'**
  String get padua_recent_trauma;

  /// Recent trauma description
  ///
  /// In en, this message translates to:
  /// **'Trauma and/or surgery within 1 month'**
  String get padua_recent_trauma_desc;

  /// Elderly risk factor
  ///
  /// In en, this message translates to:
  /// **'Age ≥70 (+1)'**
  String get padua_elderly;

  /// Elderly description
  ///
  /// In en, this message translates to:
  /// **'Age ≥70 and/or heart failure and/or respiratory failure'**
  String get padua_elderly_desc;

  /// Heart failure risk factor
  ///
  /// In en, this message translates to:
  /// **'Heart Failure (+1)'**
  String get padua_heart_failure;

  /// Heart failure description
  ///
  /// In en, this message translates to:
  /// **'Acute and/or chronic heart failure'**
  String get padua_heart_failure_desc;

  /// Respiratory failure risk factor
  ///
  /// In en, this message translates to:
  /// **'Acute Respiratory Failure (+1)'**
  String get padua_respiratory_failure;

  /// Respiratory failure description
  ///
  /// In en, this message translates to:
  /// **'Acute respiratory failure'**
  String get padua_respiratory_failure_desc;

  /// Acute infection risk factor
  ///
  /// In en, this message translates to:
  /// **'Acute Infection (+1)'**
  String get padua_acute_infection;

  /// Acute infection description
  ///
  /// In en, this message translates to:
  /// **'Acute infection and/or rheumatic disease'**
  String get padua_acute_infection_desc;

  /// Rheumatic disease risk factor
  ///
  /// In en, this message translates to:
  /// **'Rheumatic Disease (+1)'**
  String get padua_rheumatic_disease;

  /// Rheumatic disease description
  ///
  /// In en, this message translates to:
  /// **'Active rheumatic disease'**
  String get padua_rheumatic_disease_desc;

  /// IBD or stroke risk factor
  ///
  /// In en, this message translates to:
  /// **'IBD/Stroke (+1)'**
  String get padua_ibd_stroke;

  /// IBD or stroke description
  ///
  /// In en, this message translates to:
  /// **'Inflammatory bowel disease or acute stroke'**
  String get padua_ibd_stroke_desc;

  /// Acute MI risk factor
  ///
  /// In en, this message translates to:
  /// **'Acute MI (+1)'**
  String get padua_acute_mi;

  /// Acute MI description
  ///
  /// In en, this message translates to:
  /// **'Acute myocardial infarction'**
  String get padua_acute_mi_desc;

  /// Mechanical prophylaxis section title
  ///
  /// In en, this message translates to:
  /// **'Mechanical Prophylaxis'**
  String get padua_mechanical_prophylaxis_title;

  /// Pharmacological prophylaxis section title
  ///
  /// In en, this message translates to:
  /// **'Pharmacological Prophylaxis'**
  String get padua_pharmacological_prophylaxis_title;

  /// Graduated compression stockings
  ///
  /// In en, this message translates to:
  /// **'Graduated compression stockings'**
  String get padua_graduated_compression;

  /// Intermittent pneumatic compression
  ///
  /// In en, this message translates to:
  /// **'Intermittent pneumatic compression'**
  String get padua_intermittent_compression;

  /// Early mobilization
  ///
  /// In en, this message translates to:
  /// **'Early mobilization'**
  String get padua_early_mobilization;

  /// Leg elevation during rest
  ///
  /// In en, this message translates to:
  /// **'Leg elevation during rest'**
  String get padua_leg_elevation;

  /// LMWH prophylaxis
  ///
  /// In en, this message translates to:
  /// **'LMWH (Enoxaparin 40mg/day)'**
  String get padua_lmwh;

  /// UFH prophylaxis
  ///
  /// In en, this message translates to:
  /// **'UFH (5000IU x2/day)'**
  String get padua_ufh;

  /// Fondaparinux prophylaxis
  ///
  /// In en, this message translates to:
  /// **'Fondaparinux 2.5mg/day'**
  String get padua_fondaparinux;

  /// DOAC prophylaxis
  ///
  /// In en, this message translates to:
  /// **'DOAC (as indicated)'**
  String get padua_doac;

  /// Padua clinical information text
  ///
  /// In en, this message translates to:
  /// **'Padua Prediction Score assesses VTE risk in medical patients\n\nClinical applications:\n• VTE prophylaxis decision in medical patients\n• Risk-benefit assessment for anticoagulation\n• Selection of prophylaxis method\n• Cost optimization of treatment\n\nContraindications to pharmacological prophylaxis:\n• Active major bleeding or high bleeding risk\n• Recent brain/eye/spinal surgery\n• Severe ischemic heart disease\n• Severe uncontrolled hypertension\n• Severe liver disease\n• Severe renal impairment (CrCl <15ml/min)\n\nMonitoring during prophylaxis:\n• Signs of bleeding\n• Platelet count\n• Renal function (if using LMWH)\n• New VTE symptoms\n• Reassess when condition changes'**
  String get padua_clinical_info_text;

  /// Padua reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get padua_reference_title;

  /// Padua reference citation text
  ///
  /// In en, this message translates to:
  /// **'Barbar S, et al. A risk assessment model for the identification of hospitalized medical patients at risk for venous thromboembolism: the Padua Prediction Score. J Thromb Haemost. 2010;8(11):2450-7.\n\nKahn SR, et al. Prevention of VTE in nonsurgical patients: Antithrombotic Therapy and Prevention of Thrombosis, 9th ed: American College of Chest Physicians Evidence-Based Clinical Practice Guidelines. Chest. 2012;141(2 Suppl):e195S-e226S.'**
  String get padua_reference_text;

  /// ABCD2 Score page title
  ///
  /// In en, this message translates to:
  /// **'ABCD2 Score'**
  String get abcd2_score_title;

  /// ABCD2 Score label
  ///
  /// In en, this message translates to:
  /// **'ABCD2 Score'**
  String get abcd2_score;

  /// ABCD2 low risk level
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get abcd2_low_risk;

  /// ABCD2 moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get abcd2_moderate_risk;

  /// ABCD2 high risk level
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get abcd2_high_risk;

  /// 2-day stroke risk label
  ///
  /// In en, this message translates to:
  /// **'2-day stroke risk'**
  String get abcd2_stroke_2_days;

  /// 7-day stroke risk label
  ///
  /// In en, this message translates to:
  /// **'7-day stroke risk'**
  String get abcd2_stroke_7_days;

  /// 90-day stroke risk label
  ///
  /// In en, this message translates to:
  /// **'90-day stroke risk'**
  String get abcd2_stroke_90_days;

  /// Urgency level label
  ///
  /// In en, this message translates to:
  /// **'Urgency Level:'**
  String get abcd2_urgency_level;

  /// Recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get abcd2_recommendations;

  /// Non-urgent urgency level
  ///
  /// In en, this message translates to:
  /// **'Non-urgent - 48-72h'**
  String get abcd2_urgency_non_urgent;

  /// Priority urgency level
  ///
  /// In en, this message translates to:
  /// **'Priority - within 24h'**
  String get abcd2_urgency_priority;

  /// Emergency urgency level
  ///
  /// In en, this message translates to:
  /// **'Emergency - immediate'**
  String get abcd2_urgency_emergency;

  /// Low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'May discharge with close outpatient follow-up, consider investigation of cause'**
  String get abcd2_recommendation_low;

  /// Moderate risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Requires short-term hospital observation, investigation of cause and preventive treatment'**
  String get abcd2_recommendation_moderate;

  /// High risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Emergency admission, comprehensive investigation and aggressive preventive treatment'**
  String get abcd2_recommendation_high;

  /// Basic information section title
  ///
  /// In en, this message translates to:
  /// **'Basic Information (A)'**
  String get abcd2_basic_info;

  /// Age input label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get abcd2_age;

  /// Age unit
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get abcd2_age_unit;

  /// Age scoring help text
  ///
  /// In en, this message translates to:
  /// **'+1 point if ≥60 years'**
  String get abcd2_age_help;

  /// Blood pressure input label
  ///
  /// In en, this message translates to:
  /// **'Systolic Blood Pressure'**
  String get abcd2_blood_pressure;

  /// Blood pressure unit
  ///
  /// In en, this message translates to:
  /// **'mmHg'**
  String get abcd2_bp_unit;

  /// Blood pressure scoring help text
  ///
  /// In en, this message translates to:
  /// **'+1 point if ≥140mmHg'**
  String get abcd2_bp_help;

  /// Clinical features section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Features (C)'**
  String get abcd2_clinical_features;

  /// Other symptoms option
  ///
  /// In en, this message translates to:
  /// **'Other symptoms'**
  String get abcd2_other_symptoms;

  /// Other symptoms description
  ///
  /// In en, this message translates to:
  /// **'No speech disorder or hemiplegia'**
  String get abcd2_other_symptoms_desc;

  /// Speech disorder without paralysis option
  ///
  /// In en, this message translates to:
  /// **'Speech disorder without paralysis'**
  String get abcd2_speech_without_weakness;

  /// Speech disorder without paralysis description
  ///
  /// In en, this message translates to:
  /// **'Difficulty speaking, aphasia but no motor paralysis'**
  String get abcd2_speech_without_weakness_desc;

  /// Unilateral weakness option
  ///
  /// In en, this message translates to:
  /// **'Unilateral weakness'**
  String get abcd2_unilateral_weakness;

  /// Unilateral weakness description
  ///
  /// In en, this message translates to:
  /// **'Weakness or paralysis on one side of body'**
  String get abcd2_unilateral_weakness_desc;

  /// Duration section title
  ///
  /// In en, this message translates to:
  /// **'Duration (D)'**
  String get abcd2_duration;

  /// Duration less than 10 minutes option
  ///
  /// In en, this message translates to:
  /// **'< 10 minutes'**
  String get abcd2_duration_less_10;

  /// Duration less than 10 minutes description
  ///
  /// In en, this message translates to:
  /// **'Symptoms lasted less than 10 minutes'**
  String get abcd2_duration_less_10_desc;

  /// Duration 10-59 minutes option
  ///
  /// In en, this message translates to:
  /// **'10-59 minutes'**
  String get abcd2_duration_10_59;

  /// Duration 10-59 minutes description
  ///
  /// In en, this message translates to:
  /// **'Symptoms lasted 10 to 59 minutes'**
  String get abcd2_duration_10_59_desc;

  /// Duration 60+ minutes option
  ///
  /// In en, this message translates to:
  /// **'≥ 60 minutes'**
  String get abcd2_duration_60_plus;

  /// Duration 60+ minutes description
  ///
  /// In en, this message translates to:
  /// **'Symptoms lasted 60 minutes or longer'**
  String get abcd2_duration_60_plus_desc;

  /// Diabetes section title
  ///
  /// In en, this message translates to:
  /// **'Diabetes (D)'**
  String get abcd2_diabetes;

  /// Has diabetes checkbox label
  ///
  /// In en, this message translates to:
  /// **'Has history of diabetes'**
  String get abcd2_has_diabetes;

  /// Diabetes description
  ///
  /// In en, this message translates to:
  /// **'Currently treated or previously diagnosed'**
  String get abcd2_diabetes_desc;

  /// Risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'Stroke Risk Stratification'**
  String get abcd2_risk_stratification;

  /// Low risk score range
  ///
  /// In en, this message translates to:
  /// **'0-3'**
  String get abcd2_risk_range_low;

  /// Moderate risk score range
  ///
  /// In en, this message translates to:
  /// **'4-5'**
  String get abcd2_risk_range_moderate;

  /// High risk score range
  ///
  /// In en, this message translates to:
  /// **'6-7'**
  String get abcd2_risk_range_high;

  /// 2-day risk for low score
  ///
  /// In en, this message translates to:
  /// **'0-3.1%'**
  String get abcd2_risk_2d_low;

  /// 90-day risk for low score
  ///
  /// In en, this message translates to:
  /// **'1.2-9.8%'**
  String get abcd2_risk_90d_low;

  /// 2-day risk for moderate score
  ///
  /// In en, this message translates to:
  /// **'4.1-5.9%'**
  String get abcd2_risk_2d_moderate;

  /// 90-day risk for moderate score
  ///
  /// In en, this message translates to:
  /// **'11.7-19.6%'**
  String get abcd2_risk_90d_moderate;

  /// 2-day risk for high score
  ///
  /// In en, this message translates to:
  /// **'9.8-11.7%'**
  String get abcd2_risk_2d_high;

  /// 90-day risk for high score
  ///
  /// In en, this message translates to:
  /// **'31.4-35.5%'**
  String get abcd2_risk_90d_high;

  /// Risk display format
  ///
  /// In en, this message translates to:
  /// **'2 days: {risk2d}, 90 days: {risk90d}'**
  String abcd2_risk_display_format(String risk2d, String risk90d);

  /// Clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get abcd2_clinical_information;

  /// ABCD2 clinical information text
  ///
  /// In en, this message translates to:
  /// **'ABCD2 Score predicts stroke risk after transient ischemic attack (TIA)\n\nComponents of ABCD2:\n• A (Age): Age ≥60 (+1 point)\n• B (Blood pressure): BP ≥140/90 (+1 point)\n• C (Clinical features): Clinical symptoms (0-2 points)\n• D (Duration): Duration of symptoms (0-2 points)\n• D (Diabetes): Diabetes (+1 point)\n\nClinical applications:\n• Decision for hospital admission after TIA\n• Priority level for investigation\n• Risk counseling for patients\n• Follow-up and preventive treatment\n\nNote: Combine with imaging assessment and etiology to make optimal treatment decisions'**
  String get abcd2_clinical_info_text;

  /// ABCD2 reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get abcd2_reference_title;

  /// ABCD2 reference citation text
  ///
  /// In en, this message translates to:
  /// **'Johnston SC, et al. Validation and refinement of scores to predict very early stroke risk after transient ischaemic attack. Lancet. 2007;369(9558):283-92.'**
  String get abcd2_reference_text;

  /// RACE Scale page title
  ///
  /// In en, this message translates to:
  /// **'RACE Scale'**
  String get race_scale_title;

  /// RACE Scale label
  ///
  /// In en, this message translates to:
  /// **'RACE Scale'**
  String get race_scale;

  /// LVO likelihood label
  ///
  /// In en, this message translates to:
  /// **'LVO likelihood: {likelihood}'**
  String race_lvo_likelihood(String likelihood);

  /// Low LVO likelihood
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get race_low_lvo;

  /// High LVO likelihood
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get race_high_lvo;

  /// LVO probability label
  ///
  /// In en, this message translates to:
  /// **'LVO Probability'**
  String get race_lvo_probability;

  /// Time target label
  ///
  /// In en, this message translates to:
  /// **'Time Target'**
  String get race_time_target;

  /// Standard time target
  ///
  /// In en, this message translates to:
  /// **'Standard time'**
  String get race_standard_time;

  /// Door-to-groin time target
  ///
  /// In en, this message translates to:
  /// **'Door-to-groin < 90 min'**
  String get race_door_to_groin;

  /// Recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get race_recommendations;

  /// Low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Continue routine stroke evaluation, consider other causes'**
  String get race_recommendation_low;

  /// High risk recommendation
  ///
  /// In en, this message translates to:
  /// **'High LVO probability - Immediate transfer to EVT (endovascular therapy) center required'**
  String get race_recommendation_high;

  /// RACE assessment section title
  ///
  /// In en, this message translates to:
  /// **'RACE Scale Assessment'**
  String get race_assessment_title;

  /// RACE assessment subtitle
  ///
  /// In en, this message translates to:
  /// **'Rapid Arterial oCclusion Evaluation'**
  String get race_assessment_subtitle;

  /// Facial palsy assessment
  ///
  /// In en, this message translates to:
  /// **'Facial Palsy'**
  String get race_facial_palsy;

  /// Facial palsy instruction
  ///
  /// In en, this message translates to:
  /// **'Ask patient to smile or show teeth'**
  String get race_facial_palsy_instruction;

  /// No facial palsy
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get race_facial_palsy_none;

  /// Mild facial palsy
  ///
  /// In en, this message translates to:
  /// **'Mild facial palsy'**
  String get race_facial_palsy_mild;

  /// Severe facial palsy
  ///
  /// In en, this message translates to:
  /// **'Severe facial palsy'**
  String get race_facial_palsy_severe;

  /// Arm motor assessment
  ///
  /// In en, this message translates to:
  /// **'Arm Motor'**
  String get race_arm_motor;

  /// Arm motor instruction
  ///
  /// In en, this message translates to:
  /// **'Raise arm to 90° for 10 seconds'**
  String get race_arm_motor_instruction;

  /// Normal motor function
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get race_motor_normal;

  /// Mild motor drift
  ///
  /// In en, this message translates to:
  /// **'Mild drift'**
  String get race_motor_mild_drift;

  /// Severe motor deficit
  ///
  /// In en, this message translates to:
  /// **'Rapid fall or cannot raise'**
  String get race_motor_severe;

  /// Leg motor assessment
  ///
  /// In en, this message translates to:
  /// **'Leg Motor'**
  String get race_leg_motor;

  /// Leg motor instruction
  ///
  /// In en, this message translates to:
  /// **'Raise leg to 30° for 5 seconds'**
  String get race_leg_motor_instruction;

  /// Head and eye deviation assessment
  ///
  /// In en, this message translates to:
  /// **'Head and Eye Deviation'**
  String get race_head_eye_deviation;

  /// Head and eye deviation instruction
  ///
  /// In en, this message translates to:
  /// **'Observe gaze direction and head turn'**
  String get race_head_eye_instruction;

  /// No deviation
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get race_deviation_none;

  /// Deviation present
  ///
  /// In en, this message translates to:
  /// **'Deviation present'**
  String get race_deviation_present;

  /// Hemianeglect assessment
  ///
  /// In en, this message translates to:
  /// **'Hemianeglect'**
  String get race_hemianeglect;

  /// Hemianeglect instruction
  ///
  /// In en, this message translates to:
  /// **'Assess attention to left-sided space'**
  String get race_hemianeglect_instruction;

  /// Normal attention
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get race_hemianeglect_normal;

  /// Hemianeglect present
  ///
  /// In en, this message translates to:
  /// **'Unilateral neglect present'**
  String get race_hemianeglect_present;

  /// Aphasia assessment
  ///
  /// In en, this message translates to:
  /// **'Aphasia'**
  String get race_aphasia;

  /// Aphasia instruction
  ///
  /// In en, this message translates to:
  /// **'Assess speech and comprehension ability'**
  String get race_aphasia_instruction;

  /// Normal speech
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get race_aphasia_normal;

  /// Mild aphasia
  ///
  /// In en, this message translates to:
  /// **'Mild aphasia'**
  String get race_aphasia_mild;

  /// Severe aphasia
  ///
  /// In en, this message translates to:
  /// **'Severe aphasia'**
  String get race_aphasia_severe;

  /// LVO risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'LVO Risk Stratification'**
  String get race_risk_stratification;

  /// Low risk score range
  ///
  /// In en, this message translates to:
  /// **'0-4'**
  String get race_risk_low_range;

  /// High risk score range
  ///
  /// In en, this message translates to:
  /// **'≥5'**
  String get race_risk_high_range;

  /// Low risk probability
  ///
  /// In en, this message translates to:
  /// **'< 10%'**
  String get race_risk_low_probability;

  /// High risk probability
  ///
  /// In en, this message translates to:
  /// **'≥ 85%'**
  String get race_risk_high_probability;

  /// Routine stroke action
  ///
  /// In en, this message translates to:
  /// **'Routine stroke care'**
  String get race_action_routine;

  /// EVT center transfer action
  ///
  /// In en, this message translates to:
  /// **'Transfer to EVT center'**
  String get race_action_evt;

  /// Emergency protocol section title
  ///
  /// In en, this message translates to:
  /// **'Emergency LVO Protocol'**
  String get race_emergency_protocol;

  /// Stroke code activation step
  ///
  /// In en, this message translates to:
  /// **'1. Activate stroke code'**
  String get race_protocol_stroke_code;

  /// Stroke code description
  ///
  /// In en, this message translates to:
  /// **'Notify stroke team immediately'**
  String get race_protocol_stroke_code_desc;

  /// CT/CTA step
  ///
  /// In en, this message translates to:
  /// **'2. Emergency CT/CTA'**
  String get race_protocol_ct_cta;

  /// CT/CTA description
  ///
  /// In en, this message translates to:
  /// **'CT and CTA within 20 minutes'**
  String get race_protocol_ct_cta_desc;

  /// Transfer step
  ///
  /// In en, this message translates to:
  /// **'3. Transfer to EVT center'**
  String get race_protocol_transfer;

  /// Transfer description
  ///
  /// In en, this message translates to:
  /// **'Contact cerebrovascular intervention center'**
  String get race_protocol_transfer_desc;

  /// tPA step
  ///
  /// In en, this message translates to:
  /// **'4. IV tPA (if eligible)'**
  String get race_protocol_tpa;

  /// tPA description
  ///
  /// In en, this message translates to:
  /// **'Intravenous thrombolysis before transfer'**
  String get race_protocol_tpa_desc;

  /// Time target step
  ///
  /// In en, this message translates to:
  /// **'5. Door-to-groin <90 min'**
  String get race_protocol_time;

  /// Time target description
  ///
  /// In en, this message translates to:
  /// **'Target from hospital arrival to EVT'**
  String get race_protocol_time_desc;

  /// Clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get race_clinical_information;

  /// RACE clinical information text
  ///
  /// In en, this message translates to:
  /// **'RACE Scale rapidly identifies Large Vessel Occlusion (LVO) stroke\n\nPurpose:\n• Screen patients requiring EVT (endovascular therapy)\n• Optimize \'time is brain\' management\n• Guide transfer decisions\n• Improve treatment outcomes\n\nWhat is LVO:\n• Large cerebral vessel occlusion (ICA, M1, M2, basilar)\n• Accounts for 24-46% of acute ischemic strokes\n• Poor prognosis without intervention\n• Good response to EVT within 24 hours\n\nRACE advantages:\n• Simple and rapid\n• 85% sensitivity, 68% specificity\n• Can be performed pre-hospital\n• Effective triage tool\n\nHow to perform:\n• Assess 6 components\n• Total score 0-9\n• ≥5 points: high LVO probability\n• Combine with NIHSS assessment\n\nImportant notes:\n• Does not replace full neurologic evaluation\n• Imaging confirmation of LVO required\n• Time window crucial for EVT\n• Combine with IV tPA if appropriate'**
  String get race_clinical_info_text;

  /// RACE reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get race_reference_title;

  /// RACE reference citation text
  ///
  /// In en, this message translates to:
  /// **'Pérez de la Ossa N, et al. Design and validation of a prehospital stroke scale to predict large arterial occlusion: the rapid arterial occlusion evaluation (RACE) scale. Stroke. 2014;45(1):87-91.\n\nCarrera D, et al. Validation of computer-assisted RACE scale for prehospital use. Stroke. 2018;49(5):1255-7.'**
  String get race_reference_text;

  /// ASPECT Score page title
  ///
  /// In en, this message translates to:
  /// **'ASPECT Score'**
  String get aspect_score_title;

  /// ASPECT Score label
  ///
  /// In en, this message translates to:
  /// **'ASPECT Score'**
  String get aspect_score;

  /// Good prognosis
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get aspect_prognosis_good;

  /// Moderate prognosis
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get aspect_prognosis_moderate;

  /// Poor prognosis
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get aspect_prognosis_poor;

  /// Prognosis prefix
  ///
  /// In en, this message translates to:
  /// **'Prognosis: {prognosis}'**
  String aspect_prognosis_prefix(String prognosis);

  /// Prognosis label
  ///
  /// In en, this message translates to:
  /// **'Prognosis:'**
  String get aspect_prognosis_label;

  /// Recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get aspect_recommendations;

  /// Good prognosis text
  ///
  /// In en, this message translates to:
  /// **'Good prognosis for EVT'**
  String get aspect_prognosis_good_text;

  /// Moderate prognosis text
  ///
  /// In en, this message translates to:
  /// **'Consider EVT carefully'**
  String get aspect_prognosis_moderate_text;

  /// Poor prognosis text
  ///
  /// In en, this message translates to:
  /// **'High risk of complications'**
  String get aspect_prognosis_poor_text;

  /// Good prognosis recommendation
  ///
  /// In en, this message translates to:
  /// **'Proceed with EVT within appropriate time window'**
  String get aspect_recommendation_good;

  /// Moderate prognosis recommendation
  ///
  /// In en, this message translates to:
  /// **'Consider EVT, assess benefit/risk ratio'**
  String get aspect_recommendation_moderate;

  /// Poor prognosis recommendation
  ///
  /// In en, this message translates to:
  /// **'Caution with EVT, prioritize medical management'**
  String get aspect_recommendation_poor;

  /// Brain regions section title
  ///
  /// In en, this message translates to:
  /// **'MCA (Middle Cerebral Artery) Regions'**
  String get aspect_brain_regions;

  /// Cortical regions category
  ///
  /// In en, this message translates to:
  /// **'Cortical Regions'**
  String get aspect_cortical_regions;

  /// Subcortical regions category
  ///
  /// In en, this message translates to:
  /// **'Subcortical Regions'**
  String get aspect_subcortical_regions;

  /// M1 brain region
  ///
  /// In en, this message translates to:
  /// **'M1: Frontal operculum, motor cortex'**
  String get aspect_m1_region;

  /// M2 brain region
  ///
  /// In en, this message translates to:
  /// **'M2: Temporal pole, anterior temporal cortex'**
  String get aspect_m2_region;

  /// M3 brain region
  ///
  /// In en, this message translates to:
  /// **'M3: Posterior temporal cortex'**
  String get aspect_m3_region;

  /// M4 brain region
  ///
  /// In en, this message translates to:
  /// **'M4: Anterior parietal cortex'**
  String get aspect_m4_region;

  /// M5 brain region
  ///
  /// In en, this message translates to:
  /// **'M5: Posterior parietal cortex'**
  String get aspect_m5_region;

  /// M6 brain region
  ///
  /// In en, this message translates to:
  /// **'M6: Angular gyrus, posterior superior temporal'**
  String get aspect_m6_region;

  /// Internal capsule region
  ///
  /// In en, this message translates to:
  /// **'IC: Internal capsule'**
  String get aspect_ic_region;

  /// Lentiform nucleus region
  ///
  /// In en, this message translates to:
  /// **'L: Lentiform nucleus'**
  String get aspect_l_region;

  /// Caudate nucleus region
  ///
  /// In en, this message translates to:
  /// **'C: Caudate nucleus'**
  String get aspect_c_region;

  /// Insular cortex region
  ///
  /// In en, this message translates to:
  /// **'I: Insular cortex'**
  String get aspect_i_region;

  /// Abnormal lesion description
  ///
  /// In en, this message translates to:
  /// **'Abnormal lesion (subtract 1 point)'**
  String get aspect_abnormal_lesion;

  /// Score interpretation section title
  ///
  /// In en, this message translates to:
  /// **'ASPECT Score Interpretation'**
  String get aspect_score_interpretation;

  /// Score range 8-10
  ///
  /// In en, this message translates to:
  /// **'8-10'**
  String get aspect_score_8_10;

  /// Score range 6-7
  ///
  /// In en, this message translates to:
  /// **'6-7'**
  String get aspect_score_6_7;

  /// Score range 0-5
  ///
  /// In en, this message translates to:
  /// **'0-5'**
  String get aspect_score_0_5;

  /// Good EVT prognosis
  ///
  /// In en, this message translates to:
  /// **'Good prognosis for EVT'**
  String get aspect_good_prognosis_evt;

  /// Consider EVT text
  ///
  /// In en, this message translates to:
  /// **'Consider EVT'**
  String get aspect_consider_evt;

  /// High risk text
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get aspect_high_risk;

  /// Perform EVT action
  ///
  /// In en, this message translates to:
  /// **'Perform EVT as indicated'**
  String get aspect_perform_evt;

  /// Assess benefit/risk action
  ///
  /// In en, this message translates to:
  /// **'Assess benefit/risk ratio'**
  String get aspect_assess_benefit_risk;

  /// Caution with EVT action
  ///
  /// In en, this message translates to:
  /// **'Caution with EVT'**
  String get aspect_caution_evt;

  /// Clinical guidelines section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Guidelines'**
  String get aspect_clinical_guidelines;

  /// EVT recommended guideline
  ///
  /// In en, this message translates to:
  /// **'ASPECT ≥8: EVT recommended'**
  String get aspect_evt_recommended;

  /// Consider EVT guideline
  ///
  /// In en, this message translates to:
  /// **'ASPECT 6-7: Consider EVT'**
  String get aspect_evt_consider;

  /// EVT caution guideline
  ///
  /// In en, this message translates to:
  /// **'ASPECT <6: Caution'**
  String get aspect_evt_caution;

  /// Good prognosis EVT description
  ///
  /// In en, this message translates to:
  /// **'Good prognosis for EVT'**
  String get aspect_good_prognosis_evt_desc;

  /// Perform within time window
  ///
  /// In en, this message translates to:
  /// **'Perform within time window'**
  String get aspect_perform_time_window;

  /// Low hemorrhage risk
  ///
  /// In en, this message translates to:
  /// **'Low risk of hemorrhagic complications'**
  String get aspect_low_hemorrhage_risk;

  /// Good functional outcome
  ///
  /// In en, this message translates to:
  /// **'Good functional outcome'**
  String get aspect_good_functional_outcome;

  /// Assess case by case
  ///
  /// In en, this message translates to:
  /// **'Assess case by case'**
  String get aspect_assess_case_by_case;

  /// Consider age and time
  ///
  /// In en, this message translates to:
  /// **'Consider age and time'**
  String get aspect_consider_age_time;

  /// Discuss with family
  ///
  /// In en, this message translates to:
  /// **'Discuss with family'**
  String get aspect_discuss_family;

  /// Close monitoring
  ///
  /// In en, this message translates to:
  /// **'Close monitoring'**
  String get aspect_close_monitoring;

  /// High complication risk
  ///
  /// In en, this message translates to:
  /// **'High risk of complications'**
  String get aspect_high_complication_risk;

  /// Prioritize medical management
  ///
  /// In en, this message translates to:
  /// **'Prioritize medical management'**
  String get aspect_prioritize_medical;

  /// Special consideration for EVT
  ///
  /// In en, this message translates to:
  /// **'Special consideration for EVT'**
  String get aspect_special_consideration;

  /// Supportive care
  ///
  /// In en, this message translates to:
  /// **'Intensive supportive care'**
  String get aspect_supportive_care;

  /// Clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get aspect_clinical_information;

  /// CURB-65 score page title
  ///
  /// In en, this message translates to:
  /// **'CURB-65 Score'**
  String get curb65_title;

  /// CURB-65 score label
  ///
  /// In en, this message translates to:
  /// **'CURB-65 Score'**
  String get curb65_score;

  /// CURB-65 very low risk level
  ///
  /// In en, this message translates to:
  /// **'Very low risk'**
  String get curb65_very_low_risk;

  /// CURB-65 low risk level
  ///
  /// In en, this message translates to:
  /// **'Low risk'**
  String get curb65_low_risk;

  /// CURB-65 moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate risk'**
  String get curb65_moderate_risk;

  /// CURB-65 high risk level
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get curb65_high_risk;

  /// CURB-65 very high risk level
  ///
  /// In en, this message translates to:
  /// **'Very high risk'**
  String get curb65_very_high_risk;

  /// CURB-65 mortality rate display
  ///
  /// In en, this message translates to:
  /// **'Mortality rate: {rate}'**
  String curb65_mortality_rate(String rate);

  /// CURB-65 outpatient treatment recommendation
  ///
  /// In en, this message translates to:
  /// **'Can be treated as outpatient'**
  String get curb65_outpatient_treatment;

  /// CURB-65 consider hospitalization recommendation
  ///
  /// In en, this message translates to:
  /// **'Consider inpatient treatment or observation'**
  String get curb65_consider_hospital;

  /// CURB-65 hospital/ICU recommendation
  ///
  /// In en, this message translates to:
  /// **'Inpatient treatment required, consider ICU if score ≥4'**
  String get curb65_hospital_icu;

  /// CURB-65 confusion criterion
  ///
  /// In en, this message translates to:
  /// **'Confusion'**
  String get curb65_confusion;

  /// CURB-65 confusion subtitle
  ///
  /// In en, this message translates to:
  /// **'(Mental confusion)'**
  String get curb65_confusion_subtitle;

  /// No mental confusion option
  ///
  /// In en, this message translates to:
  /// **'No mental confusion'**
  String get curb65_no_confusion;

  /// No confusion description
  ///
  /// In en, this message translates to:
  /// **'Good orientation to time, place, person'**
  String get curb65_no_confusion_desc;

  /// Has mental confusion option
  ///
  /// In en, this message translates to:
  /// **'Has mental confusion'**
  String get curb65_has_confusion;

  /// Has confusion description
  ///
  /// In en, this message translates to:
  /// **'Disoriented to time, place or person'**
  String get curb65_has_confusion_desc;

  /// BUN (Blood Urea Nitrogen) label
  ///
  /// In en, this message translates to:
  /// **'BUN'**
  String get curb65_bun;

  /// BUN input label with unit
  ///
  /// In en, this message translates to:
  /// **'BUN ({unit})'**
  String curb65_bun_label(String unit);

  /// BUN unit selector label
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get curb65_bun_unit;

  /// BUN scoring criteria
  ///
  /// In en, this message translates to:
  /// **'Score: 1 if BUN > 19 mg/dL (6.8 mmol/L)'**
  String get curb65_bun_scoring;

  /// Respiratory rate input label
  ///
  /// In en, this message translates to:
  /// **'Respiratory Rate (breaths/min)'**
  String get curb65_respiratory_rate;

  /// Systolic blood pressure input label
  ///
  /// In en, this message translates to:
  /// **'Systolic Blood Pressure (mmHg)'**
  String get curb65_systolic_bp;

  /// Age input label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get curb65_age;

  /// Input field placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter value'**
  String get curb65_enter_value;

  /// Score display format
  ///
  /// In en, this message translates to:
  /// **'Score: {score}'**
  String curb65_score_label(int score);

  /// CURB-65 reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get curb65_reference_title;

  /// CURB-65 reference citation
  ///
  /// In en, this message translates to:
  /// **'Lim WS, et al. Defining community acquired pneumonia severity on presentation to hospital: an international derivation and validation study. Thorax. 2003;58(5):377-82.'**
  String get curb65_reference_text;

  /// CURB-65 very low mortality risk
  ///
  /// In en, this message translates to:
  /// **'< 1%'**
  String get curb65_mortality_very_low;

  /// CURB-65 low mortality risk
  ///
  /// In en, this message translates to:
  /// **'1-3%'**
  String get curb65_mortality_low;

  /// CURB-65 moderate mortality risk
  ///
  /// In en, this message translates to:
  /// **'9-15%'**
  String get curb65_mortality_moderate;

  /// CURB-65 high mortality risk
  ///
  /// In en, this message translates to:
  /// **'15-40%'**
  String get curb65_mortality_high;

  /// CURB-65 very high mortality risk
  ///
  /// In en, this message translates to:
  /// **'> 40%'**
  String get curb65_mortality_very_high;

  /// CURB-65 clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get curb65_clinical_information;

  /// CURB-65 clinical information detailed text
  ///
  /// In en, this message translates to:
  /// **'CURB-65 Score assesses severity of community-acquired pneumonia\n\nCURB-65 criteria:\n• C (Confusion): Mental confusion or disorientation\n• U (Urea): Blood urea nitrogen >19 mg/dL (6.8 mmol/L)\n• R (Respiratory rate): ≥30 breaths per minute\n• B (Blood pressure): Systolic BP <90 mmHg\n• 65 (Age): Age ≥65 years\n\nClinical applications:\n• Treatment location decision (outpatient vs inpatient)\n• ICU admission consideration\n• Risk stratification for pneumonia patients\n• Prognosis assessment\n\nScore interpretation:\n• 0-1: Low risk, outpatient treatment possible\n• 2: Moderate risk, consider hospitalization\n• 3-5: High risk, hospitalization required\n• ≥4: Consider ICU admission\n\nImportant notes:\n• Must combine with clinical assessment\n• Consider comorbidities and social factors\n• Reevaluate if patient condition changes\n• Validated for community-acquired pneumonia'**
  String get curb65_clinical_info_content;

  /// CURB-65 risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'CURB-65 Risk Stratification'**
  String get curb65_risk_stratification;

  /// CURB-65 recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get curb65_recommendations;

  /// CURB-65 treatment setting section title
  ///
  /// In en, this message translates to:
  /// **'Treatment Setting'**
  String get curb65_treatment_setting;

  /// Outpatient treatment option
  ///
  /// In en, this message translates to:
  /// **'Outpatient'**
  String get curb65_outpatient;

  /// Hospital observation option
  ///
  /// In en, this message translates to:
  /// **'Hospital/Observation'**
  String get curb65_hospital_observation;

  /// Hospital/ICU admission option
  ///
  /// In en, this message translates to:
  /// **'Hospital/ICU'**
  String get curb65_hospital_icu_admission;

  /// CURB-65 assessment parameters section title
  ///
  /// In en, this message translates to:
  /// **'Assessment Parameters'**
  String get curb65_assessment_parameters;

  /// CURB-65 scoring criteria section title
  ///
  /// In en, this message translates to:
  /// **'Scoring Criteria'**
  String get curb65_scoring_criteria;

  /// ASPECT clinical information text
  ///
  /// In en, this message translates to:
  /// **'ASPECT Score assesses acute ischemic stroke severity\n\nPurpose:\n• Predict EVT outcomes\n• Select appropriate patients\n• Assess complication risk\n• Support clinical decisions\n\nAssessment method:\n• Non-contrast CT scan\n• Evaluated at 2 slice levels\n• Basal ganglia level slice\n• Suprathalamic level slice\n\nIschemic signs:\n• Loss of gray-white matter differentiation\n• Decreased cortical density\n• Focal brain edema\n• Mass effect\n\n10 assessed regions:\n• M1-M6: MCA cortical regions\n• IC: Internal capsule\n• L: Lentiform nucleus\n• C: Caudate nucleus\n• I: Insular cortex\n\nAdvantages:\n• Simple and easy to perform\n• Good reproducibility\n• Accurate prediction\n• Widely applicable\n\nLimitations:\n• Experience dependent\n• Inter-reader variability\n• Difficult to detect mild lesions\n• Does not assess perfusion\n\nRecommendations:\n• Combine with clinical information\n• Consider perfusion imaging\n• Comprehensive assessment\n• Post-treatment monitoring'**
  String get aspect_clinical_info_text;

  /// ASPECT reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get aspect_reference_title;

  /// ASPECT reference citation text
  ///
  /// In en, this message translates to:
  /// **'Barber PA, et al. Validity and reliability of a quantitative computed tomography score in predicting outcome of hyperacute stroke before thrombolytic therapy. Lancet. 2000;355(9216):1670-4.\n\nPexman JH, et al. Use of the Alberta Stroke Program Early CT Score (ASPECTS) for assessing CT scans in patients with acute stroke. AJNR Am J Neuroradiol. 2001;22(8):1534-42.'**
  String get aspect_reference_text;

  /// High ASPECT score guideline title
  ///
  /// In en, this message translates to:
  /// **'ASPECT ≥8: EVT Recommended'**
  String get aspect_guideline_high_title;

  /// Good prognosis text
  ///
  /// In en, this message translates to:
  /// **'Good prognosis for EVT'**
  String get aspect_guideline_high_good_prognosis;

  /// Perform in time window text
  ///
  /// In en, this message translates to:
  /// **'Perform within time window'**
  String get aspect_guideline_high_perform_time;

  /// Low risk text
  ///
  /// In en, this message translates to:
  /// **'Low risk of hemorrhagic complications'**
  String get aspect_guideline_high_low_risk;

  /// Good outcome text
  ///
  /// In en, this message translates to:
  /// **'Good functional outcomes'**
  String get aspect_guideline_high_good_outcome;

  /// Medium ASPECT score guideline title
  ///
  /// In en, this message translates to:
  /// **'ASPECT 6-7: Consider EVT'**
  String get aspect_guideline_medium_title;

  /// Case by case evaluation text
  ///
  /// In en, this message translates to:
  /// **'Evaluate case by case'**
  String get aspect_guideline_medium_case_by_case;

  /// Consider age and time text
  ///
  /// In en, this message translates to:
  /// **'Consider age and time factors'**
  String get aspect_guideline_medium_consider_age;

  /// Discuss with family text
  ///
  /// In en, this message translates to:
  /// **'Discuss with family'**
  String get aspect_guideline_medium_discuss_family;

  /// Close monitoring text
  ///
  /// In en, this message translates to:
  /// **'Close monitoring required'**
  String get aspect_guideline_medium_close_monitoring;

  /// Low ASPECT score guideline title
  ///
  /// In en, this message translates to:
  /// **'ASPECT ≤5: Caution with EVT'**
  String get aspect_guideline_low_title;

  /// High risk text
  ///
  /// In en, this message translates to:
  /// **'High risk of complications'**
  String get aspect_guideline_low_high_risk;

  /// Consider carefully text
  ///
  /// In en, this message translates to:
  /// **'Consider very carefully'**
  String get aspect_guideline_low_consider_carefully;

  /// Discuss risks text
  ///
  /// In en, this message translates to:
  /// **'Discuss risks thoroughly'**
  String get aspect_guideline_low_discuss_risks;

  /// Individual decision text
  ///
  /// In en, this message translates to:
  /// **'Individual decision required'**
  String get aspect_guideline_low_individual_decision;

  /// Lesion detected subtitle text
  ///
  /// In en, this message translates to:
  /// **'Lesion detected (subtract 1 point)'**
  String get aspect_lesion_detected;

  /// ASPECT score explanation section title
  ///
  /// In en, this message translates to:
  /// **'ASPECT Score Explanation'**
  String get aspect_score_explanation;

  /// High ASPECT score range
  ///
  /// In en, this message translates to:
  /// **'8-10'**
  String get aspect_score_range_8_10;

  /// Good score level
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get aspect_score_level_good;

  /// Good EVT prognosis
  ///
  /// In en, this message translates to:
  /// **'Good prognosis for EVT'**
  String get aspect_score_prognosis_good_evt;

  /// Perform EVT action
  ///
  /// In en, this message translates to:
  /// **'Perform EVT as indicated'**
  String get aspect_score_action_perform_evt;

  /// Medium ASPECT score range
  ///
  /// In en, this message translates to:
  /// **'6-7'**
  String get aspect_score_range_6_7;

  /// Moderate score level
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get aspect_score_level_moderate;

  /// Consider EVT prognosis
  ///
  /// In en, this message translates to:
  /// **'Consider EVT'**
  String get aspect_score_prognosis_consider_evt;

  /// Assess benefit risk action
  ///
  /// In en, this message translates to:
  /// **'Assess benefit/risk ratio'**
  String get aspect_score_action_assess_benefit;

  /// Low ASPECT score range
  ///
  /// In en, this message translates to:
  /// **'0-5'**
  String get aspect_score_range_0_5;

  /// Poor score level
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get aspect_score_level_poor;

  /// High risk prognosis
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get aspect_score_prognosis_high_risk;

  /// Caution EVT action
  ///
  /// In en, this message translates to:
  /// **'Caution with EVT'**
  String get aspect_score_action_caution_evt;

  /// Modified Sgarbossa Criteria title
  ///
  /// In en, this message translates to:
  /// **'Modified Sgarbossa\'s Criteria'**
  String get modified_sgarbossa_title;

  /// Short title for score display
  ///
  /// In en, this message translates to:
  /// **'Modified Sgarbossa\'s'**
  String get modified_sgarbossa_short;

  /// Points unit
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get sgarbossa_points;

  /// No criteria met interpretation
  ///
  /// In en, this message translates to:
  /// **'No positive criteria'**
  String get sgarbossa_no_criteria;

  /// Low score interpretation
  ///
  /// In en, this message translates to:
  /// **'Suspected STEMI'**
  String get sgarbossa_suspected_stemi;

  /// High score interpretation
  ///
  /// In en, this message translates to:
  /// **'Highly likely STEMI'**
  String get sgarbossa_likely_stemi;

  /// Action for score 0
  ///
  /// In en, this message translates to:
  /// **'Exclude STEMI'**
  String get sgarbossa_action_exclude;

  /// Action for low score
  ///
  /// In en, this message translates to:
  /// **'Further evaluation'**
  String get sgarbossa_action_evaluate;

  /// Action for high score
  ///
  /// In en, this message translates to:
  /// **'Emergency reperfusion'**
  String get sgarbossa_action_urgent;

  /// Recommendation for score 0
  ///
  /// In en, this message translates to:
  /// **'Continue monitoring, consider other causes of chest pain'**
  String get sgarbossa_recommendation_exclude;

  /// Recommendation for low score
  ///
  /// In en, this message translates to:
  /// **'Additional assessment needed: Troponin, Echo, continuous EKG monitoring'**
  String get sgarbossa_recommendation_evaluate;

  /// Recommendation for high score
  ///
  /// In en, this message translates to:
  /// **'STEMI highly likely - Emergency coronary reperfusion needed (PCI or thrombolysis)'**
  String get sgarbossa_recommendation_urgent;

  /// Criteria section title
  ///
  /// In en, this message translates to:
  /// **'Modified Sgarbossa Criteria'**
  String get sgarbossa_criteria_title;

  /// Criteria section description
  ///
  /// In en, this message translates to:
  /// **'STEMI assessment in presence of LBBB or paced rhythm'**
  String get sgarbossa_criteria_description;

  /// First criterion title
  ///
  /// In en, this message translates to:
  /// **'Concordant ST elevation (+5)'**
  String get sgarbossa_concordant_elevation_title;

  /// First criterion description
  ///
  /// In en, this message translates to:
  /// **'ST elevation ≥1mm in leads with positive QRS'**
  String get sgarbossa_concordant_elevation_desc;

  /// Second criterion title
  ///
  /// In en, this message translates to:
  /// **'Concordant ST depression (+3)'**
  String get sgarbossa_concordant_depression_title;

  /// Second criterion description
  ///
  /// In en, this message translates to:
  /// **'ST depression ≥1mm in V1, V2, or V3'**
  String get sgarbossa_concordant_depression_desc;

  /// Third criterion title
  ///
  /// In en, this message translates to:
  /// **'Excessive discordant ST elevation (+2)'**
  String get sgarbossa_excessive_discordant_title;

  /// Third criterion description
  ///
  /// In en, this message translates to:
  /// **'ST elevation ≥1mm and ST/S ratio ≥0.25'**
  String get sgarbossa_excessive_discordant_desc;

  /// Active criteria section title
  ///
  /// In en, this message translates to:
  /// **'Positive criteria ({count})'**
  String sgarbossa_active_criteria(int count);

  /// Interpretation guide section title
  ///
  /// In en, this message translates to:
  /// **'Interpretation Guide'**
  String get sgarbossa_interpretation_guide;

  /// Score 0 label
  ///
  /// In en, this message translates to:
  /// **'0 points'**
  String get sgarbossa_interpretation_0;

  /// Score 1-2 label
  ///
  /// In en, this message translates to:
  /// **'1-2 points'**
  String get sgarbossa_interpretation_1_2;

  /// Score ≥3 label
  ///
  /// In en, this message translates to:
  /// **'≥3 points'**
  String get sgarbossa_interpretation_3_plus;

  /// Clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get sgarbossa_clinical_info_title;

  /// Clinical information text
  ///
  /// In en, this message translates to:
  /// **'Modified Sgarbossa\'s Criteria helps diagnose STEMI in the presence of LBBB or paced rhythm\n\nClinical problem:\n• LBBB masks STEMI signs on EKG\n• Paced rhythm makes ST assessment difficult\n• Special criteria needed for diagnosis\n• Diagnostic delay → reperfusion delay\n\nOriginal criteria (Sgarbossa 1996):\n• Concordant ST elevation ≥1mm (+5)\n• Concordant ST depression ≥1mm in V1-V3 (+3)\n• Discordant ST elevation ≥5mm (+2)\n\nModification (Smith 2012):\n• Changed third criterion\n• Discordant ST elevation with ST/S ratio ≥0.25\n• Increased sensitivity from 52% to 91%\n• High specificity maintained at 90%\n\nHow to measure ST/S ratio:\n• Measure ST elevation height (mm)\n• Measure S wave depth (mm)\n• Calculate ST/S ratio\n• Positive if ≥0.25\n\nImportant notes:\n• Only apply when LBBB or paced rhythm present\n• Combine with clinical symptoms\n• Troponin still needed\n• Time is critical in STEMI'**
  String get sgarbossa_clinical_info_text;

  /// Reference section title
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get sgarbossa_reference_title;

  /// Reference citation text
  ///
  /// In en, this message translates to:
  /// **'Smith SW, Dodd KW, Henry TD, et al. Diagnosis of ST-elevation myocardial infarction in the presence of left bundle branch block with the ST-elevation to S-wave ratio in a modified Sgarbossa rule. Ann Emerg Med. 2012;60(6):766-76.'**
  String get sgarbossa_reference_text;

  /// Action label
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get sgarbossa_action_label;

  /// Recommendation label
  ///
  /// In en, this message translates to:
  /// **'Recommendation:'**
  String get sgarbossa_recommendation_label;

  /// Ranson Criteria page title
  ///
  /// In en, this message translates to:
  /// **'Ranson Criteria'**
  String get ranson_title;

  /// Score display title
  ///
  /// In en, this message translates to:
  /// **'Ranson Criteria Score'**
  String get ranson_score_title;

  /// Mortality rate label
  ///
  /// In en, this message translates to:
  /// **'Mortality rate: {rate}'**
  String ranson_mortality_rate(String rate);

  /// Mild pancreatitis severity
  ///
  /// In en, this message translates to:
  /// **'Mild pancreatitis'**
  String get ranson_severity_mild;

  /// Moderate pancreatitis severity
  ///
  /// In en, this message translates to:
  /// **'Moderate pancreatitis'**
  String get ranson_severity_moderate;

  /// Severe pancreatitis severity
  ///
  /// In en, this message translates to:
  /// **'Severe pancreatitis'**
  String get ranson_severity_severe;

  /// Mild pancreatitis management
  ///
  /// In en, this message translates to:
  /// **'Medical monitoring, supportive treatment'**
  String get ranson_management_mild;

  /// Moderate pancreatitis management
  ///
  /// In en, this message translates to:
  /// **'Close monitoring required, consider ICU'**
  String get ranson_management_moderate;

  /// Severe pancreatitis management
  ///
  /// In en, this message translates to:
  /// **'ICU indicated, consider aggressive intervention'**
  String get ranson_management_severe;

  /// Admission criteria section title
  ///
  /// In en, this message translates to:
  /// **'Admission criteria'**
  String get ranson_admission_criteria;

  /// 48-hour criteria section title
  ///
  /// In en, this message translates to:
  /// **'48-hour criteria'**
  String get ranson_48hour_criteria;

  /// Age criterion
  ///
  /// In en, this message translates to:
  /// **'Age (> 55 years)'**
  String get ranson_age;

  /// WBC criterion
  ///
  /// In en, this message translates to:
  /// **'White blood cell count (> 16,000/μL)'**
  String get ranson_wbc;

  /// Glucose criterion
  ///
  /// In en, this message translates to:
  /// **'Glucose'**
  String get ranson_glucose;

  /// LDH criterion
  ///
  /// In en, this message translates to:
  /// **'LDH (> 350 IU/L)'**
  String get ranson_ldh;

  /// AST criterion
  ///
  /// In en, this message translates to:
  /// **'AST (> 250 IU/L)'**
  String get ranson_ast;

  /// Hematocrit drop criterion
  ///
  /// In en, this message translates to:
  /// **'Hematocrit drop (> 10%)'**
  String get ranson_hematocrit_drop;

  /// BUN rise criterion
  ///
  /// In en, this message translates to:
  /// **'BUN rise'**
  String get ranson_bun_rise;

  /// Calcium drop criterion
  ///
  /// In en, this message translates to:
  /// **'Serum Ca²⁺ (< 8 mg/dL)'**
  String get ranson_calcium_drop;

  /// PO2 drop criterion
  ///
  /// In en, this message translates to:
  /// **'PaO₂ (< 60 mmHg)'**
  String get ranson_po2_drop;

  /// Base deficit criterion
  ///
  /// In en, this message translates to:
  /// **'Base deficit (> 4 mEq/L)'**
  String get ranson_base_deficit;

  /// Fluid sequestration criterion
  ///
  /// In en, this message translates to:
  /// **'Fluid sequestration (> 6L)'**
  String get ranson_fluid_sequestration;

  /// Input field placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter value'**
  String get ranson_enter_value;

  /// Points display
  ///
  /// In en, this message translates to:
  /// **'Points: {points}'**
  String ranson_points(int points);

  /// Unit label
  ///
  /// In en, this message translates to:
  /// **'Unit:'**
  String get ranson_unit;

  /// References section title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get ranson_reference_title;

  /// References text
  ///
  /// In en, this message translates to:
  /// **'Ranson JH, et al. Prognostic signs and the role of operative management in acute pancreatitis. Surg Gynecol Obstet. 1974;139(1):69-81.\n\nBollen TL, et al. A comparative evaluation of radiologic and clinical scoring systems in the early prediction of severity in acute pancreatitis. Am J Gastroenterol. 2012;107(4):612-9.'**
  String get ranson_reference_text;

  /// PSI score title
  ///
  /// In en, this message translates to:
  /// **'PSI Score'**
  String get psi_title;

  /// PSI full name
  ///
  /// In en, this message translates to:
  /// **'Pneumonia Severity Index'**
  String get psi_full_name;

  /// PSI very low risk level
  ///
  /// In en, this message translates to:
  /// **'Very low risk'**
  String get psi_risk_very_low;

  /// PSI low risk level
  ///
  /// In en, this message translates to:
  /// **'Low risk'**
  String get psi_risk_low;

  /// PSI moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate risk'**
  String get psi_risk_moderate;

  /// PSI high risk level
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get psi_risk_high;

  /// PSI very high risk level
  ///
  /// In en, this message translates to:
  /// **'Very high risk'**
  String get psi_risk_very_high;

  /// PSI class display
  ///
  /// In en, this message translates to:
  /// **'Class {classNumber}'**
  String psi_class(int classNumber);

  /// PSI mortality rate
  ///
  /// In en, this message translates to:
  /// **'Mortality rate: {rate}'**
  String psi_mortality_rate(String rate);

  /// PSI outpatient recommendation
  ///
  /// In en, this message translates to:
  /// **'Outpatient treatment possible'**
  String get psi_outpatient_treatment;

  /// PSI outpatient or short stay recommendation
  ///
  /// In en, this message translates to:
  /// **'Consider outpatient or short inpatient care'**
  String get psi_outpatient_or_short;

  /// PSI inpatient recommendation
  ///
  /// In en, this message translates to:
  /// **'Inpatient treatment required'**
  String get psi_inpatient_required;

  /// PSI inpatient with ICU consideration
  ///
  /// In en, this message translates to:
  /// **'Inpatient treatment required, consider ICU'**
  String get psi_inpatient_consider_icu;

  /// PSI no ICU recommendation
  ///
  /// In en, this message translates to:
  /// **'No ICU needed'**
  String get psi_icu_no_need;

  /// PSI no ICU, general ward
  ///
  /// In en, this message translates to:
  /// **'No ICU needed, monitor in general ward'**
  String get psi_icu_not_needed;

  /// PSI consider ICU recommendation
  ///
  /// In en, this message translates to:
  /// **'Consider ICU if high risk factors present'**
  String get psi_icu_consider;

  /// PSI ICU recommended
  ///
  /// In en, this message translates to:
  /// **'ICU admission recommended'**
  String get psi_icu_recommended;

  /// PSI basic information section
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get psi_basic_info;

  /// PSI comorbidities section
  ///
  /// In en, this message translates to:
  /// **'Comorbidities'**
  String get psi_comorbidities;

  /// PSI physical examination section
  ///
  /// In en, this message translates to:
  /// **'Physical Examination'**
  String get psi_physical_exam;

  /// PSI laboratory section
  ///
  /// In en, this message translates to:
  /// **'Laboratory Values'**
  String get psi_laboratory;

  /// PSI gender label
  ///
  /// In en, this message translates to:
  /// **'Gender:'**
  String get psi_gender;

  /// PSI male option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get psi_male;

  /// PSI female option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get psi_female;

  /// PSI age input label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get psi_age_label;

  /// PSI nursing home factor
  ///
  /// In en, this message translates to:
  /// **'Lives in nursing home (+10 points)'**
  String get psi_nursing_home;

  /// PSI neoplastic disease factor
  ///
  /// In en, this message translates to:
  /// **'Neoplastic disease (+30 points)'**
  String get psi_neoplastic_disease;

  /// PSI liver disease factor
  ///
  /// In en, this message translates to:
  /// **'Liver disease (+20 points)'**
  String get psi_liver_disease;

  /// PSI CHF factor
  ///
  /// In en, this message translates to:
  /// **'Congestive heart failure (+10 points)'**
  String get psi_congestive_heart_failure;

  /// PSI cerebrovascular disease factor
  ///
  /// In en, this message translates to:
  /// **'Cerebrovascular disease (+10 points)'**
  String get psi_cerebrovascular_disease;

  /// PSI renal disease factor
  ///
  /// In en, this message translates to:
  /// **'Renal disease (+10 points)'**
  String get psi_renal_disease;

  /// PSI altered mental status factor
  ///
  /// In en, this message translates to:
  /// **'Altered mental status (+20 points)'**
  String get psi_altered_mental_status;

  /// PSI respiratory rate factor
  ///
  /// In en, this message translates to:
  /// **'Respiratory rate'**
  String get psi_respiratory_rate;

  /// PSI systolic BP factor
  ///
  /// In en, this message translates to:
  /// **'Systolic blood pressure'**
  String get psi_systolic_bp;

  /// PSI temperature factor
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get psi_temperature;

  /// PSI pulse factor
  ///
  /// In en, this message translates to:
  /// **'Pulse'**
  String get psi_pulse;

  /// PSI respiratory rate threshold
  ///
  /// In en, this message translates to:
  /// **'≥30'**
  String get psi_respiratory_rate_threshold;

  /// PSI systolic BP threshold
  ///
  /// In en, this message translates to:
  /// **'<90'**
  String get psi_systolic_bp_threshold;

  /// PSI temperature threshold
  ///
  /// In en, this message translates to:
  /// **'<35 or ≥40'**
  String get psi_temperature_threshold;

  /// PSI pulse threshold
  ///
  /// In en, this message translates to:
  /// **'≥125'**
  String get psi_pulse_threshold;

  /// PSI arterial pH factor
  ///
  /// In en, this message translates to:
  /// **'Arterial pH (<7.35)'**
  String get psi_arterial_ph;

  /// PSI BUN factor
  ///
  /// In en, this message translates to:
  /// **'BUN'**
  String get psi_bun;

  /// PSI BUN threshold
  ///
  /// In en, this message translates to:
  /// **'≥30 mg/dL (10.7 mmol/L)'**
  String get psi_bun_threshold;

  /// PSI sodium factor
  ///
  /// In en, this message translates to:
  /// **'Sodium (<130 mmol/L)'**
  String get psi_sodium;

  /// PSI glucose factor
  ///
  /// In en, this message translates to:
  /// **'Glucose'**
  String get psi_glucose;

  /// PSI glucose threshold
  ///
  /// In en, this message translates to:
  /// **'≥250 mg/dL (13.9 mmol/L)'**
  String get psi_glucose_threshold;

  /// PSI hematocrit factor
  ///
  /// In en, this message translates to:
  /// **'Hematocrit (<30%)'**
  String get psi_hematocrit;

  /// PSI PaO2 factor
  ///
  /// In en, this message translates to:
  /// **'PaO₂ (<60 mmHg)'**
  String get psi_pao2;

  /// PSI pleural effusion factor
  ///
  /// In en, this message translates to:
  /// **'Pleural effusion (+10 points)'**
  String get psi_pleural_effusion;

  /// PSI unit label
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get psi_unit_label;

  /// PSI score display
  ///
  /// In en, this message translates to:
  /// **'Score: {score}'**
  String psi_score_label(int score);

  /// PSI ICU criteria title
  ///
  /// In en, this message translates to:
  /// **'ICU Consideration Criteria'**
  String get psi_icu_criteria_title;

  /// PSI ICU criteria content
  ///
  /// In en, this message translates to:
  /// **'• PSI Class IV-V: Requires close monitoring, consider ICU\n• Additional high-risk factors:\n  - Respiratory failure (PaO₂ < 60 mmHg)\n  - Altered mental status\n  - Hypotension (SBP < 90 mmHg)\n  - Multiple severe comorbidities\n  - Advanced age + severe symptoms\n• Class V (>130 points): ICU recommended due to high mortality (>27%)'**
  String get psi_icu_criteria_content;

  /// PSI ICU recommendation
  ///
  /// In en, this message translates to:
  /// **'ICU: {recommendation}'**
  String psi_icu_recommendation(String recommendation);

  /// PSI reference title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get psi_reference_title;

  /// PSI reference text
  ///
  /// In en, this message translates to:
  /// **'Fine MJ, et al. A prediction rule to identify low-risk patients with community-acquired pneumonia. N Engl J Med. 1997;336(4):243-50.\n\nAujesky D, et al. Prospective comparison of three validated prediction rules for prognosis in community-acquired pneumonia. Am J Med. 2005;118(4):384-92.'**
  String get psi_reference_text;

  /// General unit label
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// General value label
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// ASA Physical Status page title
  ///
  /// In en, this message translates to:
  /// **'ASA Physical Status'**
  String get asa_title;

  /// ASA not classified status
  ///
  /// In en, this message translates to:
  /// **'Not classified'**
  String get asa_not_classified;

  /// Prompt to select ASA classification
  ///
  /// In en, this message translates to:
  /// **'Please select ASA classification'**
  String get asa_select_classification;

  /// ASA Class 1 title
  ///
  /// In en, this message translates to:
  /// **'ASA I - Normal'**
  String get asa_class_1_title;

  /// ASA Class 1 description
  ///
  /// In en, this message translates to:
  /// **'Normal healthy patient'**
  String get asa_class_1_description;

  /// ASA Class 1 examples
  ///
  /// In en, this message translates to:
  /// **'No systemic disease, non-smoker, no or minimal alcohol consumption'**
  String get asa_class_1_examples;

  /// ASA Class 2 title
  ///
  /// In en, this message translates to:
  /// **'ASA II - Mild disease'**
  String get asa_class_2_title;

  /// ASA Class 2 description
  ///
  /// In en, this message translates to:
  /// **'Patient with mild systemic disease'**
  String get asa_class_2_description;

  /// ASA Class 2 examples
  ///
  /// In en, this message translates to:
  /// **'Smoker, social drinker, obesity, pregnancy, well-controlled diabetes, well-controlled hypertension'**
  String get asa_class_2_examples;

  /// ASA Class 3 title
  ///
  /// In en, this message translates to:
  /// **'ASA III - Severe disease'**
  String get asa_class_3_title;

  /// ASA Class 3 description
  ///
  /// In en, this message translates to:
  /// **'Patient with severe systemic disease'**
  String get asa_class_3_description;

  /// ASA Class 3 examples
  ///
  /// In en, this message translates to:
  /// **'Poorly controlled diabetes, poorly controlled hypertension, COPD, morbid obesity, organ dysfunction'**
  String get asa_class_3_examples;

  /// ASA Class 4 title
  ///
  /// In en, this message translates to:
  /// **'ASA IV - Life-threatening'**
  String get asa_class_4_title;

  /// ASA Class 4 description
  ///
  /// In en, this message translates to:
  /// **'Patient with severe systemic disease that is a constant threat to life'**
  String get asa_class_4_description;

  /// ASA Class 4 examples
  ///
  /// In en, this message translates to:
  /// **'Recent MI, CVA, TIA, CAD, severe renal failure requiring dialysis'**
  String get asa_class_4_examples;

  /// ASA Class 5 title
  ///
  /// In en, this message translates to:
  /// **'ASA V - Moribund'**
  String get asa_class_5_title;

  /// ASA Class 5 description
  ///
  /// In en, this message translates to:
  /// **'Moribund patient who is not expected to survive without operation'**
  String get asa_class_5_description;

  /// ASA Class 5 examples
  ///
  /// In en, this message translates to:
  /// **'Ruptured abdominal aortic aneurysm, severe multiple trauma with organ dysfunction, sepsis with organ dysfunction'**
  String get asa_class_5_examples;

  /// ASA Class 6 title
  ///
  /// In en, this message translates to:
  /// **'ASA VI - Brain dead'**
  String get asa_class_6_title;

  /// ASA Class 6 description
  ///
  /// In en, this message translates to:
  /// **'Brain dead patient whose organs are being removed for donor purposes'**
  String get asa_class_6_description;

  /// ASA Class 6 examples
  ///
  /// In en, this message translates to:
  /// **'Patient declared brain dead for organ donation'**
  String get asa_class_6_examples;

  /// ASA perioperative mortality label
  ///
  /// In en, this message translates to:
  /// **'Perioperative Mortality'**
  String get asa_perioperative_mortality;

  /// ASA anesthesia risk label
  ///
  /// In en, this message translates to:
  /// **'Anesthesia Risk'**
  String get asa_anesthesia_risk;

  /// Low anesthesia risk
  ///
  /// In en, this message translates to:
  /// **'Low anesthesia risk'**
  String get asa_risk_low;

  /// Low-moderate anesthesia risk
  ///
  /// In en, this message translates to:
  /// **'Low-moderate anesthesia risk'**
  String get asa_risk_low_moderate;

  /// Moderate-high anesthesia risk
  ///
  /// In en, this message translates to:
  /// **'Moderate-high anesthesia risk'**
  String get asa_risk_moderate_high;

  /// High anesthesia risk
  ///
  /// In en, this message translates to:
  /// **'High anesthesia risk'**
  String get asa_risk_high;

  /// Very high anesthesia risk
  ///
  /// In en, this message translates to:
  /// **'Very high anesthesia risk'**
  String get asa_risk_very_high;

  /// Not applicable
  ///
  /// In en, this message translates to:
  /// **'Not applicable'**
  String get asa_risk_not_applicable;

  /// ASA Class 1 recommendation
  ///
  /// In en, this message translates to:
  /// **'Can undergo normal surgery'**
  String get asa_recommendation_class_1;

  /// ASA Class 2 recommendation
  ///
  /// In en, this message translates to:
  /// **'Need to control disease before surgery'**
  String get asa_recommendation_class_2;

  /// ASA Class 3 recommendation
  ///
  /// In en, this message translates to:
  /// **'Need to optimize condition before surgery, close monitoring required'**
  String get asa_recommendation_class_3;

  /// ASA Class 4 recommendation
  ///
  /// In en, this message translates to:
  /// **'Consider benefit/risk ratio, may need ICU postoperatively'**
  String get asa_recommendation_class_4;

  /// ASA Class 5 recommendation
  ///
  /// In en, this message translates to:
  /// **'Emergency surgery only for life-saving, poor prognosis'**
  String get asa_recommendation_class_5;

  /// ASA Class 6 recommendation
  ///
  /// In en, this message translates to:
  /// **'Organ procurement surgery'**
  String get asa_recommendation_class_6;

  /// ASA classifications section title
  ///
  /// In en, this message translates to:
  /// **'ASA Physical Status Classifications'**
  String get asa_classifications;

  /// Important notes section title
  ///
  /// In en, this message translates to:
  /// **'Important Notes'**
  String get asa_important_notes;

  /// ASA important notes text
  ///
  /// In en, this message translates to:
  /// **'• ASA is assessed by anesthesiologist before surgery\n• Suffix \"E\" is added for emergency surgery (e.g., ASA III-E)\n• ASA does not directly predict anesthesia risk but reflects health status\n• Should be combined with other factors: age, type of surgery, anesthesia technique\n• ASA IV-V require special preparation and may need postoperative ICU'**
  String get asa_notes_text;

  /// ASA reference title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get asa_reference_title;

  /// ASA reference text
  ///
  /// In en, this message translates to:
  /// **'American Society of Anesthesiologists. ASA Physical Status Classification System. Last approved by the ASA House of Delegates on October 15, 2014, and last amended on December 13, 2020.'**
  String get asa_reference_text;

  /// RCRI page title
  ///
  /// In en, this message translates to:
  /// **'Revised Cardiac Risk Index'**
  String get rcri_title;

  /// RCRI subtitle
  ///
  /// In en, this message translates to:
  /// **'RCRI (Lee Index)'**
  String get rcri_subtitle;

  /// RCRI very low risk level
  ///
  /// In en, this message translates to:
  /// **'Very Low Risk'**
  String get rcri_risk_very_low;

  /// RCRI low risk level
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get rcri_risk_low;

  /// RCRI moderate risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get rcri_risk_moderate;

  /// RCRI high risk level
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get rcri_risk_high;

  /// RCRI cardiac event risk label
  ///
  /// In en, this message translates to:
  /// **'Cardiac Event Risk'**
  String get rcri_cardiac_event_risk;

  /// RCRI perioperative management label
  ///
  /// In en, this message translates to:
  /// **'Perioperative Management:'**
  String get rcri_perioperative_management;

  /// RCRI recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get rcri_recommendations;

  /// RCRI standard management
  ///
  /// In en, this message translates to:
  /// **'Standard perioperative management'**
  String get rcri_management_standard;

  /// RCRI monitoring management
  ///
  /// In en, this message translates to:
  /// **'Cardiac monitoring during surgery'**
  String get rcri_management_monitoring;

  /// RCRI intensive management
  ///
  /// In en, this message translates to:
  /// **'Close cardiac monitoring, postop ICU'**
  String get rcri_management_intensive;

  /// RCRI invasive management
  ///
  /// In en, this message translates to:
  /// **'Invasive monitoring, ICU monitoring, consider circulatory support'**
  String get rcri_management_invasive;

  /// RCRI recommendation for score 0
  ///
  /// In en, this message translates to:
  /// **'Proceed with planned surgery, no additional cardiac evaluation needed'**
  String get rcri_recommendation_0;

  /// RCRI recommendation for score 1
  ///
  /// In en, this message translates to:
  /// **'Consider cardiac evaluation if symptomatic or high-risk surgery'**
  String get rcri_recommendation_1;

  /// RCRI recommendation for score 2
  ///
  /// In en, this message translates to:
  /// **'Recommend preoperative cardiac evaluation, optimize treatment'**
  String get rcri_recommendation_2;

  /// RCRI recommendation for score 3+
  ///
  /// In en, this message translates to:
  /// **'Mandatory comprehensive cardiac evaluation, consider preoperative intervention'**
  String get rcri_recommendation_3;

  /// RCRI risk factors section title
  ///
  /// In en, this message translates to:
  /// **'Cardiac Risk Factors'**
  String get rcri_risk_factors_title;

  /// RCRI current risk factors title
  ///
  /// In en, this message translates to:
  /// **'Current Risk Factors ({count})'**
  String rcri_current_risk_factors(int count);

  /// RCRI high-risk surgery examples title
  ///
  /// In en, this message translates to:
  /// **'Examples of High-Risk Surgery'**
  String get rcri_high_risk_surgery_title;

  /// RCRI risk stratification title
  ///
  /// In en, this message translates to:
  /// **'Risk Stratification'**
  String get rcri_risk_stratification_title;

  /// RCRI clinical information title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get rcri_clinical_info_title;

  /// High-risk surgery examples section title
  ///
  /// In en, this message translates to:
  /// **'Examples of High-Risk Surgery'**
  String get rcri_surgery_examples;

  /// Aortic surgery example
  ///
  /// In en, this message translates to:
  /// **'Aortic and major vascular surgery'**
  String get rcri_surgery_aortic;

  /// Peripheral vascular surgery example
  ///
  /// In en, this message translates to:
  /// **'Peripheral vascular surgery'**
  String get rcri_surgery_peripheral;

  /// Abdominal surgery example
  ///
  /// In en, this message translates to:
  /// **'Major abdominal surgery'**
  String get rcri_surgery_abdominal;

  /// Thoracic surgery example
  ///
  /// In en, this message translates to:
  /// **'Thoracic surgery (non-cardiac)'**
  String get rcri_surgery_thoracic;

  /// Renal surgery example
  ///
  /// In en, this message translates to:
  /// **'Renal surgery'**
  String get rcri_surgery_renal;

  /// Hepatic surgery example
  ///
  /// In en, this message translates to:
  /// **'Major hepatic surgery'**
  String get rcri_surgery_hepatic;

  /// Head-neck surgery example
  ///
  /// In en, this message translates to:
  /// **'Head-neck surgery with major blood loss'**
  String get rcri_surgery_head_neck;

  /// Orthopedic surgery example
  ///
  /// In en, this message translates to:
  /// **'Major orthopedic surgery with blood loss'**
  String get rcri_surgery_orthopedic;

  /// Cardiac event risk label
  ///
  /// In en, this message translates to:
  /// **'Cardiac Event Risk'**
  String get rcri_cardiac_event_risk_label;

  /// Perioperative management label
  ///
  /// In en, this message translates to:
  /// **'Perioperative Management:'**
  String get rcri_perioperative_mgmt_label;

  /// RCRI clinical information text
  ///
  /// In en, this message translates to:
  /// **'Revised Cardiac Risk Index (RCRI/Lee Index) assesses perioperative cardiac event risk\n\nCardiac events include:\n• Myocardial infarction\n• Acute pulmonary edema\n• Complete atrioventricular block\n• Cardiac arrest\n• Ventricular fibrillation\n\nClinical applications:\n• Preoperative risk assessment\n• Decision for additional cardiac evaluation\n• Anesthesia method and monitoring selection\n• Patient risk counseling\n\nImportant notes:\n• Applies to non-cardiac surgery\n• Does not replace comprehensive clinical assessment\n• Consider other risk factors\n• Optimize medical treatment before surgery'**
  String get rcri_clinical_info_text;

  /// RCRI references section title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get rcri_references;

  /// RCRI score 0 risk title
  ///
  /// In en, this message translates to:
  /// **'Very Low Risk'**
  String get rcri_risk_0_title;

  /// RCRI score 0 description
  ///
  /// In en, this message translates to:
  /// **'No additional evaluation needed'**
  String get rcri_risk_0_desc;

  /// RCRI score 1 risk title
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get rcri_risk_1_title;

  /// RCRI score 1 description
  ///
  /// In en, this message translates to:
  /// **'Consider evaluation if symptomatic'**
  String get rcri_risk_1_desc;

  /// RCRI score 2 risk title
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get rcri_risk_2_title;

  /// RCRI score 2 description
  ///
  /// In en, this message translates to:
  /// **'Recommend preoperative evaluation'**
  String get rcri_risk_2_desc;

  /// RCRI score 3+ risk title
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get rcri_risk_3_title;

  /// RCRI score 3+ description
  ///
  /// In en, this message translates to:
  /// **'Mandatory comprehensive evaluation'**
  String get rcri_risk_3_desc;

  /// RCRI ischemic heart disease title
  ///
  /// In en, this message translates to:
  /// **'Ischemic Heart Disease'**
  String get rcri_ihd_title;

  /// RCRI ischemic heart disease description
  ///
  /// In en, this message translates to:
  /// **'History of MI, positive stress test, angina, nitrate use, pathologic Q waves'**
  String get rcri_ihd_description;

  /// RCRI congestive heart failure title
  ///
  /// In en, this message translates to:
  /// **'Congestive Heart Failure'**
  String get rcri_chf_title;

  /// RCRI congestive heart failure description
  ///
  /// In en, this message translates to:
  /// **'History of CHF, pulmonary edema, orthopnea, lung crackles, cardiomegaly, peripheral edema'**
  String get rcri_chf_description;

  /// RCRI cerebrovascular disease title
  ///
  /// In en, this message translates to:
  /// **'Cerebrovascular Disease'**
  String get rcri_cvd_title;

  /// RCRI cerebrovascular disease description
  ///
  /// In en, this message translates to:
  /// **'History of stroke or transient ischemic attack'**
  String get rcri_cvd_description;

  /// RCRI diabetes title
  ///
  /// In en, this message translates to:
  /// **'Diabetes Requiring Insulin'**
  String get rcri_dm_title;

  /// RCRI diabetes description
  ///
  /// In en, this message translates to:
  /// **'Type 1 or Type 2 diabetes requiring insulin therapy'**
  String get rcri_dm_description;

  /// RCRI renal failure title
  ///
  /// In en, this message translates to:
  /// **'Renal Failure (Creatinine >2.0)'**
  String get rcri_renal_title;

  /// RCRI renal failure description
  ///
  /// In en, this message translates to:
  /// **'Serum creatinine >2.0 mg/dL (177 μmol/L)'**
  String get rcri_renal_description;

  /// RCRI high-risk surgery title
  ///
  /// In en, this message translates to:
  /// **'High-Risk Surgery'**
  String get rcri_surgery_title;

  /// RCRI high-risk surgery description
  ///
  /// In en, this message translates to:
  /// **'Intraperitoneal, intrathoracic, or suprainguinal vascular surgery'**
  String get rcri_surgery_description;

  /// RCRI active factors title
  ///
  /// In en, this message translates to:
  /// **'Current Risk Factors ({count})'**
  String rcri_active_factors(int count);

  /// RCRI high-risk surgeries title
  ///
  /// In en, this message translates to:
  /// **'High-Risk Surgeries'**
  String get rcri_high_risk_surgeries;

  /// RCRI surgery type 1
  ///
  /// In en, this message translates to:
  /// **'Aortic and major vascular surgery'**
  String get rcri_surgery_1;

  /// RCRI surgery type 2
  ///
  /// In en, this message translates to:
  /// **'Peripheral vascular surgery'**
  String get rcri_surgery_2;

  /// RCRI surgery type 3
  ///
  /// In en, this message translates to:
  /// **'Major intraabdominal surgery'**
  String get rcri_surgery_3;

  /// RCRI surgery type 4
  ///
  /// In en, this message translates to:
  /// **'Intrathoracic surgery (non-cardiac)'**
  String get rcri_surgery_4;

  /// RCRI surgery type 5
  ///
  /// In en, this message translates to:
  /// **'Renal surgery'**
  String get rcri_surgery_5;

  /// RCRI surgery type 6
  ///
  /// In en, this message translates to:
  /// **'Major hepatic surgery'**
  String get rcri_surgery_6;

  /// RCRI surgery type 7
  ///
  /// In en, this message translates to:
  /// **'Head and neck surgery with significant blood loss'**
  String get rcri_surgery_7;

  /// RCRI surgery type 8
  ///
  /// In en, this message translates to:
  /// **'Major orthopedic surgery with significant blood loss'**
  String get rcri_surgery_8;

  /// RCRI risk stratification title
  ///
  /// In en, this message translates to:
  /// **'Cardiac Event Risk Stratification'**
  String get rcri_risk_stratification;

  /// RCRI score 0 action
  ///
  /// In en, this message translates to:
  /// **'No additional evaluation needed'**
  String get rcri_score_0_action;

  /// RCRI score 1 action
  ///
  /// In en, this message translates to:
  /// **'Consider evaluation if symptomatic'**
  String get rcri_score_1_action;

  /// RCRI score 2 action
  ///
  /// In en, this message translates to:
  /// **'Recommend cardiac evaluation'**
  String get rcri_score_2_action;

  /// RCRI score 3+ action
  ///
  /// In en, this message translates to:
  /// **'Mandatory comprehensive evaluation'**
  String get rcri_score_3_action;

  /// RCRI clinical info title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get rcri_clinical_info;

  /// RCRI clinical information text
  ///
  /// In en, this message translates to:
  /// **'Revised Cardiac Risk Index (RCRI/Lee Index) evaluates perioperative cardiac event risk\n\nCardiac events include:\n• Myocardial infarction\n• Acute pulmonary edema\n• Complete heart block\n• Cardiac arrest\n• Ventricular fibrillation\n\nClinical applications:\n• Preoperative risk assessment\n• Decision for additional cardiac evaluation\n• Choice of anesthesia method and monitoring\n• Risk counseling for patients\n\nImportant notes:\n• Applies to non-cardiac surgery\n• Does not replace comprehensive clinical assessment\n• Consider other risk factors\n• Optimize medical treatment before surgery'**
  String get rcri_clinical_text;

  /// RCRI reference title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get rcri_reference_title;

  /// RCRI reference text
  ///
  /// In en, this message translates to:
  /// **'Lee TH, Marcantonio ER, Mangione CM, et al. Derivation and prospective validation of a simple index for prediction of cardiac risk of major noncardiac surgery. Circulation. 1999;100(10):1043-9.'**
  String get rcri_reference_text;

  /// Surgical Apgar Score page title
  ///
  /// In en, this message translates to:
  /// **'Surgical Apgar Score'**
  String get surgical_apgar_title;

  /// Surgical Apgar Score subtitle
  ///
  /// In en, this message translates to:
  /// **'Postoperative complication risk assessment'**
  String get surgical_apgar_subtitle;

  /// Surgical Apgar low risk level
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get surgical_apgar_risk_low;

  /// Surgical Apgar moderate low risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate Low'**
  String get surgical_apgar_risk_moderate_low;

  /// Surgical Apgar moderate high risk level
  ///
  /// In en, this message translates to:
  /// **'Moderate High'**
  String get surgical_apgar_risk_moderate_high;

  /// Surgical Apgar high risk level
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get surgical_apgar_risk_high;

  /// Surgical Apgar very high risk level
  ///
  /// In en, this message translates to:
  /// **'Very High'**
  String get surgical_apgar_risk_very_high;

  /// Surgical Apgar heart rate input label
  ///
  /// In en, this message translates to:
  /// **'Lowest Heart Rate'**
  String get surgical_apgar_heart_rate_label;

  /// Heart rate unit beats per minute
  ///
  /// In en, this message translates to:
  /// **'bpm'**
  String get surgical_apgar_heart_rate_unit;

  /// Heart rate input helper text
  ///
  /// In en, this message translates to:
  /// **'Lowest heart rate during surgery'**
  String get surgical_apgar_heart_rate_helper;

  /// Surgical Apgar blood pressure input label
  ///
  /// In en, this message translates to:
  /// **'Lowest Mean Arterial Pressure'**
  String get surgical_apgar_blood_pressure_label;

  /// Blood pressure unit mmHg
  ///
  /// In en, this message translates to:
  /// **'mmHg'**
  String get surgical_apgar_blood_pressure_unit;

  /// Blood pressure input helper text
  ///
  /// In en, this message translates to:
  /// **'Lowest MAP during surgery'**
  String get surgical_apgar_blood_pressure_helper;

  /// Surgical Apgar blood loss input label
  ///
  /// In en, this message translates to:
  /// **'Estimated Blood Loss'**
  String get surgical_apgar_blood_loss_label;

  /// Blood loss unit mL per kg
  ///
  /// In en, this message translates to:
  /// **'mL/kg'**
  String get surgical_apgar_blood_loss_unit;

  /// Blood loss input helper text
  ///
  /// In en, this message translates to:
  /// **'Total blood loss / body weight'**
  String get surgical_apgar_blood_loss_helper;

  /// Surgical parameters section title
  ///
  /// In en, this message translates to:
  /// **'Surgical Parameters'**
  String get surgical_apgar_parameters_title;

  /// Score breakdown section title
  ///
  /// In en, this message translates to:
  /// **'Score Breakdown'**
  String get surgical_apgar_score_breakdown_title;

  /// Risk stratification section title
  ///
  /// In en, this message translates to:
  /// **'Risk Stratification'**
  String get surgical_apgar_risk_stratification_title;

  /// Clinical guidelines section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Guidelines'**
  String get surgical_apgar_clinical_guidelines_title;

  /// Clinical information section title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get surgical_apgar_clinical_info_title;

  /// Complication risk label
  ///
  /// In en, this message translates to:
  /// **'Complications'**
  String get surgical_apgar_complication_risk;

  /// Mortality risk label
  ///
  /// In en, this message translates to:
  /// **'Mortality'**
  String get surgical_apgar_mortality_risk;

  /// Recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get surgical_apgar_recommendations;

  /// Low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Standard postoperative monitoring, good prognosis'**
  String get surgical_apgar_recommendation_low;

  /// Moderate low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Close monitoring, early complication screening'**
  String get surgical_apgar_recommendation_moderate_low;

  /// Moderate high risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Active monitoring, prepare for intervention'**
  String get surgical_apgar_recommendation_moderate_high;

  /// High risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Special monitoring, high complication risk'**
  String get surgical_apgar_recommendation_high;

  /// Very high risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Intensive monitoring, extremely high risk, consider ICU'**
  String get surgical_apgar_recommendation_very_high;

  /// Heart rate scoring parameter
  ///
  /// In en, this message translates to:
  /// **'Lowest Heart Rate'**
  String get surgical_apgar_heart_rate_scoring;

  /// MAP scoring parameter
  ///
  /// In en, this message translates to:
  /// **'Lowest MAP'**
  String get surgical_apgar_map_scoring;

  /// Blood loss scoring parameter
  ///
  /// In en, this message translates to:
  /// **'Estimated Blood Loss'**
  String get surgical_apgar_blood_loss_scoring;

  /// Points unit
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get surgical_apgar_score_points;

  /// Heart rate criteria 1
  ///
  /// In en, this message translates to:
  /// **'≥56 bpm: 2 points'**
  String get surgical_apgar_hr_criteria_1;

  /// Heart rate criteria 2
  ///
  /// In en, this message translates to:
  /// **'40-55 bpm: 1 point'**
  String get surgical_apgar_hr_criteria_2;

  /// Heart rate criteria 3
  ///
  /// In en, this message translates to:
  /// **'<40 bpm: 0 points'**
  String get surgical_apgar_hr_criteria_3;

  /// MAP criteria 1
  ///
  /// In en, this message translates to:
  /// **'≥70 mmHg: 2 points'**
  String get surgical_apgar_map_criteria_1;

  /// MAP criteria 2
  ///
  /// In en, this message translates to:
  /// **'40-69 mmHg: 1 point'**
  String get surgical_apgar_map_criteria_2;

  /// MAP criteria 3
  ///
  /// In en, this message translates to:
  /// **'<40 mmHg: 0 points'**
  String get surgical_apgar_map_criteria_3;

  /// Blood loss criteria 1
  ///
  /// In en, this message translates to:
  /// **'≤10 mL/kg: 2 points'**
  String get surgical_apgar_bl_criteria_1;

  /// Blood loss criteria 2
  ///
  /// In en, this message translates to:
  /// **'11-40 mL/kg: 1 point'**
  String get surgical_apgar_bl_criteria_2;

  /// Blood loss criteria 3
  ///
  /// In en, this message translates to:
  /// **'>40 mL/kg: 0 points'**
  String get surgical_apgar_bl_criteria_3;

  /// Score range 6-7
  ///
  /// In en, this message translates to:
  /// **'6-7'**
  String get surgical_apgar_score_6_7;

  /// Score range 4-5
  ///
  /// In en, this message translates to:
  /// **'4-5'**
  String get surgical_apgar_score_4_5;

  /// Score range 2-3
  ///
  /// In en, this message translates to:
  /// **'2-3'**
  String get surgical_apgar_score_2_3;

  /// Score range 0-1
  ///
  /// In en, this message translates to:
  /// **'0-1'**
  String get surgical_apgar_score_0_1;

  /// Low risk guideline title
  ///
  /// In en, this message translates to:
  /// **'Score 6-7: Low Risk'**
  String get surgical_apgar_guideline_low_title;

  /// Moderate risk guideline title
  ///
  /// In en, this message translates to:
  /// **'Score 4-5: Moderate Risk'**
  String get surgical_apgar_guideline_moderate_title;

  /// High risk guideline title
  ///
  /// In en, this message translates to:
  /// **'Score ≤3: High Risk'**
  String get surgical_apgar_guideline_high_title;

  /// Low risk guideline 1
  ///
  /// In en, this message translates to:
  /// **'Standard postoperative monitoring'**
  String get surgical_apgar_guideline_low_1;

  /// Low risk guideline 2
  ///
  /// In en, this message translates to:
  /// **'Early discharge if appropriate'**
  String get surgical_apgar_guideline_low_2;

  /// Low risk guideline 3
  ///
  /// In en, this message translates to:
  /// **'Routine outpatient follow-up'**
  String get surgical_apgar_guideline_low_3;

  /// Low risk guideline 4
  ///
  /// In en, this message translates to:
  /// **'Good prognosis'**
  String get surgical_apgar_guideline_low_4;

  /// Moderate risk guideline 1
  ///
  /// In en, this message translates to:
  /// **'Close monitoring 24-48h'**
  String get surgical_apgar_guideline_moderate_1;

  /// Moderate risk guideline 2
  ///
  /// In en, this message translates to:
  /// **'Early complication screening'**
  String get surgical_apgar_guideline_moderate_2;

  /// Moderate risk guideline 3
  ///
  /// In en, this message translates to:
  /// **'Consider special monitoring'**
  String get surgical_apgar_guideline_moderate_3;

  /// Moderate risk guideline 4
  ///
  /// In en, this message translates to:
  /// **'Counsel family about risks'**
  String get surgical_apgar_guideline_moderate_4;

  /// High risk guideline 1
  ///
  /// In en, this message translates to:
  /// **'ICU/HDU monitoring'**
  String get surgical_apgar_guideline_high_1;

  /// High risk guideline 2
  ///
  /// In en, this message translates to:
  /// **'Active complication screening'**
  String get surgical_apgar_guideline_high_2;

  /// High risk guideline 3
  ///
  /// In en, this message translates to:
  /// **'Multi-organ support if needed'**
  String get surgical_apgar_guideline_high_3;

  /// High risk guideline 4
  ///
  /// In en, this message translates to:
  /// **'Detailed prognostic counseling'**
  String get surgical_apgar_guideline_high_4;

  /// Standard management
  ///
  /// In en, this message translates to:
  /// **'Standard monitoring'**
  String get surgical_apgar_management_standard;

  /// Close monitoring management
  ///
  /// In en, this message translates to:
  /// **'Close monitoring'**
  String get surgical_apgar_management_close;

  /// Active monitoring management
  ///
  /// In en, this message translates to:
  /// **'Active monitoring'**
  String get surgical_apgar_management_active;

  /// Special monitoring management
  ///
  /// In en, this message translates to:
  /// **'Special monitoring'**
  String get surgical_apgar_management_special;

  /// Intensive monitoring management
  ///
  /// In en, this message translates to:
  /// **'Intensive monitoring'**
  String get surgical_apgar_management_intensive;

  /// Surgical Apgar clinical information text
  ///
  /// In en, this message translates to:
  /// **'Surgical Apgar Score assesses postoperative complication risk\n\nThree main parameters:\n• Lowest heart rate during surgery\n• Lowest mean arterial pressure\n• Estimated blood loss\n\nAssessment timing:\n• End of surgery\n• Before transfer to recovery\n• Recorded in surgical records\n\nClinical applications:\n• Predict early complications\n• Determine monitoring level\n• Family counseling\n• Quality improvement\n\nCommon complications:\n• Surgical site infection\n• Anastomotic leak\n• Respiratory failure\n• Heart failure\n• Embolism\n\nAdvantages:\n• Simple, easy to calculate\n• Available immediately post-op\n• High reliability\n• Wide applicability\n\nLimitations:\n• Does not predict late complications\n• Depends on accurate recording\n• Needs combined assessment\n• Varies by surgery type'**
  String get surgical_apgar_clinical_text;

  /// Surgical Apgar reference title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get surgical_apgar_reference_title;

  /// Surgical Apgar reference text
  ///
  /// In en, this message translates to:
  /// **'Gawande AA, et al. An Apgar score for surgery. J Am Coll Surg. 2007;204(2):201-8.\n\nRegenbogen SE, et al. The intraoperative Surgical Apgar Score predicts postoperative complications in patients undergoing pancreaticoduodenectomy. J Gastrointest Surg. 2008;12(11):2031-9.'**
  String get surgical_apgar_reference_text;

  /// Preoperative mortality prediction page title
  ///
  /// In en, this message translates to:
  /// **'Preoperative Mortality Prediction'**
  String get preop_mortality_title;

  /// Preoperative mortality subtitle
  ///
  /// In en, this message translates to:
  /// **'30-day surgical mortality risk'**
  String get preop_mortality_subtitle;

  /// Surgical mortality risk title
  ///
  /// In en, this message translates to:
  /// **'Surgical Mortality Risk'**
  String get preop_mortality_risk_title;

  /// Very low mortality risk
  ///
  /// In en, this message translates to:
  /// **'Very Low'**
  String get preop_mortality_risk_very_low;

  /// Low mortality risk
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get preop_mortality_risk_low;

  /// Moderate mortality risk
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get preop_mortality_risk_moderate;

  /// High mortality risk
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get preop_mortality_risk_high;

  /// Very high mortality risk
  ///
  /// In en, this message translates to:
  /// **'Very High'**
  String get preop_mortality_risk_very_high;

  /// Recommendations label
  ///
  /// In en, this message translates to:
  /// **'Recommendations:'**
  String get preop_mortality_recommendations;

  /// Very low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Safe surgery, standard monitoring'**
  String get preop_mortality_recommendation_very_low;

  /// Low risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Low risk, standard surgical preparation'**
  String get preop_mortality_recommendation_low;

  /// Moderate risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Optimize preoperative condition, close monitoring'**
  String get preop_mortality_recommendation_moderate;

  /// High risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Consider benefit/risk ratio, counsel family'**
  String get preop_mortality_recommendation_high;

  /// Very high risk recommendation
  ///
  /// In en, this message translates to:
  /// **'Very high risk, consider less invasive alternatives'**
  String get preop_mortality_recommendation_very_high;

  /// Patient factors section title
  ///
  /// In en, this message translates to:
  /// **'Patient Factors'**
  String get preop_mortality_patient_factors;

  /// Age input label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get preop_mortality_age_label;

  /// Age unit
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get preop_mortality_age_unit;

  /// ASA classification label
  ///
  /// In en, this message translates to:
  /// **'ASA Physical Status'**
  String get preop_mortality_asa_label;

  /// ASA class I description
  ///
  /// In en, this message translates to:
  /// **'ASA I: Healthy patient'**
  String get preop_mortality_asa_1;

  /// ASA class II description
  ///
  /// In en, this message translates to:
  /// **'ASA II: Patient with mild systemic disease'**
  String get preop_mortality_asa_2;

  /// ASA class III description
  ///
  /// In en, this message translates to:
  /// **'ASA III: Patient with severe systemic disease'**
  String get preop_mortality_asa_3;

  /// ASA class IV description
  ///
  /// In en, this message translates to:
  /// **'ASA IV: Patient with life-threatening disease'**
  String get preop_mortality_asa_4;

  /// ASA class V description
  ///
  /// In en, this message translates to:
  /// **'ASA V: Moribund patient'**
  String get preop_mortality_asa_5;

  /// Surgical factors section title
  ///
  /// In en, this message translates to:
  /// **'Surgical Factors'**
  String get preop_mortality_surgery_factors;

  /// Surgery risk level label
  ///
  /// In en, this message translates to:
  /// **'Surgical Risk Level'**
  String get preop_mortality_surgery_risk_label;

  /// Low risk surgery
  ///
  /// In en, this message translates to:
  /// **'Low risk (<1%)'**
  String get preop_mortality_surgery_low;

  /// Low risk surgery description
  ///
  /// In en, this message translates to:
  /// **'Endoscopic surgery, skin excision'**
  String get preop_mortality_surgery_low_desc;

  /// Intermediate risk surgery
  ///
  /// In en, this message translates to:
  /// **'Intermediate risk (1-5%)'**
  String get preop_mortality_surgery_intermediate;

  /// Intermediate risk surgery description
  ///
  /// In en, this message translates to:
  /// **'Abdominal, thoracic, orthopedic surgery'**
  String get preop_mortality_surgery_intermediate_desc;

  /// High risk surgery
  ///
  /// In en, this message translates to:
  /// **'High risk (>5%)'**
  String get preop_mortality_surgery_high;

  /// High risk surgery description
  ///
  /// In en, this message translates to:
  /// **'Major vascular surgery, major emergency'**
  String get preop_mortality_surgery_high_desc;

  /// Emergency surgery label
  ///
  /// In en, this message translates to:
  /// **'Emergency surgery'**
  String get preop_mortality_emergency;

  /// Emergency surgery description
  ///
  /// In en, this message translates to:
  /// **'Surgery within 24 hours'**
  String get preop_mortality_emergency_desc;

  /// Comorbidities section title
  ///
  /// In en, this message translates to:
  /// **'Comorbidities'**
  String get preop_mortality_comorbidities;

  /// Cardiac risk factors
  ///
  /// In en, this message translates to:
  /// **'Cardiac risk factors'**
  String get preop_mortality_cardiac;

  /// Cardiac risk factors description
  ///
  /// In en, this message translates to:
  /// **'Coronary disease, heart failure, valve disease'**
  String get preop_mortality_cardiac_desc;

  /// Pulmonary disease
  ///
  /// In en, this message translates to:
  /// **'Pulmonary disease'**
  String get preop_mortality_pulmonary;

  /// Pulmonary disease description
  ///
  /// In en, this message translates to:
  /// **'COPD, asthma, interstitial lung disease'**
  String get preop_mortality_pulmonary_desc;

  /// Renal disease
  ///
  /// In en, this message translates to:
  /// **'Renal disease'**
  String get preop_mortality_renal;

  /// Renal disease description
  ///
  /// In en, this message translates to:
  /// **'Chronic kidney disease, dialysis'**
  String get preop_mortality_renal_desc;

  /// Hepatic disease
  ///
  /// In en, this message translates to:
  /// **'Hepatic disease'**
  String get preop_mortality_hepatic;

  /// Hepatic disease description
  ///
  /// In en, this message translates to:
  /// **'Cirrhosis, hepatitis, liver failure'**
  String get preop_mortality_hepatic_desc;

  /// Neurologic disease
  ///
  /// In en, this message translates to:
  /// **'Neurologic disease'**
  String get preop_mortality_neurologic;

  /// Neurologic disease description
  ///
  /// In en, this message translates to:
  /// **'Stroke, dementia, seizures'**
  String get preop_mortality_neurologic_desc;

  /// Diabetes mellitus
  ///
  /// In en, this message translates to:
  /// **'Diabetes mellitus'**
  String get preop_mortality_diabetes;

  /// Diabetes description
  ///
  /// In en, this message translates to:
  /// **'Controlled or uncontrolled'**
  String get preop_mortality_diabetes_desc;

  /// Immunosuppression
  ///
  /// In en, this message translates to:
  /// **'Immunosuppression'**
  String get preop_mortality_immunosuppression;

  /// Immunosuppression description
  ///
  /// In en, this message translates to:
  /// **'Corticosteroids, chemotherapy, HIV'**
  String get preop_mortality_immunosuppression_desc;

  /// Risk stratification title
  ///
  /// In en, this message translates to:
  /// **'Risk Stratification'**
  String get preop_mortality_risk_stratification;

  /// Safe surgery action
  ///
  /// In en, this message translates to:
  /// **'Safe surgery'**
  String get preop_mortality_action_safe;

  /// Standard preparation action
  ///
  /// In en, this message translates to:
  /// **'Standard preparation'**
  String get preop_mortality_action_standard;

  /// Optimize preoperatively action
  ///
  /// In en, this message translates to:
  /// **'Optimize preoperatively'**
  String get preop_mortality_action_optimize;

  /// Consider benefit/risk action
  ///
  /// In en, this message translates to:
  /// **'Consider benefit/risk'**
  String get preop_mortality_action_consider;

  /// Consider alternatives action
  ///
  /// In en, this message translates to:
  /// **'Consider alternatives'**
  String get preop_mortality_action_alternative;

  /// Clinical guidelines title
  ///
  /// In en, this message translates to:
  /// **'Clinical Guidelines'**
  String get preop_mortality_guidelines;

  /// Low risk guideline title
  ///
  /// In en, this message translates to:
  /// **'Low risk (<5%)'**
  String get preop_mortality_guideline_low_title;

  /// Low risk guideline 1
  ///
  /// In en, this message translates to:
  /// **'Standard surgical preparation'**
  String get preop_mortality_guideline_low_1;

  /// Low risk guideline 2
  ///
  /// In en, this message translates to:
  /// **'No special optimization needed'**
  String get preop_mortality_guideline_low_2;

  /// Low risk guideline 3
  ///
  /// In en, this message translates to:
  /// **'Standard postoperative monitoring'**
  String get preop_mortality_guideline_low_3;

  /// Low risk guideline 4
  ///
  /// In en, this message translates to:
  /// **'Explain risks to patient'**
  String get preop_mortality_guideline_low_4;

  /// Moderate risk guideline title
  ///
  /// In en, this message translates to:
  /// **'Moderate risk (5-15%)'**
  String get preop_mortality_guideline_moderate_title;

  /// Moderate risk guideline 1
  ///
  /// In en, this message translates to:
  /// **'Optimize preoperative condition'**
  String get preop_mortality_guideline_moderate_1;

  /// Moderate risk guideline 2
  ///
  /// In en, this message translates to:
  /// **'Specialist consultation if needed'**
  String get preop_mortality_guideline_moderate_2;

  /// Moderate risk guideline 3
  ///
  /// In en, this message translates to:
  /// **'Consider ICU postoperatively'**
  String get preop_mortality_guideline_moderate_3;

  /// Moderate risk guideline 4
  ///
  /// In en, this message translates to:
  /// **'Detailed family counseling'**
  String get preop_mortality_guideline_moderate_4;

  /// High risk guideline title
  ///
  /// In en, this message translates to:
  /// **'High risk (>15%)'**
  String get preop_mortality_guideline_high_title;

  /// High risk guideline 1
  ///
  /// In en, this message translates to:
  /// **'Multidisciplinary consultation'**
  String get preop_mortality_guideline_high_1;

  /// High risk guideline 2
  ///
  /// In en, this message translates to:
  /// **'Consider less invasive options'**
  String get preop_mortality_guideline_high_2;

  /// High risk guideline 3
  ///
  /// In en, this message translates to:
  /// **'Prepare ICU and intensive support'**
  String get preop_mortality_guideline_high_3;

  /// High risk guideline 4
  ///
  /// In en, this message translates to:
  /// **'Thorough risk counseling'**
  String get preop_mortality_guideline_high_4;

  /// Clinical information title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get preop_mortality_clinical_info;

  /// Clinical information text
  ///
  /// In en, this message translates to:
  /// **'30-day surgical mortality risk prediction\n\nRisk factors:\n• Age: >80 years increases risk significantly\n• ASA: Health status classification\n• Surgery type: Invasiveness level\n• Emergency nature\n• Comorbidities\n\nSurgical classification:\n• Low risk: Endoscopic, dermatologic\n• Intermediate risk: Abdominal, thoracic\n• High risk: Vascular, major emergency\n\nClinical applications:\n• Patient and family counseling\n• Treatment decision making\n• Postoperative preparation\n• Resource allocation\n\nLimitations:\n• Predictive only\n• Requires clinical assessment\n• Changes over time\n• Does not replace physician experience'**
  String get preop_mortality_clinical_text;

  /// Reference title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get preop_mortality_reference_title;

  /// Reference text
  ///
  /// In en, this message translates to:
  /// **'Bilimoria KY, Liu Y, Paruch JL, et al. Development and evaluation of the universal ACS NSQIP surgical risk calculator: a decision aid and informed consent tool for patients and surgeons. J Am Coll Surg. 2013;217(5):833-42.'**
  String get preop_mortality_reference_text;

  /// MDRD GFR page title
  ///
  /// In en, this message translates to:
  /// **'MDRD GFR Calculator'**
  String get mdrd_gfr_title;

  /// MDRD GFR result label
  ///
  /// In en, this message translates to:
  /// **'MDRD GFR'**
  String get mdrd_gfr_result;

  /// MDRD GFR unit
  ///
  /// In en, this message translates to:
  /// **'ml/min/1.73m²'**
  String get mdrd_gfr_unit;

  /// Input prompt for MDRD GFR
  ///
  /// In en, this message translates to:
  /// **'Enter parameters to calculate GFR'**
  String get mdrd_gfr_input_prompt;

  /// Input section title
  ///
  /// In en, this message translates to:
  /// **'Input Parameters (MDRD)'**
  String get mdrd_gfr_input_title;

  /// Age input label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get mdrd_gfr_age;

  /// Age unit
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get mdrd_gfr_age_unit;

  /// Creatinine input label
  ///
  /// In en, this message translates to:
  /// **'Serum Creatinine'**
  String get mdrd_gfr_creatinine;

  /// Creatinine example
  ///
  /// In en, this message translates to:
  /// **'e.g., 1.2 mg/dL (106 umol/L)'**
  String get mdrd_gfr_creatinine_example;

  /// Demographics section title
  ///
  /// In en, this message translates to:
  /// **'Demographics'**
  String get mdrd_gfr_demographics;

  /// Female option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get mdrd_gfr_female;

  /// Female adjustment factor
  ///
  /// In en, this message translates to:
  /// **'Adjustment factor: ×0.742'**
  String get mdrd_gfr_female_factor;

  /// African American option
  ///
  /// In en, this message translates to:
  /// **'African American'**
  String get mdrd_gfr_african_american;

  /// African American adjustment factor
  ///
  /// In en, this message translates to:
  /// **'Adjustment factor: ×1.212'**
  String get mdrd_gfr_african_american_factor;

  /// Normal kidney function
  ///
  /// In en, this message translates to:
  /// **'Normal/High'**
  String get mdrd_gfr_function_normal;

  /// Mild kidney function decrease
  ///
  /// In en, this message translates to:
  /// **'Mildly decreased'**
  String get mdrd_gfr_function_mild;

  /// Mild-moderate kidney function decrease
  ///
  /// In en, this message translates to:
  /// **'Mild-moderate decrease'**
  String get mdrd_gfr_function_mild_moderate;

  /// Moderate-severe kidney function decrease
  ///
  /// In en, this message translates to:
  /// **'Moderate-severe decrease'**
  String get mdrd_gfr_function_moderate_severe;

  /// Severe kidney function decrease
  ///
  /// In en, this message translates to:
  /// **'Severely decreased'**
  String get mdrd_gfr_function_severe;

  /// End-stage renal disease
  ///
  /// In en, this message translates to:
  /// **'End-stage renal disease'**
  String get mdrd_gfr_function_esrd;

  /// CKD Stage 1
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 1 (if kidney damage present)'**
  String get mdrd_gfr_stage_1;

  /// CKD Stage 2
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 2'**
  String get mdrd_gfr_stage_2;

  /// CKD Stage 3a
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 3a'**
  String get mdrd_gfr_stage_3a;

  /// CKD Stage 3b
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 3b'**
  String get mdrd_gfr_stage_3b;

  /// CKD Stage 4
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 4'**
  String get mdrd_gfr_stage_4;

  /// CKD Stage 5
  ///
  /// In en, this message translates to:
  /// **'CKD Stage 5'**
  String get mdrd_gfr_stage_5;

  /// Clinical action label
  ///
  /// In en, this message translates to:
  /// **'Clinical Action'**
  String get mdrd_gfr_clinical_action;

  /// Normal monitoring action
  ///
  /// In en, this message translates to:
  /// **'Normal monitoring if no kidney damage'**
  String get mdrd_gfr_action_normal;

  /// Mild decrease action
  ///
  /// In en, this message translates to:
  /// **'Screen for CKD complications, control risk factors'**
  String get mdrd_gfr_action_mild;

  /// Mild-moderate decrease action
  ///
  /// In en, this message translates to:
  /// **'Evaluate and treat CKD complications'**
  String get mdrd_gfr_action_mild_moderate;

  /// Moderate-severe decrease action
  ///
  /// In en, this message translates to:
  /// **'Prepare for renal replacement therapy'**
  String get mdrd_gfr_action_moderate_severe;

  /// Severe decrease action
  ///
  /// In en, this message translates to:
  /// **'Initiate renal replacement therapy'**
  String get mdrd_gfr_action_severe;

  /// ESRD action
  ///
  /// In en, this message translates to:
  /// **'Urgent dialysis or kidney transplant'**
  String get mdrd_gfr_action_esrd;

  /// Drug dosing label
  ///
  /// In en, this message translates to:
  /// **'Drug Dosing Adjustment'**
  String get mdrd_gfr_drug_dosing;

  /// Normal dosing
  ///
  /// In en, this message translates to:
  /// **'Normal dose for most medications'**
  String get mdrd_gfr_dosing_normal;

  /// Reduce dose 25-50%
  ///
  /// In en, this message translates to:
  /// **'Reduce renally-excreted drugs by 25-50%'**
  String get mdrd_gfr_dosing_reduce_25_50;

  /// Reduce dose 50-75%
  ///
  /// In en, this message translates to:
  /// **'Reduce renally-excreted drugs by 50-75%'**
  String get mdrd_gfr_dosing_reduce_50_75;

  /// Avoid nephrotoxic drugs
  ///
  /// In en, this message translates to:
  /// **'Avoid nephrotoxic drugs, strict dose adjustment'**
  String get mdrd_gfr_dosing_avoid;

  /// Comparison section title
  ///
  /// In en, this message translates to:
  /// **'Comparison with Other Methods'**
  String get mdrd_gfr_comparison_title;

  /// Cockcroft-Gault method
  ///
  /// In en, this message translates to:
  /// **'Cockcroft-Gault'**
  String get mdrd_gfr_cockcroft_gault;

  /// Estimated unit
  ///
  /// In en, this message translates to:
  /// **'ml/min (estimated)'**
  String get mdrd_gfr_estimated_unit;

  /// Weight estimation note
  ///
  /// In en, this message translates to:
  /// **'Note: Cockcroft-Gault estimated with 70kg weight'**
  String get mdrd_gfr_weight_note;

  /// Reference values title
  ///
  /// In en, this message translates to:
  /// **'Kidney Function Classification (GFR)'**
  String get mdrd_gfr_reference_values;

  /// GFR range ≥90
  ///
  /// In en, this message translates to:
  /// **'≥ 90'**
  String get mdrd_gfr_range_90_plus;

  /// GFR range 60-89
  ///
  /// In en, this message translates to:
  /// **'60-89'**
  String get mdrd_gfr_range_60_89;

  /// GFR range 45-59
  ///
  /// In en, this message translates to:
  /// **'45-59'**
  String get mdrd_gfr_range_45_59;

  /// GFR range 30-44
  ///
  /// In en, this message translates to:
  /// **'30-44'**
  String get mdrd_gfr_range_30_44;

  /// GFR range 15-29
  ///
  /// In en, this message translates to:
  /// **'15-29'**
  String get mdrd_gfr_range_15_29;

  /// GFR range <15
  ///
  /// In en, this message translates to:
  /// **'< 15'**
  String get mdrd_gfr_range_under_15;

  /// Clinical info title
  ///
  /// In en, this message translates to:
  /// **'Clinical Information'**
  String get mdrd_gfr_clinical_info;

  /// Clinical information text
  ///
  /// In en, this message translates to:
  /// **'MDRD (Modification of Diet in Renal Disease) Equation:\nGFR = 175 × (SCr)^-1.154 × (Age)^-0.203 × (0.742 if female) × (1.212 if African American)\n\nAdvantages of MDRD:\n• Standardized to body surface area (1.73 m²)\n• More accurate than Cockcroft-Gault at low GFR\n• Recommended by international guidelines\n• Suitable for CKD staging\n\nLimitations:\n• Less accurate at GFR >60 ml/min/1.73m²\n• Not suitable for children <18 years\n• Poor estimation in very thin or obese patients\n• Use with caution in acute illness\n\nNote: CKD-EPI equation (2009, 2021) is now preferred over MDRD'**
  String get mdrd_gfr_clinical_text;

  /// Reference title
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get mdrd_gfr_reference_title;

  /// Reference text
  ///
  /// In en, this message translates to:
  /// **'Levey AS, Bosch JP, Lewis JB, et al. A more accurate method to estimate glomerular filtration rate from serum creatinine: a new prediction equation. Modification of Diet in Renal Disease Study Group. Ann Intern Med. 1999;130(6):461-70.'**
  String get mdrd_gfr_reference_text;

  /// Medical disclaimer professional title
  ///
  /// In en, this message translates to:
  /// **'FOR HEALTHCARE PROFESSIONALS ONLY'**
  String get medical_disclaimer_professional_only;

  /// Home page medical disclaimer
  ///
  /// In en, this message translates to:
  /// **'This application is intended exclusively for licensed healthcare professionals. All medical information is provided for reference purposes only and should not replace clinical judgment, institutional protocols, or direct patient care.'**
  String get medical_disclaimer_home_text;

  /// GRACE score medical disclaimer
  ///
  /// In en, this message translates to:
  /// **'Clinical decision support tool. Always use clinical judgment and follow institutional protocols.'**
  String get medical_disclaimer_grace_text;

  /// SOFA score medical disclaimer
  ///
  /// In en, this message translates to:
  /// **'ICU assessment tool. Requires clinical correlation with patient status.'**
  String get medical_disclaimer_sofa_text;

  /// qSOFA score medical disclaimer
  ///
  /// In en, this message translates to:
  /// **'Sepsis screening tool. Does not replace clinical assessment and laboratory evaluation.'**
  String get medical_disclaimer_qsofa_text;

  /// NIHSS score medical disclaimer
  ///
  /// In en, this message translates to:
  /// **'Stroke assessment tool. Requires neurological examination and clinical correlation.'**
  String get medical_disclaimer_nihss_text;

  /// MDRD GFR medical disclaimer
  ///
  /// In en, this message translates to:
  /// **'Kidney function estimation. Consider clinical context and confirm with additional tests.'**
  String get medical_disclaimer_mdrd_text;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
