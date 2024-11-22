#include "beremiz.h"
#ifndef __POUS_H
#define __POUS_H

#include "accessor.h"
#include "iec_std_lib.h"

__DECLARE_ENUMERATED_TYPE(LOGLEVEL,
  LOGLEVEL__CRITICAL,
  LOGLEVEL__WARNING,
  LOGLEVEL__INFO,
  LOGLEVEL__DEBUG
)
// FUNCTION_BLOCK LOGGER
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(BOOL,TRIG)
  __DECLARE_VAR(STRING,MSG)
  __DECLARE_VAR(LOGLEVEL,LEVEL)

  // FB private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,TRIG0)

} LOGGER;

void LOGGER_init__(LOGGER *data__, BOOL retain);
// Code part
void LOGGER_body__(LOGGER *data__);
// FUNCTION
REAL SELECTISOLATIONVALVEVALUE(
  BOOL EN, 
  BOOL *__ENO, 
  BOOL SITEALARMOVERRIDE, 
  BOOL BOOSTERPUMPLOGICALSTATUS);
// FUNCTION
BOOL ISWITHIN5PERCENT(
  BOOL EN, 
  BOOL *__ENO, 
  REAL IN0, 
  REAL IN1);
// FUNCTION
BOOL SETFLOWSENSORALARM(
  BOOL EN, 
  BOOL *__ENO, 
  REAL ISOLATIONVALVESTATUS, 
  REAL FLOWRATESENSOR);
// PROGRAM DCSPROGRAMSECTOR
// Data part
typedef struct {
  // PROGRAM Interface - IN, OUT, IN_OUT variables

  // PROGRAM private variables - TEMP, private and located variables
  __DECLARE_LOCATED(REAL,FLOWRATESENSOR0)
  __DECLARE_LOCATED(REAL,FLOWRATESENSOR1)
  __DECLARE_LOCATED(REAL,FLOWRATESENSOR2)
  __DECLARE_LOCATED(BOOL,BOOSTERPUMPSTATUS0)
  __DECLARE_LOCATED(BOOL,BOOSTERPUMPSTATUS1)
  __DECLARE_LOCATED(BOOL,BOOSTERPUMPSTATUS2)
  __DECLARE_LOCATED(REAL,ISOLATIONVALVESTATUS0)
  __DECLARE_LOCATED(REAL,ISOLATIONVALVESTATUS1)
  __DECLARE_LOCATED(REAL,ISOLATIONVALVESTATUS2)
  __DECLARE_LOCATED(BOOL,GENERALSITEALARM0)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND0)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND1)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND2)
  __DECLARE_LOCATED(BOOL,BOOSTERPUMPALARM0)
  __DECLARE_LOCATED(BOOL,BOOSTERPUMPALARM1)
  __DECLARE_LOCATED(BOOL,BOOSTERPUMPALARM2)
  __DECLARE_LOCATED(BOOL,ISOLATIONVALVEALARM0)
  __DECLARE_LOCATED(BOOL,ISOLATIONVALVEALARM1)
  __DECLARE_LOCATED(BOOL,ISOLATIONVALVEALARM2)
  __DECLARE_LOCATED(BOOL,FLOWSENSORALARM0)
  __DECLARE_LOCATED(BOOL,FLOWSENSORALARM1)
  __DECLARE_LOCATED(BOOL,FLOWSENSORALARM2)
  __DECLARE_EXTERNAL(REAL,ISOLATIONVALVECOMMAND0)
  __DECLARE_EXTERNAL(REAL,ISOLATIONVALVECOMMAND1)
  __DECLARE_EXTERNAL(REAL,ISOLATIONVALVECOMMAND2)
  __DECLARE_LOCATED(REAL,FLOWSENSORMAXCAPACITY)
  __DECLARE_VAR(REAL,_TMP_MUL69_OUT)
  __DECLARE_VAR(BOOL,_TMP_GT4_OUT)
  __DECLARE_VAR(REAL,_TMP_MUL5_OUT)
  __DECLARE_VAR(BOOL,_TMP_GT10_OUT)
  __DECLARE_VAR(REAL,_TMP_MUL11_OUT)
  __DECLARE_VAR(BOOL,_TMP_GT8_OUT)
  __DECLARE_VAR(BOOL,_TMP_XOR24_OUT)
  __DECLARE_VAR(BOOL,_TMP_XOR27_OUT)
  __DECLARE_VAR(REAL,_TMP_SELECTISOLATIONVALVEVALUE19_OUT)
  __DECLARE_VAR(REAL,_TMP_SELECTISOLATIONVALVEVALUE25_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT68_OUT)
  __DECLARE_VAR(BOOL,_TMP_NOT79_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT57_OUT)
  __DECLARE_VAR(BOOL,_TMP_NOT80_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT61_OUT)
  __DECLARE_VAR(BOOL,_TMP_NOT81_OUT)
  __DECLARE_VAR(BOOL,_TMP_XOR18_OUT)
  __DECLARE_VAR(REAL,_TMP_SELECTISOLATIONVALVEVALUE92_OUT)
  __DECLARE_VAR(BOOL,_TMP_SETFLOWSENSORALARM100_OUT)
  __DECLARE_VAR(BOOL,_TMP_SETFLOWSENSORALARM44_OUT)
  __DECLARE_VAR(BOOL,_TMP_SETFLOWSENSORALARM46_OUT)

} DCSPROGRAMSECTOR;

