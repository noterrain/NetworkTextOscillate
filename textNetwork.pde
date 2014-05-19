import rita.render.*;
import rita.json.*;
import rita.support.*;
import rita.*;

HashMap<String, NetworkWord> wordMap = new HashMap();
ArrayList<NetworkWord> allWords = new ArrayList();
ArrayList<NetworkWord> displayWords = new ArrayList();

PFont label;

PVector angle;
PVector velocity;
PVector amplitude;

void setup() {
  size(1024, 1024);
  smooth(8);
  label = createFont("Helvetica", 10);
  makeTextNetwork("bible.txt");
  showTopWords(20);
  arrangeWords();

  println(wordMap.get("lord").linkMap.get("heaven"));
  println(allWords.size());
}

void draw() {
  background(#f0f0f0);
  for (int k=1; k<100; k++) {
    fill(0, 0);
    print("circleAAA");
    // stroke(204, 102, 0);

    stroke(0, 40);
    strokeWeight(1);
    ellipse(width/2, height/2, k*50, k*50);
  }

  translate(width/2, height/2);
  for (NetworkWord nw: displayWords) {
    nw.oscillate();
    nw.update();
    nw.render(nw.count);
    nw.renderLinks();
  }
}

void makeTextNetwork(String url) {
  loadStrings(url);
  //break into sentences
  String doc = join(loadStrings(url), " ");
  String[] sentences = RiTa.splitSentences(doc);
  //break each sentence into words
  for (String s: sentences) {
    String[] words = RiTa.tokenize(s);
    processWords(words);
  }
}

void arrangeWords() {
  for (int i = 0; i < allWords.size(); i++) {
    NetworkWord nw = allWords.get(i);
    float theta = map(i, 0, displayWords.size(), 0, TAU); //theta is rotation tau is full circle
    println(theta);
    float rad =300;
    nw.rot = theta;
  }
}

void showTopWords(int num) {
  displayWords = new ArrayList();
  for (int i = 0; i < num; i++) {
    displayWords.add(allWords.get(i));
  }
}

void processWords(String[] words) {
  //make new NetworkWords where necessary, update counts
  //for every new word that we see, make object that will keep track of how often it is used
  for (String w: words) {
    //format the word
    w = RiTa.stripPunctuation(w).toLowerCase();
    //Have we seen this word before?
    if (wordMap.containsKey(w)) {
      //add 1 to the count in the object
      NetworkWord nw = wordMap.get(w);
      nw.count++;
    } else {
      //add key to the hashmap as a networkword
      NetworkWord nw = new NetworkWord(w, 1); //takes the word and the count of how many times that word has appeared
      wordMap.put(w, nw);
      allWords.add(nw);
    }
  }

  //make network connections
  for (String w: words) {
    //Pick each word
    w = RiTa.stripPunctuation(w).toLowerCase();
    NetworkWord startWord = wordMap.get(w);
    //Link to every other word
    for (String w2: words) {
      w2 = RiTa.stripPunctuation(w2).toLowerCase();
      NetworkWord endWord = wordMap.get(w2);
      linkWords(startWord, endWord);
    }
  }
}

void linkWords(NetworkWord w1, NetworkWord w2) {
  //look to make sure that not connected to itself
  if (w1 != w2) {
    w1.linkMap.add(w2.word, 1); //the 1 is "add a counter of one"
  }
}


