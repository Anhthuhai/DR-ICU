import '../../domain/entities/lab_test.dart';

class LabAnalysisRepositoryImpl {
  static final List<LabTest> _predefinedTests = [
    const LabTest(
      id: 'glucose',
      name: 'Glucose',
      unit: 'mg/dL',
      normalMin: 70,
      normalMax: 100,
      description: 'Blood glucose level',
      category: 'Metabolic',
    ),
    const LabTest(
      id: 'cholesterol',
      name: 'Total Cholesterol',
      unit: 'mg/dL',
      normalMin: 0,
      normalMax: 200,
      description: 'Total cholesterol level',
      category: 'Lipid',
    ),
    const LabTest(
      id: 'triglycerides',
      name: 'Triglycerides',
      unit: 'mg/dL',
      normalMin: 0,
      normalMax: 150,
      description: 'Triglycerides level',
      category: 'Lipid',
    ),
    const LabTest(
      id: 'bun',
      name: 'BUN',
      unit: 'mg/dL',
      normalMin: 7,
      normalMax: 20,
      description: 'Blood urea nitrogen',
      category: 'Kidney',
    ),
  ];

  static final List<LabTestEntry> _entries = [];

  List<LabTest> getAvailableTests() {
    return _predefinedTests;
  }

  List<LabTest> getAllAvailableTests() {
    return _predefinedTests;
  }

  List<LabTestEntry> getTestEntries(String testId) {
    return _entries.where((entry) => entry.testId == testId).toList();
  }

  void addTestEntry(LabTestEntry entry) {
    _entries.add(entry);
  }

  void removeTestEntry(String entryId) {
    _entries.removeWhere((entry) => entry.id == entryId);
  }

  LabTest? getTestById(String testId) {
    try {
      return _predefinedTests.firstWhere((test) => test.id == testId);
    } catch (e) {
      return null;
    }
  }
}
