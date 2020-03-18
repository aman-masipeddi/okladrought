class Station{
  String STID;
  String STNAME;

  Station(this.STID,this.STNAME);

  static List<Station> getStations() {
    return <Station>[
      Station('GOOD', 'Goodwall'),
      Station('STIL','Stillwater'),
      Station('SF','San Francisco'),
      Station('CRY','Cary')
    ];
  }
}