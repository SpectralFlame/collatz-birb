import java.util.Comparator;
import java.util.Stack;

// using draw if true, using setup if false
boolean iterative = true;

// max value
int N = 10000;
// length of line segment
int L = 8;
// width of line
float W = L*0.5;
// how many lines drawn per loop
int segperloop = 50;

// Color settings
float red = 192;
float green = 50;
float blue = 192;
int rmin = 208; // lower bound
int rmax = 255;
int gmin = 0;
int gmax = 128; // upper bound
int bmin = 128;
int bmax = 255;
float rvar = 0.7; // rate of change
float gvar = 0.3;
float bvar = 0.7;
boolean useSeed = true;
int seed = 1066;

ArrayList<IntList> chains;
float currAngle = 0;
PVector currPos = new PVector(0, 0);
Stack<Integer> values;
Stack<PVector> pos;
Stack<PVector> prevPos;
Stack<Float> angles;

void setup() {
  size(1000, 1000);
  background(50,169,195);
  if (useSeed) {
    randomSeed(seed);
  }
  if (iterative) {
    N *= 10;
    pos = new Stack();
    pos.push(new PVector(0,0));
    values = new Stack();
    values.push(2);
    angles = new Stack();
    angles.push(0.0);
    //frameRate(1);
  } else {
    noLoop();
    chains = new ArrayList();
    for (int i = 2; i < N; i++) {
      IntList chain = collatzChain(i);
      chains.add(chain);
    }
    chains.sort(new Comparator<IntList>() {
      @Override
      public int compare(IntList l1, IntList l2) {
        return l1.size() - l2.size();
      }
    });
    // Draw chains
    drawChains(chains);
  }
}

void draw() {
  if (iterative && values.size() > 0) {
    for (int i = 0; i < segperloop; i++) {
      resetMatrix();
      translate(width/5, 12*height/13);
      if (values.size() == 0) {
        break;
      }
      next();
    }
  } else {
    noLoop();
  }
}

void drawChains(ArrayList<IntList> chains) {
  strokeWeight(W);
  for(IntList chain : chains) {
    stroke(128+random(128), 50, 128+random(128));
    resetMatrix();
    translate(width/5, 12*height/13);
    drawChain(chain.copy());
  }
}

void drawOutlineChains(ArrayList<IntList> chains) {
  for(IntList chain : chains) {
    resetMatrix();
    translate(width/5, 12*height/13);
    strokeWeight(W);
    stroke(0);
    drawChain(chain.copy());
    resetMatrix();
    translate(width/5, 12*height/13);
    strokeWeight(W-2);
    stroke(255);
    drawChain(chain.copy());
  }
}

void drawChain(IntList chain) {
  chain.reverse();
  for (int v : chain) {
    if (v % 2 == 0) {
      rotate(PI/13);
    } else {
      rotate(-PI/20);
    }
    line(0, 0, -L, 0);
    translate(-L, 0);
  }
}

IntList collatzChain(int n) {
  IntList l = new IntList();
  if (n < 2) {
    return l;
  }
  while (n != 1) {
    l.append(n);
    n = collatz(n);
  }
  return l;
}

int collatz(int n) {
  if (n % 2 == 0) {
    return n / 2;
  } else {
    return (3 * n + 1) / 2;
  }
}

void reverseCollatz(int n) {
  int n1 = n * 2;
  values.push(n1);
  pos.push(currPos);
  angles.push(currAngle);
  if ((n * 2 - 1) % 3 == 0) {
    int n2 = (n * 2 - 1) / 3;
    if (n2 > 2 && n2 != 4) {
      values.push(n2);
      pos.push(currPos);
      angles.push(currAngle);
    }
  }
}

void next() {
  int n = values.pop();
  currPos = pos.pop();
  currAngle = angles.pop();
  strokeWeight(W);
  translate(currPos.x, currPos.y);
  if (n % 2 == 0) {
    currAngle += PI/13;
  } else {
    currAngle -= PI/20;
  }
  currPos = currPos.copy().add(new PVector(-L, 0).rotate(currAngle));
  rotate(currAngle);
  stroke(red, green, blue);
  red += randomGaussian() * rvar;
  green += randomGaussian() * gvar;
  blue += randomGaussian() * bvar;
  if (red > rmax) { red = rmax; }
  if (green > gmax) { green = gmax; }
  if (blue > bmax) { blue = bmax; }
  if (red < rmin) { red = rmin; }
  if (green < gmin) { green = gmin; }
  if (blue < bmin) { blue = bmin; }
  line(0, 0, -L, 0);
  if (n < N) {
    reverseCollatz(n);
  }
}
