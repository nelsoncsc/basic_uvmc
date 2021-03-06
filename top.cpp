#include "refmod.cpp"
#include "refmod_low.cpp"

int sc_main(int argc, char* argv[]) {
 
  refmod  refmod_i("refmod_i");
  refmod_low refmod_low_i("refmod_low_i");
  
  uvmc_connect(refmod_i.in, "refmod_i.in");
  uvmc_connect(refmod_low_i.in, "refmod_low_i.in");
  uvmc_connect(refmod_i.out, "refmod_i.out");
  uvmc_connect(refmod_low_i.out, "refmod_low_i.out");

  sc_start();
  return(0);
}

