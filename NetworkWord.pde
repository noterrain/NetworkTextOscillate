class NetworkWord {
  //Display Objects because appear on the screen
  String word;
  int count;
  IntDict linkMap;

  PVector pos = new PVector();
  float rot = 0; //rotation value


  //add the oscillator library
  PVector angle;
  PVector velocity;
  PVector amplitude;

  NetworkWord(String w, int c) {
    word = w;
    count = c;
    linkMap = new IntDict();
    angle = new PVector();
    velocity = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    amplitude = new PVector(random(20, width/2), random(20, height/2));
  }

  void update() {
  }

  void render(int number) {
    int thisnumber = number;
    pos.x = sin(angle.x)*amplitude.x;
    pos.y = sin(angle.y)*amplitude.y;
    fill(0);
    textSize(sqrt(thisnumber)*3+10);

    strokeWeight(1);
    ellipse(0, 0, 5, 5);
    text(word, pos.x, pos.y);

    //stroke(114,39,234,200);
    stroke(0, 200);
    line(0, 0, pos.x, pos.y);
  }

  void oscillate() {
    angle.add(velocity);
  }
  void renderLinks() {
    //go through the words stored in the intdict
    for (String w: linkMap.keys()) {
      NetworkWord w2 = wordMap.get(w);

      if (displayWords.contains(w2)) {
        strokeWeight(sqrt(linkMap.get(w)) * 0.1);
        //color(255, 204, 0);
        // stroke(242,102,49,150);
        stroke(0, 150);
        println("AAAAAAAAAAAA");

        println(w2.count);
        line(pos.x, pos.y, w2.pos.x, w2.pos.y);
      }
    }
  }
}

