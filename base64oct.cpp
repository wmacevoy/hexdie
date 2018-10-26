#include <iostream>

using namespace std;

char hex(unsigned value, int digit) {
  return "0123456789ABCDEF"[(value >>= digit*4) & 0xF];
}

char bit(unsigned value, int digit) {
  return "01"[(value >>= digit) & 0x1];
}

char mime(int row, int col) {
  int code=row*8+col;
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
  for (int row=-2; row<8; ++row) {
    for (int col=-1; col<8; ++col) {
      cout << "|";
      if (row == -2) {
	if (col == -1) {
	  cout << "     ";
	} else {
	  cout << "  " << hex(col,0) << "<sub>" << bit(col,2) << bit(col,1) << bit(col,0) << "</sub>";
	}
      } else if (row == -1) {
	cout << "-----";
      } else {
	if (col == -1) {
	  cout << hex(row,0) << "<sub>" << bit(row,2) << bit(row,1) << bit(row,0) << "</sub>";
	} else {
	  cout << "  " << mime(row,col) << "  ";
	}
      }
    }
    cout << "|" << endl;
  }
}
