int[][] matrix;
Table allRidesTable;

PrintWriter output; 

void makeMatrix(){
  matrix = new int[53][53];
  for (int i=0; i<53; i++){
    for (int j=0; j<53; j++){
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
    //Note that the station IDs range from 1000 to 1051, inclusive
    int startStationNumber = startStationID - 1000;
    int endStationNumber = endStationID - 1000;
    if (startStationNumber < 0 || startStationNumber > 51){
      //The Start Station number was invalid, and all invalid Stations will be called 52.
      startStationNumber = 52;
    }
    if (endStationNumber < 0 || endStationNumber > 51){
      //The End Station number was invalid, and all invalid Stations will be called 52.
      endStationNumber = 52;
    }
    println("Start Number = " + startStationNumber + ", End Number = " + endStationNumber);
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