import rita.*;
import processing.pdf.*;
PImage trebleClef;
PImage bassClef;
PImage fourFourTime; //timeSignature
PImage sharp;
PImage flat;
PImage eighthRest;
PImage quarterRest;
PImage eighthNoteDown;
PImage eighthNoteUp;
PImage quarterNoteDown;
PImage quarterNoteUp;
PImage halfNoteDown;
PImage dottedHalfNoteDown;
PImage dottedHalfNoteUp;
PImage halfNoteUp;
PImage wholeNote;
PImage tieUp;
PImage tieDown;
PFont lyricFont;
PFont notationFont;
PFont titleFont;

int[] rhymeSchemeVerse; 
int[] rhymeSchemeChorus; 

// final int musicKey; //-4 is Aflat, 3 is Eflat, -2 is Bflat, 5 is F, 0 is C, -5 is G, 2 is D
final int AFLAT_MAJOR = -4;
final int EFLAT_MAJOR = 3;
final int BFLAT_MAJOR = -2;
final int F_MAJOR = 5;
final int C_MAJOR = 0;
final int G_MAJOR = -5;
final int D_MAJOR = 2;
int[] chordProgression; //1 is Major First, 2 is Minor Second, 4 is Major Fourth
//5 is Major Fifth, 6 is Minor Sixth
final int MAJOR_FIRST = 1;
final int MINOR_SECOND = 2;
final int MAJOR_FOURTH = 4;
final int MAJOR_FIFTH = 5;
final int MINOR_SIXTH = 6;
// final int timeSig; // GL

final int CODE_REST = 0; 
final int INVALID_PITCH = 100;

int pageWeAreOn;
int songWeArePrinting;

class totalPhrase {
  musicPhrase music; //NAVIGATION music.allPitchLines[x].pitches[x] or .myRhythm or .myChord
  ArrayList<lyricLine> lyrics;
  public totalPhrase(musicPhrase musicA, int[] rhymeScheme, boolean notChorus) {
    lyrics = new ArrayList<lyricLine>();
    music = musicA;
    lyricLine lyric1 = new lyricLine(musicA.allPitchLines.get(0).myRhythm, false, " ", notChorus);
    lyricLine lyric2;
    if (rhymeScheme[1]==1) {
      lyric2 = new lyricLine(musicA.allPitchLines.get(1).myRhythm, true, lyric1.lastPart, true);
    } else {
      //rhymeScheme[1] == 2
      lyric2 = new lyricLine(musicA.allPitchLines.get(1).myRhythm, false, " ", true);
    }
    lyricLine lyric3;
    if (rhymeScheme[2]==1) {
      //print("lyric1.lastPart = " + lyric1.lastPart);
      lyric3 = new lyricLine(musicA.allPitchLines.get(2).myRhythm, true, lyric1.lastPart, true);
    } else if (rhymeScheme[2]==2) {
      //print("lyric2.lastPart = " + lyric2.lastPart);
      lyric3 = new lyricLine(musicA.allPitchLines.get(2).myRhythm, true, lyric2.lastPart, true);
    } else {
      //rhymeScheme[2] == 3
      lyric3 = new lyricLine(musicA.allPitchLines.get(2).myRhythm, false, "  ", true);
    }
    lyricLine lyric4;
    if (rhymeScheme[3]==1) {
      //print("lyric1.lastPart = " + lyric1.lastPart);
      lyric4 = new lyricLine(musicA.allPitchLines.get(3).myRhythm, true, lyric1.lastPart, true);
    } else if (rhymeScheme[3]==2) {
      //print("lyric2.lastPart = " + lyric2.lastPart);
      lyric4 = new lyricLine(musicA.allPitchLines.get(3).myRhythm, true, lyric2.lastPart, true);
    } else if (rhymeScheme[3]==3) {
      //print("lyric3.lastPart = " + lyric2.lastPart);
      lyric4 = new lyricLine(musicA.allPitchLines.get(3).myRhythm, true, lyric3.lastPart, true);
    } else {
      //rhymeScheme[3] == 3
      lyric4 = new lyricLine(musicA.allPitchLines.get(3).myRhythm, false, "  ", true);
    }
    //Now we have four lyrics lines, each based on a rhythm line
    this.lyrics.add(lyric1);
    this.lyrics.add(lyric2);
    this.lyrics.add(lyric3);
    this.lyrics.add(lyric4);
  }

