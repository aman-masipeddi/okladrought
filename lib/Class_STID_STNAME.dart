class Station{
  String STID;
  String STNAME;

  Station(this.STID,this.STNAME);

  static List<Station> getStations() {
    return <Station>[
      Station('good', 'Goodwall'),
      Station('stil','Stillwater'),
      Station('wood','Woodward'),
      Station('laho','Lahoma'),
      Station('elre','El Reno'),
      Station('chic','Chickasha'),
      Station('SF','San Francisco'),
      Station('CRY','Cary')
    ];
  }
}