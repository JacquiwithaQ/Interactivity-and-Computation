import rita.*;
RiLexicon lexicon;

//ONE LINE OF "WORDS" BASED ON AN INPUT RHYTHM
class lyricLine {
  String[] syllables;
  String lastPart;
  public lyricLine(rhythmLine rhythm, boolean needToRhyme, String rhymeMatch, boolean hyphensOkay) {
    String[] wordBeginnings = {"br", "b", "b", "c", "c", "ch", "ch", "cr", "dr",
                               "d", "d", "f", "fr", "f", "g", "h", "h", "h", 
                               "j", "k", "k", "l", "l", "m", "m", "n", "n", "p",
                               "p", "p", "pr", "ph", "qu", "r", "r", "s", "s", 
                               "sh", "sh", "sc", "sw", "sp", "sl", "t", "t",
                               "th", "th", "tr", "ts", "v", "w", "y", "y"};
    String[] wordEndings = {"ut", "at", "it", "ot", "ay", "ee", "ai", "un", "en", 
                            "in", "ide", "ime", "ool", "ull", "ill", "and", "ess",
                            "ell", "ur", "ir", "ook", "ow", "oh", "ace", "ave"};
    String lastPart2 = new String();
    syllables = new String[rhythm.howMany];
    String part1 = new String();
    String part2 = new String();
    String mySyllable = new String();
    for (int i=0; i<syllables.length; i++) {
      part1 = wordBeginnings[int(random(0,wordBeginnings.length))];
      part2 = wordEndings[int(random(0,wordEndings.length))];
      if (rhythm.types[i] != 0){
        if (i==syllables.length-1){
          if (needToRhyme){
            //println("rhymeMatch = " + rhymeMatch);
            part2 = rhymeMatch;
            //println("part2 = " + part2);
          }
          mySyllable = part1+part2;
        } else {
          if (random(0,2)>0.8){
            mySyllable = lexicon.randomWord(1);
          } else {
            mySyllable = part1+part2;
            if ((hyphensOkay || i>4) && random(0,2)>=1 && rhythm.types[i+1]!=0){
              mySyllable = mySyllable + " -";
            }
          }
        }
        syllables[i] = mySyllable;
        lastPart2 = part2;
      } else if (rhythm.types[i] == 0) {
        syllables[i] = " ";
      }
      //print(syllables[i] + " ");
    }
    lastPart = lastPart2;
    String firstLetter = syllables[0].substring(0,1);
    String restOfWord = syllables[0].substring(1);
    syllables[0] = firstLetter.toUpperCase() + restOfWord;
    String[] possiblePunctuation = {".", ".", ".", "!", "?"};
    String punctuationMark = possiblePunctuation[int(random(0,possiblePunctuation.length))];
    syllables[syllables.length-1] = syllables[syllables.length-1] + punctuationMark;
    //println();
  }
    
  void makeBeginning() {
    //gets rid of all words
    for (int s=0; s<this.syllables.length; s++) {
      this.syllables[s] = "  ";
    }
    this.lastPart = "  ";
  }
  void makeEnd() {
    //Gets rid of all words
    for (int s=0; s<this.syllables.length; s++) {
      this.syllables[s] = "  ";
    }
    this.lastPart = "   ";
  }
}