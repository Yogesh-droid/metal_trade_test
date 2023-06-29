import '../../data/models/profile_model.dart';

class ProfileEntity {
  final String? lastModifiedDate;
  final int? id;
  final String? mobileNumber;
  final Company? company;
  final String? status;
  final ProfileCompletion? profileCompletion;

  ProfileEntity(
      {this.lastModifiedDate,
      this.id,
      this.mobileNumber,
      this.company,
      this.status,
      this.profileCompletion});
}
