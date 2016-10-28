
void displayChorus(int firstRowStartingHeight, int spaceBetweenLines, 
                   totalPhrase aChorusLine, int songNumber){
  int lineLength = 0;
  float measureCounter = 0;
  int middleCHeight = firstRowStartingHeight;
  float itemSpacing = 0;
  stroke(0);
  fill(0);
  strokeWeight(1);
  for (int lineCounter = 0; lineCounter<4; lineCounter++){
    middleCHeight = firstRowStartingHeight + (lineCounter*185);
    musicPhrase chorusMusic = aChorusLine.music;
    float[] itemLengths = chorusMusic.allPitchLines.get(lineCounter).myRhythm.rhythm;
    int[] itemTypes = chorusMusic.allPitchLines.get(lineCounter).myRhythm.types;
    int[] itemPitches = chorusMusic.allPitchLines.get(lineCounter).pitches;
    String[] itemText = aChorusLine.lyrics.get(lineCounter).syllables;
    lineLength = itemPitches.length;
    itemSpacing = (width-170)/(lineLength+1);
    measureCounter = 0;
    float xPos = 155;
    for (int x=0; x<lineLength; x++){
      if ((itemLengths[x]!=4)||(measureCounter!=0)) {
        displayChorusWord(xPos, middleCHeight, itemText[x]); //Whole Notes are formatted a bit differently
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
            displayChorusWord(xPos-10, middleCHeight, itemText[x]);
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
    xPos = 860;
    stroke(0);
    strokeWeight(1);
    image(trebleClef, 94, middleCHeight - (5*spaceBetweenLines));
    textFont(notationFont, 14);
    text(chorusMusic.allFourChords[lineCounter], 110, middleCHeight - (6*spaceBetweenLines));
    line(90, middleCHeight - (1*spaceBetweenLines), xPos-12, middleCHeight - (1*spaceBetweenLines));
    line(90, middleCHeight - (2*spaceBetweenLines), xPos-12, middleCHeight - (2*spaceBetweenLines));
    line(90, middleCHeight - (3*spaceBetweenLines), xPos-12, middleCHeight - (3*spaceBetweenLines));
    line(90, middleCHeight - (4*spaceBetweenLines), xPos-12, middleCHeight - (4*spaceBetweenLines));
    line(90, middleCHeight - (5*spaceBetweenLines), xPos-12, middleCHeight - (5*spaceBetweenLines));
    drawMeasureLine(xPos, middleCHeight, spaceBetweenLines);
    if (lineCounter == 3){
      fill(0);
      textFont(notationFont, 14);
      textAlign(RIGHT);
      text("Repeat Twice", xPos-10, middleCHeight-(7*spaceBetweenLines)-10);
      text(chorusMusic.allFourChords[0], xPos-22, middleCHeight - (6*spaceBetweenLines));
      //MAKE A REPEAT SIGN
      rect(xPos-17, middleCHeight-(5*spaceBetweenLines), 5, (4*spaceBetweenLines));
      strokeWeight(2);
      strokeCap(SQUARE);
      line(xPos-23, middleCHeight-(5*spaceBetweenLines), xPos-23, middleCHeight-spaceBetweenLines);
      strokeWeight(1);
      ellipse(xPos-28, middleCHeight-(3.5*spaceBetweenLines), 2, 2);
      ellipse(xPos-28, middleCHeight-(2.5*spaceBetweenLines), 2, 2);
    }
    //println("Just finished with line " + lineCounter);
    //line(width-40, middleCHeight - (1*spaceBetweenLines), width-40, middleCHeight - (5*spaceBetweenLines)); 
  }
  textFont(lyricFont, 14);
  color(0);
  textAlign(CENTER);
  text(songNumber, (width/2)+25, height-25);
}

void displayChorusWord(float xPos, float yPos, String word1){
  textFont(lyricFont, 16);
  textAlign(LEFT);
  color(0);
  text(word1, xPos-5, yPos+50);
}

void displayTableOfContents(ArrayList<Song> everySong, int numberOfSongs){
  fill(0);
  textFont(lyricFont, 50);
  textAlign(CENTER);
  color(0);
  text("Contents", (width/2)+25, 90);
  textFont(lyricFont, 14);
  text("1", (width/2)+25, height-25);
  textFont(lyricFont, 24);
  int yPosition = 200;
  String currentSongTitle;
  for (int songWeAreOn=0; songWeAreOn<int(numberOfSongs/2); songWeAreOn++){
    currentSongTitle = everySong.get(songWeAreOn).title;
    textAlign(RIGHT);
    text((songWeAreOn*2)+2, (width/3)-100, yPosition);
    textAlign(LEFT);
    text(currentSongTitle, (width/3)-70, yPosition);
    yPosition += 40;
  }
  yPosition = 200;
  for (int songWeAreOn=int(numberOfSongs/2); songWeAreOn<numberOfSongs; songWeAreOn++){
    currentSongTitle = everySong.get(songWeAreOn).title;
    textAlign(RIGHT);
    text((songWeAreOn*2)+2, (2*width/3)-40, yPosition);
    textAlign(LEFT);
    text(currentSongTitle, (2*width/3)-10, yPosition);
    yPosition += 40;
  }
}