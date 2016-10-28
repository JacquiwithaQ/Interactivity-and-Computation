//GENERATES A MUSICAL PHRASE THAT IS FOUR LINES LONG
musicPhrase makeMainMusicPhrase(int mKey, int[] cp, int[] rhymeScheme, int timeSig, boolean isThisChorus) {
  int[][] chords = new int[4][7];
  for (int i=0; i<4; i++) {
    for (int j=0; j<4; j++) {
      chords[i][j] = chordToNote(cp[i], mKey, j);
    }
  }
  String[] fourChordNames = getChordName(mKey, cp);
  
  musicPhrase myPhrase = new musicPhrase(chords, timeSig, rhymeScheme, fourChordNames, isThisChorus);
  return myPhrase;
}

String[] getChordName(int mKey, int[] cp){
  String[] theseChords = new String[4];
  for (int j=0; j<4; j++){
    int chordNumber = cp[j];
    if (mKey == AFLAT_MAJOR){
      if (chordNumber == MAJOR_FIRST) theseChords[j] = "A♭";
      if (chordNumber == MINOR_SECOND) theseChords[j] = "B♭m";
      if (chordNumber == MAJOR_FOURTH) theseChords[j] = "D♭";
      if (chordNumber == MAJOR_FIFTH) theseChords[j] = "E♭";
      if (chordNumber == MINOR_SIXTH) theseChords[j] = "Fm";
    }
    if (mKey == EFLAT_MAJOR){
      if (chordNumber == MAJOR_FIRST) theseChords[j] = "E♭";
      if (chordNumber == MINOR_SECOND) theseChords[j] = "Fm";
      if (chordNumber == MAJOR_FOURTH) theseChords[j] = "A♭";
      if (chordNumber == MAJOR_FIFTH) theseChords[j] = "B♭";
      if (chordNumber == MINOR_SIXTH) theseChords[j] = "Cm";
    }
    if (mKey == BFLAT_MAJOR){
      if (chordNumber == MAJOR_FIRST) theseChords[j] = "B♭";
      if (chordNumber == MINOR_SECOND) theseChords[j] = "Cm";
      if (chordNumber == MAJOR_FOURTH) theseChords[j] = "E♭";
      if (chordNumber == MAJOR_FIFTH) theseChords[j] = "F";
      if (chordNumber == MINOR_SIXTH) theseChords[j] = "Gm";
    }
    if (mKey == F_MAJOR){
      if (chordNumber == MAJOR_FIRST) theseChords[j] = "F";
      if (chordNumber == MINOR_SECOND) theseChords[j] = "Gm";
      if (chordNumber == MAJOR_FOURTH) theseChords[j] = "B♭";
      if (chordNumber == MAJOR_FIFTH) theseChords[j] = "C";
      if (chordNumber == MINOR_SIXTH) theseChords[j] = "Dm";
    }
    if (mKey == C_MAJOR){
      if (chordNumber == MAJOR_FIRST) theseChords[j] = "C";
      if (chordNumber == MINOR_SECOND) theseChords[j] = "Dm";
      if (chordNumber == MAJOR_FOURTH) theseChords[j] = "F";
      if (chordNumber == MAJOR_FIFTH) theseChords[j] = "G";
      if (chordNumber == MINOR_SIXTH) theseChords[j] = "Am";
    }
    if (mKey == G_MAJOR){
      if (chordNumber == MAJOR_FIRST) theseChords[j] = "G";
      if (chordNumber == MINOR_SECOND) theseChords[j] = "Am";
      if (chordNumber == MAJOR_FOURTH) theseChords[j] = "C";
      if (chordNumber == MAJOR_FIFTH) theseChords[j] = "D";
      if (chordNumber == MINOR_SIXTH) theseChords[j] = "Em";
    }
    if (mKey == D_MAJOR){
      if (chordNumber == MAJOR_FIRST) theseChords[j] = "D";
      if (chordNumber == MINOR_SECOND) theseChords[j] = "Em";
      if (chordNumber == MAJOR_FOURTH) theseChords[j] = "G";
      if (chordNumber == MAJOR_FIFTH) theseChords[j] = "A";
      if (chordNumber == MINOR_SIXTH) theseChords[j] = "Bm";
    }
  }
  return theseChords;
}