void DCSPROGRAMSECTOR_init__(DCSPROGRAMSECTOR *data__, BOOL retain);
// Code part
void DCSPROGRAMSECTOR_body__(DCSPROGRAMSECTOR *data__);
// FUNCTION_BLOCK TANK15MINUTERESET
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(BOOL,PULSEIN)
  __DECLARE_VAR(BOOL,DISTRIBUTIONPUMPOUT)
  __DECLARE_VAR(REAL,EDUCTORVALVEOUT)

  // FB private variables - TEMP, private and located variables
  TON TON1;
  TP TP1;
  __DECLARE_VAR(BOOL,_TMP_MOVE100_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE100_OUT)

} TANK15MINUTERESET;

void TANK15MINUTERESET_init__(TANK15MINUTERESET *data__, BOOL retain);
// Code part
void TANK15MINUTERESET_body__(TANK15MINUTERESET *data__);
// FUNCTION_BLOCK DISPOSALPROTOCOL
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(BOOL,IN)
  __DECLARE_VAR(REAL,DISTRIBUTIONPUMPSPEEDIN)
  __DECLARE_VAR(REAL,DISPOSALVALVECOMMANDIN)
  __DECLARE_VAR(BOOL,OUT)
  __DECLARE_VAR(REAL,DISTRIBUTIONPUMPSPEEDOUT)
  __DECLARE_VAR(REAL,DISPOSALVALVECOMMANDOUT)

  // FB private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,_TMP_MOVE3_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE3_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE6_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE6_OUT)

} DISPOSALPROTOCOL;

void DISPOSALPROTOCOL_init__(DISPOSALPROTOCOL *data__, BOOL retain);
// Code part
void DISPOSALPROTOCOL_body__(DISPOSALPROTOCOL *data__);
// FUNCTION
REAL SETDISTRIBUTIONPUMPSPEED(
  BOOL EN, 
  BOOL *__ENO, 
  BOOL ISEDUCTORVALVE0OPEN, 
  BOOL ISEDUCTORVALVE1OPEN, 
  BOOL ISEDUCTORVALVE2OPEN, 
  BOOL ISDISTRIBUTIONPUMPSPEEDREDUCTION);
