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

  /// Creatinine Clearance list description
  ///
  /// In en, this message translates to:
  /// **'Kidney function assessment'**
  String get creatinine_clearance_list_description;

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
