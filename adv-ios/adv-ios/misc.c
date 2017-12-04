//
//  misc.c
//  file_hello1
//
//  Created by daniel on 25.08.2017.
//  Copyright © 2017 code masterss. All rights reserved.
//

#include <stdio.h>
#include "main.h"
#include "misc.h"


long fIABS(N)long N; {return(N<0? -N : N);}




long fSETBIT(bit_nr)long bit_nr; {
    long I, SETBIT;
    
    /*  RETURNS 2**BIT FOR USE IN CONSTRUCTING BIT-MASKS. */
    
    
    SETBIT=1;
    
    SETBIT = SETBIT << bit_nr;
    
    
    return(SETBIT);
}

#define SETBIT(BIT) fSETBIT(BIT)
#undef TSTBIT
long fTSTBIT(MASK,BIT)long BIT, MASK; {
    long TSTBIT;
    
    /*  RETURNS TRUE IF THE SPECIFIED BIT IS SET IN THE MASK. */
    
    
    //TSTBIT=MOD(MASK/SETBIT(BIT),2) != 0;
    return(TSTBIT);
}


#define TSTBIT(MASK,BIT) fTSTBIT(MASK,BIT)


//simply returns mod value of N / M
long fMOD(N,M)long N, M; {return(N%M);}