  void printPhrase() {
    // test method, just print the 0th element.
    pitchLine aPitchLine = music.allPitchLines.get(0); 
    rhythmLine aRhythmLine = aPitchLine.myRhythm;
    int nElementsInRhythmArray = aRhythmLine.howMany;
    //println ("nElementsInRhythmArray = " + nElementsInRhythmArray); 

    for (int q=0; q<nElementsInRhythmArray; q++) {
      print("Num of Counts: " + aRhythmLine.rhythm[q]);
      if (aRhythmLine.types[q] != CODE_REST) {
        //println("aPitchLine's pitches = " + aPitchLine.pitches); 
        print("  Pitch is: " + aPitchLine.pitches[q]);
      }
      println();
    }
    println();
    println();
    // test method, print the 1th element.
    pitchLine bPitchLine = music.allPitchLines.get(1); 
    rhythmLine bRhythmLine = bPitchLine.myRhythm;
    int bnElementsInRhythmArray = bRhythmLine.howMany;
    //println ("nElementsInRhythmArray = " + bnElementsInRhythmArray); 

    for (int f=0; f<bnElementsInRhythmArray; f++) {
      print("Num of Counts: " + bRhythmLine.rhythm[f]);
      if (bRhythmLine.types[f] != CODE_REST) {
        //println("aPitchLine's pitches = " + aPitchLine.pitches); 
        print("  Pitch is: " + bPitchLine.pitches[f]);
      }
      println();
    }
  }
}

//ONE SONG
class Song {
  ArrayList<totalPhrase> songVerses;
  totalPhrase songChorus;
  String title;
  int musicKey;
  int timeSig;

  public Song() {
    songVerses = new ArrayList<totalPhrase>();
    int timeSig = int(random(3, 5)); //3 4 time if 3, 4 4 time if 4
    int musicKey = int(random(0, 7));
    if (musicKey == 0) {
      musicKey = AFLAT_MAJOR;
    } else if (musicKey == 1) {
      musicKey = EFLAT_MAJOR;
    } else if (musicKey == 2) {
      musicKey = BFLAT_MAJOR;
    } else if (musicKey == 3) {
      musicKey = F_MAJOR;
    } else if (musicKey == 4) {
      musicKey = C_MAJOR;
    } else if (musicKey == 5) {
      musicKey = G_MAJOR;
    } else {
      musicKey = D_MAJOR;
    } //-4 is Aflat, 3 is Eflat, -2 is Bflat, 5 is F, 0 is C, -5 is G, 2 is D
    int temp0 = int(random(0, 6));
    chordProgression = new int[4];
    setChordProgression(temp0);
    //THE LYRIC WRITING PART
    int temp1 = int(random(0, 3));
    rhymeSchemeVerse = new int[4];
    setRhymeSchemeVerse(temp1);
    int temp2 = int(random(0, 3));
    rhymeSchemeChorus = new int[4];
    setRhymeSchemeChorus(temp2);
    musicPhrase Verse = makeMainMusicPhrase(musicKey, chordProgression, rhymeSchemeVerse, timeSig, false);
    musicPhrase Chorus = makeMainMusicPhrase(musicKey, chordProgression, rhymeSchemeVerse, timeSig, true);
    totalPhrase Verse1 = new totalPhrase(Verse, rhymeSchemeVerse, true);
    this.songVerses.add(Verse1);
    totalPhrase Verse2 = new totalPhrase(Verse, rhymeSchemeVerse, true);
    this.songVerses.add(Verse2);
    totalPhrase Verse3 = new totalPhrase(Verse, rhymeSchemeVerse, true);
    this.songVerses.add(Verse3);
    totalPhrase totalChorus = new totalPhrase(Chorus, rhymeSchemeChorus, false);
    songChorus = totalChorus;
    String[] wordsForTitle = totalChorus.lyrics.get(0).syllables;
    int titleWordCounter = 0;
    int lyricTraverser = 0;
    int titleWordLength = int(random(1,5));
    String[] wordsActuallyInTitle = new String[titleWordLength];
    while ((lyricTraverser < wordsForTitle.length) && (lyricTraverser < titleWordLength)){
      if (songChorus.music.allPitchLines.get(0).myRhythm.types[lyricTraverser] != 0){
        wordsActuallyInTitle[titleWordCounter] = wordsForTitle[lyricTraverser];
        titleWordCounter++;
      }
      lyricTraverser++;
    }
    title = join(wordsActuallyInTitle, " "); //The title is the first few words of the chorus
    if (title.endsWith("null")){
      title = title.substring(0,title.length()-4); //Gets rid of the word 'null'
    }
    title = title.trim();
  }
}


