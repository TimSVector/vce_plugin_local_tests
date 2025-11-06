#include "source_a.h"
#include "source_b.h"
#include <string.h>

void invoke_handler(char* str)
{
  if(strcmp(str, "source_a") == 0) source_a();
  if(strcmp(str, "source_a_conditional") == 0) { source_a_conditional(0); source_a_conditional(1); }
  if(strcmp(str, "source_b") == 0) source_b();
  if(strcmp(str, "source_b_conditional") == 0) { source_b_conditional(0); source_b_conditional(1); }
}

int main(int argc, char** argv)
{
  invoke_handler(argv[1]);
  return 0;
}
