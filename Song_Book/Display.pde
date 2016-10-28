void displayVerses(int firstRowStartingHeight, int spaceBetweenLines, 
                   ArrayList<totalPhrase> allVerses, int songNumber, String songTitle){
  int lineLength = 0;
  float measureCounter = 0;
  int middleCHeight = firstRowStartingHeight;
  float itemSpacing = 0;
  stroke(0);
  strokeWeight(1);
  fill(0);
  textFont(titleFont, 40);
  color(0);
  textAlign(CENTER);
  text(songTitle.toUpperCase(), (width/2)-45, 70);
  for (int lineCounter = 0; lineCounter<4; lineCounter++){
    middleCHeight = firstRowStartingHeight + (lineCounter*185);
    musicPhrase verseMusic = allVerses.get(0).music;
    float[] itemLengths = verseMusic.allPitchLines.get(lineCounter).myRhythm.rhythm;
    int[] itemTypes = verseMusic.allPitchLines.get(lineCounter).myRhythm.types;
    int[] itemPitches = verseMusic.allPitchLines.get(lineCounter).pitches;
    String[] itemText0 = allVerses.get(0).lyrics.get(lineCounter).syllables;
    String[] itemText1 = allVerses.get(1).lyrics.get(lineCounter).syllables;
    String[] itemText2 = allVerses.get(2).lyrics.get(lineCounter).syllables;
    lineLength = itemPitches.length;
    itemSpacing = (width-170)/(lineLength+1);
    measureCounter = 0;
    float xPos = 105;
    if (lineCounter == 0){
      fill(0);
      //MAKE A REVERSE REPEAT SIGN
      rect(100, middleCHeight-(5*spaceBetweenLines), 5, (4*spaceBetweenLines));
      strokeWeight(2);
      strokeCap(SQUARE);
      line(110, middleCHeight-(5*spaceBetweenLines), 110, middleCHeight-spaceBetweenLines);
      strokeWeight(1);
      ellipse(115, middleCHeight-(3.5*spaceBetweenLines), 2, 2);
      ellipse(115, middleCHeight-(2.5*spaceBetweenLines), 2, 2);
      textFont(lyricFont, 14);
      textAlign(LEFT);
      color(0);
      text("1. ", 112, middleCHeight+40);
      text("2. ", 112, middleCHeight+60);
      text("3. ", 112, middleCHeight+80);
      xPos = 145;
    }
    for (int x=0; x<lineLength; x++){
      if ((itemLengths[x]!=4)||(measureCounter!=0)) {
        displayVerseWord(xPos, middleCHeight, itemText0[x], itemText1[x], itemText2[x]); //Whole Notes are formatted a bit differently
      }
      //print("Item length is : " + itemLengths[x]);
      if (itemTypes[x]==0){
        //It's a rest. Its length will be 0.5 or 1
        if (itemLengths[x]==0.5){
          displayEighthRest(xPos, middleCHeight);
          measureCounter += 0.5;
          xPos += itemSpacing;
        } else {
          if (measureCounter>3){
            //We don't have room for a quarter rest
            displayEighthRest(xPos, middleCHeight);
            measureCounter = 0;
            xPos += itemSpacing/2;
            drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
            displayEighthRest(xPos, middleCHeight);
            xPos += itemSpacing/2;
            measureCounter += 0.5;
          } else {
            //Draw the quarter rest as usual
            displayQuarterRest(xPos, middleCHeight);
            measureCounter += 1;
            xPos += itemSpacing;
          }
        }
      } else {
        //Its a note
        if (itemLengths[x] == 4){
          if (measureCounter==0){
            //enough room for whole note
            xPos += (itemSpacing/2)+2.5;
            displayWholeNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            displayVerseWord(xPos-10, middleCHeight, itemText0[x], itemText1[x], itemText2[x]);
            measureCounter=0;
            xPos += (itemSpacing/2)+2.5;
            drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
          } else if (measureCounter==0.5){
              displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
              measureCounter += 0.5;
              xPos += itemSpacing/3;
              displayDottedHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter = 0;
              xPos += itemSpacing/3 +5 ;
              drawMeasureLine(xPos+5, middleCHeight, spaceBetweenLines);
              displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter += 0.5;
              xPos += itemSpacing/3;
            } else if (measureCounter == 1){
              displayDottedHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
              measureCounter = 0;
              xPos += itemSpacing/2 + 5;
              drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
              displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter += 1;
              xPos += itemSpacing/2;
            } else if (measureCounter == 1.5){
              displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
              measureCounter += 0.5;
              xPos += itemSpacing/3;
              displayHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter = 0;
              xPos += itemSpacing/3 +5;
              drawMeasureLine(xPos+5, middleCHeight, spaceBetweenLines);
              displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              fill(0);
              drawDot(xPos, middleCHeight, itemPitches[x], spaceBetweenLines); //DOTTED
              measureCounter += 1.5;
              xPos += itemSpacing/3;
            } else if (measureCounter == 2){
              displayHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
              measureCounter = 0;
              xPos += itemSpacing/2 +5;
              drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
              displayHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter += 2;
              xPos += itemSpacing/2;
            } else if (measureCounter == 2.5){
              displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
              fill(0);
              drawDot(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter = 0;
              xPos += itemSpacing/3 +5;
              drawMeasureLine(xPos+5, middleCHeight, spaceBetweenLines);
              displayHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter += 2;
              xPos += itemSpacing/3;
              displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter += 0.5;
              xPos += itemSpacing/3;
            } else if (measureCounter == 3){
              displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
              measureCounter = 0;
              xPos += itemSpacing/2 +5;
              drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
              displayDottedHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter += 3;
              xPos += itemSpacing/2;
            } else {
              displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
              measureCounter = 0;
              xPos += itemSpacing/3 +5;
              drawMeasureLine(xPos+5, middleCHeight, spaceBetweenLines);
              displayDottedHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter += 3;
              xPos += itemSpacing/3;
              displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
              measureCounter += 0.5;
              xPos += itemSpacing/3;
            }
        } else if (itemLengths[x] == 3){
           if (measureCounter <= 1){
            displayDottedHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            xPos += itemSpacing;
            measureCounter += 3;
          } else if (measureCounter == 1.5){
            displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
            measureCounter += 0.5;
            xPos += itemSpacing/3;
            displayHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter = 0;
            xPos += itemSpacing/3 +5;
            drawMeasureLine(xPos+5, middleCHeight, spaceBetweenLines);
            displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 0.5;
            xPos += itemSpacing/3;
          } else if (measureCounter == 2){
            displayHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
            measureCounter = 0;
            xPos += itemSpacing/2 +5;
            drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
            displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 1;
            xPos += itemSpacing/2;
          } else if (measureCounter == 2.5){
            displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
            drawDot(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter = 0;
            xPos += itemSpacing/2 +5;
            drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
            displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            drawDot(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 1.5;
             xPos += itemSpacing/2;
          } else if (measureCounter == 3){
            displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
            xPos += itemSpacing/2 +5;  
            measureCounter = 0;
            drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
            displayHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);  
            measureCounter += 2;
            xPos += itemSpacing/2;
          } else {
            displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
            measureCounter = 0;
            xPos += itemSpacing/3 +5;
            drawMeasureLine(xPos+5, middleCHeight, spaceBetweenLines);
            displayHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 2;
            xPos += itemSpacing/3;
            displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 0.5;
            xPos += itemSpacing/3;
          }
        } else if (itemLengths[x] == 2){
          if (measureCounter <= 2){
            displayHalfNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 2;
            xPos += itemSpacing;
          } else if (measureCounter == 2.5){
            displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines); //DOTTED
            drawDot(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
            measureCounter = 0;
            xPos += itemSpacing/2 +5;
            drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
            displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 0.5;
            xPos += itemSpacing/2;
          } else if (measureCounter == 3){
            displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
            measureCounter = 0;
            xPos += itemSpacing/2 +5;
            drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
            displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 1;
            xPos += itemSpacing/2;
          } else {
            displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
            measureCounter = 0;
            xPos += itemSpacing/2;
            drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
            displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines); //DOTTED
            drawDot(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 1.5;
            xPos += itemSpacing/2;
          }
        } else if (itemLengths[x] == 1){
          if (measureCounter <= 3){
            displayQuarterNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 1;
            xPos += itemSpacing;
          } else {
            displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            displayTie(xPos, middleCHeight, itemPitches[x], spaceBetweenLines, itemSpacing);
            measureCounter = 0;
            xPos += itemSpacing/2 +5;
            drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
            displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
            measureCounter += 0.5;
            xPos += itemSpacing/2;
          }
        } else {
          //It is am eighth note, and there is always room for an eighth note!
          displayEighthNote(xPos, middleCHeight, itemPitches[x], spaceBetweenLines);
          measureCounter += 0.5;
          xPos += itemSpacing;
        }
      }
      if ((measureCounter == 4)&&(x<lineLength - 1)){
        xPos += 5;
        drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
        measureCounter = 0;
      }
      //println("  Measure Count is now " + measureCounter);
    }
    xPos = 810;
    stroke(0);
    strokeWeight(1);
    image(trebleClef, 44, middleCHeight - (5*spaceBetweenLines));
    if(lineCounter==0){
      image(fourFourTime, 74, middleCHeight - (5*spaceBetweenLines));
      textFont(notationFont, 14);
      text(verseMusic.allFourChords[lineCounter], 100, middleCHeight - (6*spaceBetweenLines));
      String musicAdverb = lexicon.randomWord("rb");
      while (!musicAdverb.endsWith("ly")){
        musicAdverb = lexicon.randomWord("rb");
      }
      musicAdverb = musicAdverb.substring(0,1).toUpperCase() + musicAdverb.substring(1);
      text(musicAdverb, 130, middleCHeight - (6*spaceBetweenLines));
      
    } else {
      textFont(notationFont, 14);
      text(verseMusic.allFourChords[lineCounter], 60, middleCHeight - (6*spaceBetweenLines));
    }
    line(40, middleCHeight - (1*spaceBetweenLines), xPos-12, middleCHeight - (1*spaceBetweenLines));
    line(40, middleCHeight - (2*spaceBetweenLines), xPos-12, middleCHeight - (2*spaceBetweenLines));
    line(40, middleCHeight - (3*spaceBetweenLines), xPos-12, middleCHeight - (3*spaceBetweenLines));
    line(40, middleCHeight - (4*spaceBetweenLines), xPos-12, middleCHeight - (4*spaceBetweenLines));
    line(40, middleCHeight - (5*spaceBetweenLines), xPos-12, middleCHeight - (5*spaceBetweenLines));
    drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
    //println("Just finished with line " + lineCounter);
    //line(width-40, middleCHeight - (1*spaceBetweenLines), width-40, middleCHeight - (5*spaceBetweenLines)); 
  }
  textFont(lyricFont, 14);
  color(0);
  textAlign(CENTER);
  text(songNumber, (width/2)-45, height-25);
}




void displayEighthRest(float xPos, float yPos){
  image(eighthRest, xPos, yPos-40);
}
void displayQuarterRest(float xPos, float yPos){
  image(quarterRest, xPos, yPos-45);
}
void displayQuarterNote(float xPos, float yPos, int pitch, int spaceBetweenLines){
  float noteHeight = findNoteHeight(pitch, spaceBetweenLines);
  if (pitch>=10){
    if ((pitch%12==1)||(pitch%12==6)) image(sharp, xPos-7, yPos-13-noteHeight);
    if ((pitch%12==10)||(pitch%12==3)||(pitch%12==8)) image(flat, xPos-10, yPos-17-noteHeight);
    image(quarterNoteDown, xPos, yPos-5-noteHeight);
    if (pitch>=20) line(xPos-7, yPos-(6*spaceBetweenLines), xPos+20, yPos-(6*spaceBetweenLines));
  } else {
    if ((pitch%12==1)||(pitch%12==6)) image(sharp, xPos-7, yPos-13-noteHeight);
    if ((pitch%12==10)||(pitch%12==3)||(pitch%12==8)) image(flat, xPos-10, yPos-17-noteHeight);
    image(quarterNoteUp, xPos, yPos-35-noteHeight);
    if (pitch<=1) line(xPos-7, yPos, xPos+20, yPos);
    if (pitch<=-3) line(xPos-7, yPos+(spaceBetweenLines), xPos+20, yPos+(spaceBetweenLines));
  }
}

void displayHalfNote(float xPos, float yPos, int pitch, int spaceBetweenLines){
  float noteHeight = findNoteHeight(pitch, spaceBetweenLines);
  if (pitch>=10){
    if ((pitch%12==1)||(pitch%12==6)) image(sharp, xPos-7, yPos-13-noteHeight);
    if ((pitch%12==10)||(pitch%12==3)||(pitch%12==8)) image(flat, xPos-10, yPos-17-noteHeight);
    image(halfNoteDown, xPos, yPos-5-noteHeight);
    if (pitch>=20) line(xPos-7, yPos-(6*spaceBetweenLines), xPos+20, yPos-(6*spaceBetweenLines));
  } else {
    if ((pitch%12==1)||(pitch%12==6)) image(sharp, xPos-7, yPos-13-noteHeight);
    if ((pitch%12==10)||(pitch%12==3)||(pitch%12==8)) image(flat, xPos-10, yPos-17-noteHeight);
    image(halfNoteUp, xPos, yPos-35-noteHeight);
    if (pitch<=1) line(xPos-7, yPos, xPos+20, yPos);
    if (pitch<=-3) line(xPos-7, yPos+(spaceBetweenLines), xPos+20, yPos+(spaceBetweenLines));
  }
}

void displayDottedHalfNote(float xPos, float yPos, int pitch, int spaceBetweenLines){
  float noteHeight = findNoteHeight(pitch, spaceBetweenLines);
  if (pitch>=10){
    if ((pitch%12==1)||(pitch%12==6)) image(sharp, xPos-7, yPos-13-noteHeight);
    if ((pitch%12==10)||(pitch%12==3)||(pitch%12==8)) image(flat, xPos-10, yPos-17-noteHeight);
    image(dottedHalfNoteDown, xPos, yPos-5-noteHeight);
    if (pitch>=20) line(xPos-7, yPos-(6*spaceBetweenLines), xPos+20, yPos-(6*spaceBetweenLines));
  } else {
    if ((pitch%12==1)||(pitch%12==6)) image(sharp, xPos-7, yPos-13-noteHeight);
    if ((pitch%12==10)||(pitch%12==3)||(pitch%12==8)) image(flat, xPos-10, yPos-17-noteHeight);
    image(dottedHalfNoteUp, xPos, yPos-31-noteHeight);
    if (pitch<=1) line(xPos-7, yPos, xPos+20, yPos);
    if (pitch<=-3) line(xPos-7, yPos+(spaceBetweenLines), xPos+20, yPos+(spaceBetweenLines));
  }
}

void displayEighthNote(float xPos, float yPos, int pitch, int spaceBetweenLines){
  float noteHeight = findNoteHeight(pitch, spaceBetweenLines);
  if (pitch>=10){
    if ((pitch%12==1)||(pitch%12==6)) image(sharp, xPos-7, yPos-13-noteHeight);
    if ((pitch%12==10)||(pitch%12==3)||(pitch%12==8)) image(flat, xPos-10, yPos-17-noteHeight);
    image(eighthNoteDown, xPos, yPos-5-noteHeight);
    if (pitch>=20) line(xPos-7, yPos-(6*spaceBetweenLines), xPos+20, yPos-(6*spaceBetweenLines));
  } else {
    if ((pitch%12==1)||(pitch%12==6)) image(sharp, xPos-7, yPos-13-noteHeight);
    if ((pitch%12==10)||(pitch%12==3)||(pitch%12==8)) image(flat, xPos-10, yPos-17-noteHeight);
    image(eighthNoteUp, xPos, yPos-35-noteHeight);
    if (pitch<=1) line(xPos-7, yPos, xPos+20, yPos);
    if (pitch<=-3) line(xPos-7, yPos+(spaceBetweenLines), xPos+20, yPos+(spaceBetweenLines));
  }
}

void displayWholeNote(float xPos, float yPos, int pitch, int spaceBetweenLines){
  float noteHeight = findNoteHeight(pitch, spaceBetweenLines);
    if ((pitch%12==1)||(pitch%12==6)) image(sharp, xPos-25, yPos-14-noteHeight);
    if ((pitch%12==10)||(pitch%12==3)||(pitch%12==8)) image(flat, xPos-30, yPos-18-noteHeight);
    image(wholeNote, xPos-20, yPos-9-noteHeight);
    if (pitch>=20) line(xPos-22, yPos-(6*spaceBetweenLines), xPos+13, yPos-(6*spaceBetweenLines));
    if (pitch<=1) line(xPos-22, yPos, xPos+13, yPos);
    if (pitch<=-3) line(xPos-22, yPos+(spaceBetweenLines), xPos+13, yPos+(spaceBetweenLines));
}

void displayTie(float xPos, float yPos, int pitch, int spaceBetweenLines, float itemSpacing){
  if (pitch >= 10) image(tieUp, xPos+10, yPos-findNoteHeight(pitch, spaceBetweenLines)-20, itemSpacing/2, 14);
  if (pitch < 10) image(tieDown, xPos+10, yPos-findNoteHeight(pitch, spaceBetweenLines)+7, itemSpacing/2, 14);
}

void drawMeasureLine(float xPos, float yPos, int spaceBetweenLines){
  line(xPos-12, yPos-spaceBetweenLines, xPos-12, yPos-(5*spaceBetweenLines));
}

void drawDot(float xPos, float yPos, int pitch, int spaceBetweenLines){
  fill(0);
  ellipse(xPos+20, yPos-findNoteHeight(pitch, spaceBetweenLines), 5, 5);
}

void displayVerseWord(float xPos, float yPos, String word1, String word2, String word3){
  textFont(lyricFont, 14);
  textAlign(LEFT);
  color(0);
  text(word1, xPos-5, yPos+40);
  text(word2, xPos-5, yPos+60);
  text(word3, xPos-5, yPos+80);
}

float findNoteHeight(int pitch, int spaceBetweenLines){
  float noteHeight = 0;
  int note = pitch%12;
  if (pitch < 0) note = 12+pitch; //Pitch can't be less than -12
  float octaveBaseHeight = 3.5*floor(pitch/12)*spaceBetweenLines;
  if (pitch < 0) octaveBaseHeight = -1*3.5*spaceBetweenLines;
  if (note == 0) noteHeight = octaveBaseHeight; //C
  if (note == 1) noteHeight = octaveBaseHeight; //C#
  if (note == 2) noteHeight = octaveBaseHeight + 0.5*spaceBetweenLines; //D
  if (note == 3) noteHeight = octaveBaseHeight + 1*spaceBetweenLines; //Eb
  if (note == 4) noteHeight = octaveBaseHeight + 1*spaceBetweenLines; //E
  if (note == 5) noteHeight = octaveBaseHeight + 1.5*spaceBetweenLines; //F
  if (note == 6) noteHeight = octaveBaseHeight + 1.5*spaceBetweenLines; //F#
  if (note == 7) noteHeight = octaveBaseHeight + 2*spaceBetweenLines; //G
  if (note == 8) noteHeight = octaveBaseHeight + 2.5*spaceBetweenLines; //Ab
  if (note == 9) noteHeight = octaveBaseHeight + 2.5*spaceBetweenLines; //A
  if (note == 10) noteHeight = octaveBaseHeight + 3*spaceBetweenLines; //Bb
  if (note == 11) noteHeight = octaveBaseHeight + 3*spaceBetweenLines; //B
  return noteHeight;
}