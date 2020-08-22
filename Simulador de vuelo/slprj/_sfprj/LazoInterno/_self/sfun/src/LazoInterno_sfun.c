/* Include files */

#include "LazoInterno_sfun.h"
#include "LazoInterno_sfun_debug_macros.h"
#include "c1_LazoInterno.h"
#include "c2_LazoInterno.h"
#include "c3_LazoInterno.h"
#include "c8_LazoInterno.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
uint32_T _LazoInternoMachineNumber_;
real_T _sfTime_;

/* Function Declarations */

/* Function Definitions */
void LazoInterno_initializer(void)
{
}

void LazoInterno_terminator(void)
{
}

/* SFunction Glue Code */
unsigned int sf_LazoInterno_method_dispatcher(SimStruct *simstructPtr, unsigned
  int chartFileNumber, const char* specsCksum, int_T method, void *data)
{
  if (chartFileNumber==1) {
    c1_LazoInterno_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==2) {
    c2_LazoInterno_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==3) {
    c3_LazoInterno_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==8) {
    c8_LazoInterno_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  return 0;
}

unsigned int sf_LazoInterno_process_check_sum_call( int nlhs, mxArray * plhs[],
  int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[20];
  if (nrhs<1 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the checksum */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"sf_get_check_sum"))
    return 0;
  plhs[0] = mxCreateDoubleMatrix( 1,4,mxREAL);
  if (nrhs>1 && mxIsChar(prhs[1])) {
    mxGetString(prhs[1], commandName,sizeof(commandName)/sizeof(char));
    commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
    if (!strcmp(commandName,"machine")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3974453518U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3298077961U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3629440466U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1823144982U);
    } else if (!strcmp(commandName,"exportedFcn")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(0U);
    } else if (!strcmp(commandName,"makefile")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3448410295U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(4139908502U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2259902261U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1428235296U);
    } else if (nrhs==3 && !strcmp(commandName,"chart")) {
      unsigned int chartFileNumber;
      chartFileNumber = (unsigned int)mxGetScalar(prhs[2]);
      switch (chartFileNumber) {
       case 1:
        {
          extern void sf_c1_LazoInterno_get_check_sum(mxArray *plhs[]);
          sf_c1_LazoInterno_get_check_sum(plhs);
          break;
        }

       case 2:
        {
          extern void sf_c2_LazoInterno_get_check_sum(mxArray *plhs[]);
          sf_c2_LazoInterno_get_check_sum(plhs);
          break;
        }

       case 3:
        {
          extern void sf_c3_LazoInterno_get_check_sum(mxArray *plhs[]);
          sf_c3_LazoInterno_get_check_sum(plhs);
          break;
        }

       case 8:
        {
          extern void sf_c8_LazoInterno_get_check_sum(mxArray *plhs[]);
          sf_c8_LazoInterno_get_check_sum(plhs);
          break;
        }

       default:
        ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(0.0);
      }
    } else if (!strcmp(commandName,"target")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3031367619U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(4001028638U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3978939492U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(838979348U);
    } else {
      return 0;
    }
  } else {
    ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(876838294U);
    ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3704685674U);
    ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2058640551U);
    ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1587162464U);
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_LazoInterno_autoinheritance_info( int nlhs, mxArray * plhs[],
  int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[32];
  char aiChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the autoinheritance_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_autoinheritance_info"))
    return 0;
  mxGetString(prhs[2], aiChksum,sizeof(aiChksum)/sizeof(char));
  aiChksum[(sizeof(aiChksum)/sizeof(char)-1)] = '\0';

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        if (strcmp(aiChksum, "ba4UrDCK0FgEWaxtv9h4vC") == 0) {
          extern mxArray *sf_c1_LazoInterno_get_autoinheritance_info(void);
          plhs[0] = sf_c1_LazoInterno_get_autoinheritance_info();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     case 2:
      {
        if (strcmp(aiChksum, "A06KbxKB8kdE2y2bIqHMeF") == 0) {
          extern mxArray *sf_c2_LazoInterno_get_autoinheritance_info(void);
          plhs[0] = sf_c2_LazoInterno_get_autoinheritance_info();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     case 3:
      {
        if (strcmp(aiChksum, "7D4ME6PnUbOZyAQ2LduCWG") == 0) {
          extern mxArray *sf_c3_LazoInterno_get_autoinheritance_info(void);
          plhs[0] = sf_c3_LazoInterno_get_autoinheritance_info();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     case 8:
      {
        if (strcmp(aiChksum, "9yhAjL8F0f2DheHbzH21yC") == 0) {
          extern mxArray *sf_c8_LazoInterno_get_autoinheritance_info(void);
          plhs[0] = sf_c8_LazoInterno_get_autoinheritance_info();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_LazoInterno_get_eml_resolved_functions_info( int nlhs, mxArray *
  plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[64];
  if (nrhs<2 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the get_eml_resolved_functions_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_eml_resolved_functions_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        extern const mxArray *sf_c1_LazoInterno_get_eml_resolved_functions_info
          (void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c1_LazoInterno_get_eml_resolved_functions_info();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     case 2:
      {
        extern const mxArray *sf_c2_LazoInterno_get_eml_resolved_functions_info
          (void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c2_LazoInterno_get_eml_resolved_functions_info();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     case 3:
      {
        extern const mxArray *sf_c3_LazoInterno_get_eml_resolved_functions_info
          (void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c3_LazoInterno_get_eml_resolved_functions_info();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     case 8:
      {
        extern const mxArray *sf_c8_LazoInterno_get_eml_resolved_functions_info
          (void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c8_LazoInterno_get_eml_resolved_functions_info();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_LazoInterno_third_party_uses_info( int nlhs, mxArray * plhs[],
  int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the third_party_uses_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_third_party_uses_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        if (strcmp(tpChksum, "Y24mG12EQt4nnfOMsu1UJE") == 0) {
          extern mxArray *sf_c1_LazoInterno_third_party_uses_info(void);
          plhs[0] = sf_c1_LazoInterno_third_party_uses_info();
          break;
        }
      }

     case 2:
      {
        if (strcmp(tpChksum, "D9O0WQoFQmszD92rKsWSrB") == 0) {
          extern mxArray *sf_c2_LazoInterno_third_party_uses_info(void);
          plhs[0] = sf_c2_LazoInterno_third_party_uses_info();
          break;
        }
      }

     case 3:
      {
        if (strcmp(tpChksum, "lhLdefBZLCzp9wu7iQ0McF") == 0) {
          extern mxArray *sf_c3_LazoInterno_third_party_uses_info(void);
          plhs[0] = sf_c3_LazoInterno_third_party_uses_info();
          break;
        }
      }

     case 8:
      {
        if (strcmp(tpChksum, "LAddihZCmEmUkEqVOOShmF") == 0) {
          extern mxArray *sf_c8_LazoInterno_third_party_uses_info(void);
          plhs[0] = sf_c8_LazoInterno_third_party_uses_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

unsigned int sf_LazoInterno_updateBuildInfo_args_info( int nlhs, mxArray * plhs[],
  int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the updateBuildInfo_args_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_updateBuildInfo_args_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        if (strcmp(tpChksum, "Y24mG12EQt4nnfOMsu1UJE") == 0) {
          extern mxArray *sf_c1_LazoInterno_updateBuildInfo_args_info(void);
          plhs[0] = sf_c1_LazoInterno_updateBuildInfo_args_info();
          break;
        }
      }

     case 2:
      {
        if (strcmp(tpChksum, "D9O0WQoFQmszD92rKsWSrB") == 0) {
          extern mxArray *sf_c2_LazoInterno_updateBuildInfo_args_info(void);
          plhs[0] = sf_c2_LazoInterno_updateBuildInfo_args_info();
          break;
        }
      }

     case 3:
      {
        if (strcmp(tpChksum, "lhLdefBZLCzp9wu7iQ0McF") == 0) {
          extern mxArray *sf_c3_LazoInterno_updateBuildInfo_args_info(void);
          plhs[0] = sf_c3_LazoInterno_updateBuildInfo_args_info();
          break;
        }
      }

     case 8:
      {
        if (strcmp(tpChksum, "LAddihZCmEmUkEqVOOShmF") == 0) {
          extern mxArray *sf_c8_LazoInterno_updateBuildInfo_args_info(void);
          plhs[0] = sf_c8_LazoInterno_updateBuildInfo_args_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

void LazoInterno_debug_initialize(struct SfDebugInstanceStruct* debugInstance)
{
  _LazoInternoMachineNumber_ = sf_debug_initialize_machine(debugInstance,
    "LazoInterno","sfun",0,4,0,0,0);
  sf_debug_set_machine_event_thresholds(debugInstance,_LazoInternoMachineNumber_,
    0,0);
  sf_debug_set_machine_data_thresholds(debugInstance,_LazoInternoMachineNumber_,
    0);
}

void LazoInterno_register_exported_symbols(SimStruct* S)
{
}

static mxArray* sRtwOptimizationInfoStruct= NULL;
mxArray* load_LazoInterno_optimization_info(void)
{
  if (sRtwOptimizationInfoStruct==NULL) {
    sRtwOptimizationInfoStruct = sf_load_rtw_optimization_info("LazoInterno",
      "LazoInterno");
    mexMakeArrayPersistent(sRtwOptimizationInfoStruct);
  }

  return(sRtwOptimizationInfoStruct);
}

void unload_LazoInterno_optimization_info(void)
{
  if (sRtwOptimizationInfoStruct!=NULL) {
    mxDestroyArray(sRtwOptimizationInfoStruct);
    sRtwOptimizationInfoStruct = NULL;
  }
}
