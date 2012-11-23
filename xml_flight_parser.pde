XML flightData;
XML[] edges;
String sourceCountry = "United States";
int weightMax = 0;

void setup() {
  size(600, 600);
  flightData = loadXML("countriesNetwork.xml");
  edges = flightData.getChildren("edge");
}

void draw() {
  int targetCount = 0;
  for (int i=0; i<edges.length; i++) {
    if (edges[i].getChild("source") != null && 
      edges[i].getChild("source").getContent().equals(sourceCountry) &&
      !edges[i].getChild("target").getContent().equals(sourceCountry)
      ) {
      if (int(edges[i].getChild("weight").getContent()) > weightMax) {
        weightMax = int(edges[i].getChild("weight").getContent());
      }
      targetCount++;
    }
  }
  Country countries[] = new Country[targetCount];
  targetCount = 0;
  for (int i=0; i<edges.length; i++) {
    if (edges[i].getChild("source") != null && 
      edges[i].getChild("source").getContent().equals(sourceCountry) &&
      !edges[i].getChild("target").getContent().equals(sourceCountry)
      ) {
      countries[targetCount] = new Country();
      countries[targetCount].setSource(edges[i].getChild("source").getContent());
      countries[targetCount].setTarget(edges[i].getChild("target").getContent());
      countries[targetCount].setWeight(int(edges[i].getChild("weight").getContent()));
      //      println(countries[targetCount].target);
      targetCount++;
    }
  }

  pushMatrix();
  translate(width/2, height/2);
  pushMatrix();
  rotate(PI);
  for (int i=0; i<countries.length; i++) {
    float yPos = int(countries[i].weight);
    yPos = map(yPos, 0, weightMax/4, (height/2)-20, 20);
    if (i == 0) {
      fill(0);
    }
    else {
      fill(255);
    }
    ellipse(0, yPos, 10, 10);

    rotate(TWO_PI/countries.length);
    if (i == 0){
    println(dist(0, yPos, mouseX, mouseY));
    }
  }
  popMatrix();
  ellipse(0, 0, 20, 20);
  popMatrix();
}