// PROGRAM SCADATANKLEVELPROGRAM
// Data part
typedef struct {
  // PROGRAM Interface - IN, OUT, IN_OUT variables

  // PROGRAM private variables - TEMP, private and located variables
  __DECLARE_LOCATED(REAL,EDUCTORVALVESTATUS0)
  __DECLARE_LOCATED(REAL,EDUCTORVALVESTATUS1)
  __DECLARE_LOCATED(REAL,EDUCTORVALVESTATUS2)
  __DECLARE_LOCATED(REAL,ULTRASONICTANKLEVELSENSOR0)
  __DECLARE_LOCATED(REAL,ULTRASONICTANKLEVELSENSOR1)
  __DECLARE_LOCATED(REAL,ULTRASONICTANKLEVELSENSOR2)
  __DECLARE_LOCATED(REAL,DISPOSALVALVESTATUS)
  __DECLARE_LOCATED(BOOL,DISTRIBUTIONPUMPSTATUS)
  __DECLARE_LOCATED(BOOL,HIGHPRESSURESWITCH0)
  __DECLARE_LOCATED(BOOL,HIGHPRESSURESWITCH1)
  __DECLARE_LOCATED(BOOL,HIGHPRESSURESWITCH2)
  __DECLARE_LOCATED(BOOL,ISCONTAINMENTUNITATTACHED)
  __DECLARE_LOCATED(BOOL,ISCONTAINMENTUNITFULL)
  __DECLARE_LOCATED(REAL,EDUCTORVALVECOMMAND0)
  __DECLARE_LOCATED(REAL,EDUCTORVALVECOMMAND1)
  __DECLARE_LOCATED(REAL,EDUCTORVALVECOMMAND2)
  __DECLARE_LOCATED(BOOL,EDUCTORVALVEALARM0)
  __DECLARE_LOCATED(BOOL,EDUCTORVALVEALARM1)
  __DECLARE_LOCATED(BOOL,EDUCTORVALVEALARM2)
  __DECLARE_LOCATED(BOOL,DISTRIBUTIONPUMPCOMMAND)
  __DECLARE_LOCATED(REAL,DISTRIBUTIONPUMPSPEEDCOMMAND)
  __DECLARE_LOCATED(REAL,DISPOSALVALVECOMMAND)
  __DECLARE_LOCATED(BOOL,DISTRIBUTIONPUMPPRESSUREREDUCTIONFLAG)
  __DECLARE_LOCATED(BOOL,TANK30CAPACITY0)
  __DECLARE_LOCATED(BOOL,TANK30CAPACITY1)
  __DECLARE_LOCATED(BOOL,TANK30CAPACITY2)
  __DECLARE_LOCATED(BOOL,TANK60CAPACITY0)
  __DECLARE_LOCATED(BOOL,TANK60CAPACITY1)
  __DECLARE_LOCATED(BOOL,TANK60CAPACITY2)
  __DECLARE_LOCATED(BOOL,TANK90CAPACITY0)
  __DECLARE_LOCATED(BOOL,TANK90CAPACITY1)
  __DECLARE_LOCATED(BOOL,TANK90CAPACITY2)
  __DECLARE_LOCATED(BOOL,ISTANK0DISPOSALREADY)
  __DECLARE_LOCATED(BOOL,ISTANK1DISPOSALREADY)
  __DECLARE_LOCATED(BOOL,ISTANK2DISPOSALREADY)
  __DECLARE_LOCATED(BOOL,ALLTANKSNEARCAPACITY)
  __DECLARE_LOCATED(BOOL,DISTRIBUTIONPUMPALARM)
  __DECLARE_LOCATED(BOOL,HIGHPRESSURESWITCHALARM0)
  __DECLARE_LOCATED(BOOL,HIGHPRESSURESWITCHALARM1)
  __DECLARE_LOCATED(BOOL,HIGHPRESSURESWITCHALARM2)
  __DECLARE_LOCATED(BOOL,ASKHMICONTAINMENTUNITATTACHED)
  __DECLARE_LOCATED(BOOL,ASKHMICONTAINMENTUNITFULL)
  __DECLARE_LOCATED(BOOL,DISPOSALVALVEALARM)
  __DECLARE_LOCATED(BOOL,TANKCAPACITYALARM0)
  __DECLARE_LOCATED(BOOL,TANKCAPACITYALARM1)
  __DECLARE_LOCATED(BOOL,TANKCAPACITYALARM2)
  __DECLARE_LOCATED(BOOL,CENTRALTANKALARMSWITCH)
  __DECLARE_LOCATED(BOOL,CONTROLCENTERHORNSTROBEALARM)
  __DECLARE_LOCATED(BOOL,PHWARNINGHMI)
  __DECLARE_LOCATED(BOOL,PHCRITICALHMI)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND0)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND1)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND2)
  __DECLARE_EXTERNAL(REAL,ISOLATIONVALVECOMMAND0)
  __DECLARE_EXTERNAL(REAL,ISOLATIONVALVECOMMAND1)
  __DECLARE_EXTERNAL(REAL,ISOLATIONVALVECOMMAND2)
  __DECLARE_EXTERNAL(BOOL,PHALERTALARM)
  __DECLARE_EXTERNAL(BOOL,PHCRITICALALARM)
  TANK15MINUTERESET TANK15MINUTERESET0;
  TANK15MINUTERESET TANK15MINUTERESET1;
  TANK15MINUTERESET TANK15MINUTERESET2;
  DISPOSALPROTOCOL DISPOSALPROTOCOL0;
  DISPOSALPROTOCOL DISPOSALPROTOCOL1;
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT3_OUT)
  __DECLARE_VAR(BOOL,_TMP_NOT4_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT10_OUT)
  __DECLARE_VAR(BOOL,_TMP_NOT11_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT15_OUT)
  __DECLARE_VAR(BOOL,_TMP_NOT14_OUT)
  __DECLARE_VAR(BOOL,_TMP_XOR23_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT42_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT30_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT31_OUT)
  __DECLARE_VAR(REAL,_TMP_SETDISTRIBUTIONPUMPSPEED48_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE52_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE34_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE56_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE60_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE64_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE69_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE72_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE76_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE81_OUT)
  R_TRIG R_TRIG1;
  __DECLARE_VAR(BOOL,_TMP_MOVE84_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE84_OUT)
  R_TRIG R_TRIG2;
  __DECLARE_VAR(BOOL,_TMP_MOVE89_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE89_OUT)
  R_TRIG R_TRIG3;
  __DECLARE_VAR(BOOL,_TMP_MOVE94_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE94_OUT)
  R_TRIG R_TRIG4;
  R_TRIG R_TRIG5;
  R_TRIG R_TRIG6;
  __DECLARE_VAR(BOOL,_TMP_MOVE146_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE146_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE117_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE117_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE132_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE132_OUT)
  __DECLARE_VAR(BOOL,_TMP_NE184_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE200_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE200_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE111_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE111_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE143_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE143_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE156_ENO)
  __DECLARE_VAR(REAL,_TMP_MOVE156_OUT)

} SCADATANKLEVELPROGRAM;

