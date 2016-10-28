//GIVEN THE GENERAL FORM OF A CHORD, THE KEY, AND THE NOTE'S POSITION, RETURNS THE NOTE
int chordToNote(int chord, int mKey, int position) {
  int x = mKey;
  if (chord==MAJOR_FIRST) {
    //x remains the base note of the key
    if (position == 0) x = x+0; //do nothing
    if (position == 1) x = x+2; //up a whole step
    if (position == 2) x = x+4; //up two whole steps
    if (position == 3) x = x+5; //up two and a half steps
    if (position == 4) x = x+7; //up three and a half steps
    if (position == 5) x = x+9; //up four and a half whole steps
    if (position == 6) x = x+11; //up five and a half whole steps
  } else if (chord==MINOR_SECOND) {
    x += 2;
    //x goes up a whole step if this is the minor 2nd
    if (position == 0) x = x+0; //do nothing
    if (position == 1) x = x+2; //up a whole step
    if (position == 2) x = x+3; //up a whole and a half step
    if (position == 3) x = x+5; //up two and a half steps
    if (position == 4) x = x+7; //up three and a half steps
    if (position == 5) x = x+8; //up four whole steps
    if (position == 6) x = x+10; //up five whole steps
  } else if (chord==MAJOR_FOURTH) {
    x += 5;
    //x goes up two and a half steps if this is the major fourth
    if (position == 0) x = x+0; //do nothing
    if (position == 1) x = x+2; //up a whole step
    if (position == 2) x = x+4; //up two whole steps
    if (position == 3) x = x+5; //up two and a half steps
    if (position == 4) x = x+7; //up three and a half steps
    if (position == 5) x = x+9; //up four and a half whole steps
    if (position == 6) x = x+11; //up five and a half whole steps
  } else if (chord==MAJOR_FIFTH) {
    x += 7;
    //x goes up three and a half steps if this the major fifth
    if (position == 0) x = x+0; //do nothing
    if (position == 1) x = x+2; //up a whole step
    if (position == 2) x = x+4; //up two whole steps
    if (position == 3) x = x+5; //up two and a half steps
    if (position == 4) x = x+7; //up three and a half steps
    if (position == 5) x = x+9; //up four and a half whole steps
    if (position == 6) x = x+11; //up five and a half whole steps
  } else {
    //chord == MINOR_SIXTH
    x += 11;
    //x goes up five and a half steps if this is the minor 6th
    if (position == 0) x = x+0; //do nothing
    if (position == 1) x = x+2; //up a whole step
    if (position == 2) x = x+3; //up a whole and a half step
    if (position == 3) x = x+5; //up two and a half steps
    if (position == 4) x = x+7; //up three and a half steps
    if (position == 5) x = x+8; //up four whole steps
    if (position == 6) x = x+10; //up five whole steps
  }
  return x;
}

//DETERMINES THE CHORD PROGRESSION THE SONG WILL FOLLOW
void setChordProgression(int test) {
  if (test == 0) {
    chordProgression[0] = MAJOR_FIRST;
    chordProgression[1] = MAJOR_FOURTH;
    chordProgression[2] = MAJOR_FIFTH;
    chordProgression[3] = MAJOR_FIFTH;
  }
  if (test == 1) {
    chordProgression[0] = MAJOR_FIRST;
    chordProgression[1] = MINOR_SIXTH;
    chordProgression[2] = MINOR_SECOND;
    chordProgression[3] = MAJOR_FIFTH;
  }
  if (test == 2) {
    chordProgression[0] = MAJOR_FIRST;
    chordProgression[1] = MAJOR_FIFTH;
    chordProgression[2] = MINOR_SIXTH;
    chordProgression[3] = MAJOR_FOURTH;
  }
  if (test == 3) {
    chordProgression[0] = MAJOR_FIRST;
    chordProgression[1] = MINOR_SIXTH;
    chordProgression[2] = MAJOR_FOURTH;
    chordProgression[3] = MAJOR_FIFTH;
  }
  if (test == 4) {
    chordProgression[0] = MAJOR_FIRST;
    chordProgression[1] = MINOR_SECOND;
    chordProgression[2] = MAJOR_FIFTH;
    chordProgression[3] = MAJOR_FIFTH;
  }
  if (test == 5) {
    chordProgression[0] = MAJOR_FIRST;
    chordProgression[1] = MINOR_SECOND;
    chordProgression[2] = MAJOR_FOURTH;
    chordProgression[3] = MAJOR_FIFTH;
  }
}

class chord {
  int note1;
  int note2;
  int note3;
  public chord(int a, int b, int c) {
    note1 = a;
    note2 = b;
    note3 = c;
  }
}