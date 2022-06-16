
/* 
    parseArgs
    This function parses the command line arguments to get
    the dimension of the matrices, the size of the thread blocks,
    the size of the tile of elements handled by one thread, the GPU
    kernel to be executed, and whether timing results should be
    produced. If the command line argument is invalid, it prints usage 
    information and exits.
    Inputs:
    argc - count of the number of command line arguments
    argv - array of command line arguments
    matrixDimP - pointer to an int to be set to the matrix dimensions
    blkDimP - pointer to an int to be set to the block dimensions
    tileSzP - pointer to an int to be set to the size of the tile
              of elements to be handled by one thread
    whichP - which kernel to execute
    doTimeP - pointer to a bool that is set to true or false if timing
              is to be performed
*/
void parseArgs(int argc, char * argv[], int * matrixDimP,
               int * blkDimP, int * tileSzP, int * whichP, bool * doTimeP)
{
    int i;
    //set the parameters to their defaults
    int dimExp = MATDIM_DEFAULT;
    int blkDim = BLKDIM_DEFAULT;
    int tileSz = TILESZ_DEFAULT;
    int which = WHICH_DEFAULT;
    bool doTime = false;

    //loop through the command line arguments
    for (i = 1; i < argc; i++)
    {
       if (i < argc - 1 && strcmp(argv[i], "-n") == 0)
       {
          dimExp = atoi(argv[i+1]);
          i++;   //skip over the argument after the -n
       }
       else if (i < argc - 1 && strcmp(argv[i], "-b") == 0)
       {
          blkDim = atoi(argv[i+1]);
          i++;   //skip over the argument after the -b
       }
       else if (i < argc - 1 && strcmp(argv[i], "-t") == 0)
       {
          tileSz = atoi(argv[i+1]);
          i++;   //skip over the argument after the -t
       }
       else if (strcmp(argv[i], "-seq") == 0)
          which = SEQ;
       else if (strcmp(argv[i], "-par") == 0)
          which = PAR;
       else if (strcmp(argv[i], "-gpu") == 0)
          which = GPU;
       else if (strcmp(argv[i], "-time") == 0)
          doTime = true;
       else
          printUsage();
    }