void SCADATANKLEVELPROGRAM_init__(SCADATANKLEVELPROGRAM *data__, BOOL retain);
// Code part
void SCADATANKLEVELPROGRAM_body__(SCADATANKLEVELPROGRAM *data__);
// FUNCTION
BOOL ISOUTSIDEPHRANGE(
  BOOL EN, 
  BOOL *__ENO, 
  REAL EVALULATEVARIN, 
  REAL BASICMAX, 
  REAL ACIDICMAX);
// PROGRAM SCADAPHTANKMONITORPROGRAM
// Data part
typedef struct {
  // PROGRAM Interface - IN, OUT, IN_OUT variables

  // PROGRAM private variables - TEMP, private and located variables
  __DECLARE_LOCATED(REAL,PHSENSOR)
  __DECLARE_LOCATED(REAL,ACIDICLEVEL)
  __DECLARE_LOCATED(REAL,CRITICALACIDICLEVEL)
  __DECLARE_LOCATED(REAL,BASICLEVEL)
  __DECLARE_LOCATED(REAL,CRITICALBASICLEVEL)
  __DECLARE_EXTERNAL(BOOL,PHALERTALARM)
  __DECLARE_EXTERNAL(BOOL,PHCRITICALALARM)
  __DECLARE_VAR(BOOL,_TMP_ISOUTSIDEPHRANGE4_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISOUTSIDEPHRANGE9_OUT)

} SCADAPHTANKMONITORPROGRAM;

void SCADAPHTANKMONITORPROGRAM_init__(SCADAPHTANKMONITORPROGRAM *data__, BOOL retain);
// Code part
void SCADAPHTANKMONITORPROGRAM_body__(SCADAPHTANKMONITORPROGRAM *data__);
#endif //__POUS_H