//A SET OF FOUR MUSIC LINES (RHYTHM AND PITCH)
class musicPhrase {
  ArrayList<pitchLine> allPitchLines;
  int[][] specificChordProgression;
  String[] allFourChords;
  public musicPhrase(int[][]chords, int timeSignature, int[] rhymeScheme, 
                     String[] chordNames, boolean isThisTheChorus) {
    allPitchLines = new ArrayList<pitchLine>();
    allFourChords = chordNames;
    int measuresPerPhrase = int(random(3, 4));
    rhythmLine rhythm1 = new rhythmLine(measuresPerPhrase*4);
    rhythmLine rhythm2 = new rhythmLine(measuresPerPhrase*4);
    rhythmLine rhythm3 = new rhythmLine(measuresPerPhrase*4);
    pitchLine pitch1 = new pitchLine(rhythm1, chords[0], false);
    pitchLine pitch2;
    if (rhymeScheme[1]==1) {
      pitch2 = new pitchLine(rhythm1, chords[1], false);
    } else {
      //rhymeScheme[1] == 2
      pitch2 = new pitchLine(rhythm2, chords[1], false);
    }
    pitchLine pitch3;
    if (rhymeScheme[2]==1) {
      pitch3 = new pitchLine(rhythm1, chords[2], false);
    } else if (rhymeScheme[2]==2) {
      pitch3 = new pitchLine(rhythm2, chords[2], false);
    } else {
      //rhymeScheme[2] == 3
      pitch3 = new pitchLine(rhythm3, chords[2], false);
    }
    pitchLine pitch4;
    if (rhymeScheme[3]==1) {
      pitch4 = new pitchLine(rhythm1, chords[3], isThisTheChorus);
    } else if (rhymeScheme[3]==2) {
      pitch4 = new pitchLine(rhythm2, chords[3], isThisTheChorus);
    } else {
      //rhymeScheme[3] == 3
      pitch4 = new pitchLine(rhythm3, chords[3], isThisTheChorus);
    }
    //Now we have four pitch lines, each with a corresponding rhythm line
    this.allPitchLines.add(pitch1);
    this.allPitchLines.add(pitch2);
    this.allPitchLines.add(pitch3);
    this.allPitchLines.add(pitch4);
  }
}

//A SET OF NOTES THAT MATCH UP WITH AN ARRAY OF RHYTHMS
class pitchLine {
  int[] pitches; //-5-19 are all notes. Middle C is zero.
  chord myChord;
  rhythmLine myRhythm;
  public pitchLine(rhythmLine rhythm, int[] notes, boolean lastLine) {
    myChord = new chord(notes[0], notes[2], notes[4]);
    myRhythm = rhythm;
    pitches = new int[rhythm.howMany];
    int itemsChecked = 0;
    int times = rhythm.howMany;
    while (itemsChecked < times) {
        int pitch = notes[0];
        if (itemsChecked == 0) {
          pitch = notes[0];
        } else {
          //Possibly add more parameters here?
          int test = int(random(0, 7));
          pitch = notes[test];
        }
        if (myRhythm.types[itemsChecked]==0) pitch = INVALID_PITCH;
        pitches[itemsChecked]=pitch;
      itemsChecked ++;
    }
  }
}


//A LIST OF NOTE AND REST LENGTHS, NO PITCHES
class rhythmLine {
  float[] rhythm; //number is number of beats.
  int[] types; //0 is rest, 1 is note, 2 is long note
  int howMany;

  public rhythmLine(float howLong) {
    int counter = 0;
    float[] tempRhythm = new float[100];
    int[] tempTypes;
    tempTypes = new int[100];

    while (howLong > 0) {
      float test = int(random(1, 6.5));
      //Make sure it's not too long
      while (test/2 > howLong) {
        test = int(random(1, 6.5));
      }
      //println("test is " + test);
      if (counter < 100) {
        if((test>2)&&(test-2 < howLong)){
          tempRhythm[counter] = test-2;
          //println("This length is " + tempRhythm[counter]);
          howLong -= test-2;
        }
        else { 
          if (test == 5) test = 4; //Fixes a weird bug I sometimes had
          tempRhythm[counter] = test/2;
          howLong -= test/2;
          //println("This length is " + tempRhythm[counter]);
        }
      }

      if ((counter != 0)&&(test<4)&&(random(0,5)>4)&&(tempTypes[counter-1]!=0)) {
        tempTypes[counter] = 0;
      } else {
        if (test > 2) {
          tempTypes[counter] = 2;
        } else {
          tempTypes[counter] = 1;
        }
      }
      counter += 1;
    }
    //println("Counter is " + counter);
    this.howMany = counter;

    rhythm = new float[this.howMany];
    types = new int[this.howMany];
    for (int y=0; y<this.howMany; y++) {
      rhythm[y] = tempRhythm[y];
    }
    for (int x=0; x<this.howMany; x++) {
      types[x] = tempTypes[x];
    }
    types[this.howMany-1] = 1;
    //println("rhythm.length is " + rhythm.length);
  }
}