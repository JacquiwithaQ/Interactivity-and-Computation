//DETERMINES THE RHYME SCHEME THE VERSES WILL HAVE
void setRhymeSchemeVerse(int test) {
  if (test == 0) {
    rhymeSchemeVerse[0] = 1;
    rhymeSchemeVerse[1] = 2;
    rhymeSchemeVerse[2] = 1;
    rhymeSchemeVerse[3] = 2;
  }
  if (test == 1) {
    rhymeSchemeVerse[0] = 1;
    rhymeSchemeVerse[1] = 1;
    rhymeSchemeVerse[2] = 1;
    rhymeSchemeVerse[3] = 1;
  }
  if (test == 2) {
    rhymeSchemeVerse[0] = 1;
    rhymeSchemeVerse[1] = 1;
    rhymeSchemeVerse[2] = 3;
    rhymeSchemeVerse[3] = 3;
  }
}

//DECIDES THE RHYME SCHEME THAT THE CHORUS WILL HAVE 
void setRhymeSchemeChorus(int test) {
  if (test == 0) {
    rhymeSchemeChorus[0] = 1;
    rhymeSchemeChorus[1] = 2;
    rhymeSchemeChorus[2] = 1;
    rhymeSchemeChorus[3] = 2;
  }
  if (test == 1) {
    rhymeSchemeChorus[0] = 1;
    rhymeSchemeChorus[1] = 1;
    rhymeSchemeChorus[2] = 1;
    rhymeSchemeChorus[3] = 1;
  }
  if (test == 2) {
    rhymeSchemeChorus[0] = 1;
    rhymeSchemeChorus[1] = 1;
    rhymeSchemeChorus[2] = 2;
    rhymeSchemeChorus[3] = 2;
  }
}