ArrayList<Song> allSongs;

void MakeSong() {
  Song thisSong = new Song();
  allSongs.add(thisSong);
}

void setup() {
  size(900, 900, PDF, "song_book.pdf");
  textMode(SHAPE);
  lexicon = new RiLexicon();
  allSongs = new ArrayList<Song>();
  int numberOfSongs = 30;
  int songCounter = 0;
  while (songCounter < numberOfSongs) {
    MakeSong();
    songCounter += 1;
  }
  trebleClef = loadImage("data/treble-clef.png");
  bassClef = loadImage("data/bass-clef.png");
  fourFourTime = loadImage("data/time-signature.png");
  sharp = loadImage("data/sharp.png");
  flat = loadImage("data/flat.png");
  eighthRest = loadImage("data/eighth-rest.png");
  quarterRest = loadImage("data/quarter-rest.png");
  eighthNoteDown = loadImage("data/eighth-note-down.png");
  eighthNoteUp = loadImage("data/eighth-note-up.png");
  quarterNoteDown = loadImage("data/quarter-note-down.png");
  quarterNoteUp = loadImage("data/quarter-note-up.png");
  halfNoteDown = loadImage("data/half-note-down.png");
  halfNoteUp = loadImage("data/half-note-up.png");
  dottedHalfNoteUp = loadImage("data/dotted-half-note-up.png");
  dottedHalfNoteDown = loadImage("data/dotted-half-note-down.png");
  wholeNote = loadImage("data/whole-note.png");
  tieUp = loadImage("data/tie-up.png");
  tieDown = loadImage("data/tie-down.png");
  lyricFont = createFont("IowanOldStyle-Roman", 48);
  notationFont = createFont("Marion-Italic", 48);
  titleFont = createFont("GujaratiMT-Bold", 68);
  //allSongs.get(0).songVerses.get(0).printPhrase();
  //allSongs.get(1).songVerses.get(2).printPhrase();
  //allSongs.get(0).songVerses.get(0).printPhrase();
  pageWeAreOn = 0;
  songWeArePrinting = 0;
}

void draw() {
  background(255);
  if (pageWeAreOn == 0){
    displayTableOfContents(allSongs, 30);
  } else if (pageWeAreOn%2 == 1){
    displayVerses(195, 10, allSongs.get(songWeArePrinting).songVerses, pageWeAreOn+1, allSongs.get(songWeArePrinting).title);
  } else {
    displayChorus(195, 10, allSongs.get(songWeArePrinting).songChorus, pageWeAreOn+1);
    songWeArePrinting++;
  }
  PGraphicsPDF pdf = (PGraphicsPDF) g;
  if (frameCount == 61){
    exit();
  } else {
    pdf.nextPage(); //goes to next page
    pageWeAreOn ++;
  }
}