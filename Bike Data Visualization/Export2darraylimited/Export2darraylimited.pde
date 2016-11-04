int[][] matrix;
Table allRidesTable;

PrintWriter output; 

void makeMatrix(){
  matrix = new int[11][11];
  for (int i=0; i<11; i++){
    for (int j=0; j<11; j++){
      matrix[i][j] = 0;
    }
  }
  //Now our matrix is set up, but it's all zero. Now we need to fill it with values.
  allRidesTable = loadTable("HealthyRide Rentals 2016 Q3.csv", "header");
  //Trip iD,Starttime,Stoptime,Bikeid,Tipduration,From station id, From station name,To station id,To station name, Usertype
  int totalRides = allRidesTable.getRowCount();
  for (int row=0; row < totalRides; row++){
    TableRow thisRow = allRidesTable.getRow(row);
    int startStationID = thisRow.getInt("From station id");
    int endStationID = thisRow.getInt("To station id");
    println("Start ID = " + startStationID + ", End ID = " + endStationID);
    //We only want to map the 10 busiest stations, which are:
    //1000, 1001, 1010, 1012, 1013, 1016, 1017, 1045, 1048, 1049
    int startStationNumber= 10;
    int endStationNumber = 10;
    if (startStationID==1000) startStationNumber = 0;
    if (startStationID==1001) startStationNumber = 1;
    if (startStationID==1010) startStationNumber = 2;
    if (startStationID==1012) startStationNumber = 3;
    if (startStationID==1013) startStationNumber = 4;
    if (startStationID==1016) startStationNumber = 5;
    if (startStationID==1017) startStationNumber = 6;
    if (startStationID==1045) startStationNumber = 7;
    if (startStationID==1048) startStationNumber = 8;
    if (startStationID==1049) startStationNumber = 9;
    if (endStationID==1000) endStationNumber = 0;
    if (endStationID==1001) endStationNumber = 1;
    if (endStationID==1010) endStationNumber = 2;
    if (endStationID==1012) endStationNumber = 3;
    if (endStationID==1013) endStationNumber = 4;
    if (endStationID==1016) endStationNumber = 5;
    if (endStationID==1017) endStationNumber = 6;
    if (endStationID==1045) endStationNumber = 7;
    if (endStationID==1048) endStationNumber = 8;
    if (endStationID==1049) endStationNumber = 9;
    //println("Start Number = " + startStationNumber + ", End Number = " + endStationNumber);
    if (startStationNumber == endStationNumber){
      matrix[startStationNumber][endStationNumber] += 1;
    } else {
      //I will treat trips from station A->B and B->A as the same.
      //Direction does not matter for this data visualization.
      //So, the matrix will be symmetric.
      matrix[startStationNumber][endStationNumber] += 1;
      matrix[endStationNumber][startStationNumber] += 1;
    }
  }
  //Now the matrix is full of the number of rides from place to place.
}

void setup() {
  makeMatrix();
  output = createWriter("myMatrix.txt"); 
  int nRows = matrix.length; 
  int nCols = nRows;

  output.println("["); 
  for (int row = 0; row < nRows; row++) {
    String aRowString = "[";
    for (int col = 0; col< nCols; col++) {
      aRowString += matrix[row][col];
      if (col != (nCols -1)){
        aRowString += ", ";
      }
    }
    aRowString += "]";
    if (row != (nRows -1)) {
      aRowString += ", ";
    }
    output.println(aRowString); 
  }
  output.println("];"); 
  

  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
}