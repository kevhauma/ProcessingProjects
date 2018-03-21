int[]  arr;
int x= 0;
void setup() {
  size(400, 400);
  arr= new int[25];
  for (int x=0; x<arr.length; x++) {
    int l = floor( random(arr.length));
    arr[x] = l;
    print(l + " ");
  }
  println();
}
void draw() {
  background(0);
}
void sort() {
  int rec = 0;
  int recC=0;
  for (int c = 0; c <  arr.length-x; c++) {
    if (arr[c] > recC) {
      rec = c;
      recC = arr[c];
    }
  }
  flip(rec+1);
  flip(arr.length-x);
  printAr();
  x++;
}
void mousePressed() {
  sort();
}

void flip(int end) {
  for (int a = 0; a<end/2; a++) {
    int t = arr[a];    
    arr[a] =arr[end -a-1]; 
    arr[end -a-1] = t;
  }
}
void printAr() {
  for (int x=0; x<arr.length; x++) {
    print(arr[x] + " ");
  }
  println();
}