class DateFormater {

  String changeDateFormat(DateTime date) {
    String formatedDate = '';



    formatedDate = "${date.month}-${date.day}-${date.year}";
    return formatedDate;
  }
}