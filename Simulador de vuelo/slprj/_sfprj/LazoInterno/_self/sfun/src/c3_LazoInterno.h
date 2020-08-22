#ifndef __c3_LazoInterno_h__
#define __c3_LazoInterno_h__

/* Include files */
#include "sfc_sf.h"
#include "sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc3_LazoInternoInstanceStruct
#define typedef_SFc3_LazoInternoInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c3_sfEvent;
  boolean_T c3_isStable;
  boolean_T c3_doneDoubleBufferReInit;
  uint8_T c3_is_active_c3_LazoInterno;
} SFc3_LazoInternoInstanceStruct;

#endif                                 /*typedef_SFc3_LazoInternoInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c3_LazoInterno_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c3_LazoInterno_get_check_sum(mxArray *plhs[]);
extern void c3_LazoInterno_method_dispatcher(SimStruct *S, int_T method, void
  *data);

#endif
