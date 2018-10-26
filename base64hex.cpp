#include <iostream>

using namespace std;

char hex(unsigned value, int digit) {
  return "0123456789ABCDEF"[(value >>= digit*4) & 0xF];
}

char bit(unsigned value, int digit) {
  return "01"[(value >>= digit) & 0x1];
}

char mime(int row, int col) {
  int code=row*16+col;
  if (code < 'Z' - 'A' + 1) {
    return code + 'A';
  }
  code -= 'Z' - 'A' + 1;
  if (code < 'z' - 'a' + 1) {
    return code + 'a';
  }
  code -= 'z' - 'a' + 1;
  if (code < '9' - '0' + 1) {
    return code + '0';
  }
  code -= '9' - '0' + 1;
  return (code == 0) ? '+' : '/';
}

int main() {
  for (int row=-3; row<4; ++row) {
    for (int col=-1; col<16; ++col) {
      cout << "|";
      if (row == -3) {
	if (col == -1) {
	  cout << "     ";
	} else {
	  cout << "  " << hex(col,0) << "  ";
	}
      } else if (row == -2) {
	cout << "-----";
      } else if (row == -1) {
	if (col == -1) {
	  cout << "     ";
	} else {
	  cout << "<sub><sub>" << bit(col,3) << bit(col,2) << bit(col,1) << bit(col,0) << "</sub></sub>";
	}
      } else {
	if (col == -1) {
	  cout << row << "<sub>" << bit(row,1) << bit(row,0) << "</sub>";
	} else {
	  cout << "  " << mime(row,col) << "  ";
	}
      }
    }
    cout << "|" << endl;
  }
}
