class ShowAttendanceControlListRequest {
  String _subjectID;
  String _parallelID;
  String _imageBase64;

  ShowAttendanceControlListRequest(this._subjectID, this._parallelID, this._imageBase64);

  String get subjectID => _subjectID;
  String get parallelID => _parallelID;
  String get imageBase64 => _imageBase64;
}