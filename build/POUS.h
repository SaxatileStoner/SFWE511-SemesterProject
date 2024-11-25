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
INT SELECTISOLATIONVALVEVALUE(
  BOOL EN, 
  BOOL *__ENO, 
  BOOL SITEALARMOVERRIDE, 
  BOOL BOOSTERPUMPLOGICALSTATUS);
// FUNCTION
BOOL ISWITHIN5PERCENT(
  BOOL EN, 
  BOOL *__ENO, 
  INT IN0, 
  INT IN1);
// FUNCTION
BOOL SETFLOWSENSORALARM(
  BOOL EN, 
  BOOL *__ENO, 
  INT ISOLATIONVALVESTATUS, 
  INT FLOWRATESENSOR);
// PROGRAM DCSPROGRAMSECTOR
// Data part
typedef struct {
  // PROGRAM Interface - IN, OUT, IN_OUT variables

  // PROGRAM private variables - TEMP, private and located variables
  __DECLARE_EXTERNAL(INT,FLOWRATESENSOR0)
  __DECLARE_EXTERNAL(INT,FLOWRATESENSOR1)
  __DECLARE_EXTERNAL(INT,FLOWRATESENSOR2)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPSTATUS0)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPSTATUS1)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPSTATUS2)
  __DECLARE_EXTERNAL(INT,ISOLATIONVALVESTATUS0)
  __DECLARE_EXTERNAL(INT,ISOLATIONVALVESTATUS1)
  __DECLARE_EXTERNAL(INT,ISOLATIONVALVESTATUS2)
  __DECLARE_EXTERNAL(BOOL,GENERALSITEALARM0)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND0)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND1)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND2)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPALARM0)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPALARM1)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPALARM2)
  __DECLARE_EXTERNAL(BOOL,ISOLATIONVALVEALARM0)
  __DECLARE_EXTERNAL(BOOL,ISOLATIONVALVEALARM1)
  __DECLARE_EXTERNAL(BOOL,ISOLATIONVALVEALARM2)
  __DECLARE_EXTERNAL(BOOL,FLOWSENSORALARM0)
  __DECLARE_EXTERNAL(BOOL,FLOWSENSORALARM1)
  __DECLARE_EXTERNAL(BOOL,FLOWSENSORALARM2)
  __DECLARE_EXTERNAL(BOOL,EXCESSIVEFLOWALARM0)
  __DECLARE_EXTERNAL(BOOL,EXCESSIVEFLOWALARM1)
  __DECLARE_EXTERNAL(BOOL,EXCESSIVEFLOWALARM2)
  __DECLARE_EXTERNAL(INT,ISOLATIONVALVECOMMAND0)
  __DECLARE_EXTERNAL(INT,ISOLATIONVALVECOMMAND1)
  __DECLARE_EXTERNAL(INT,ISOLATIONVALVECOMMAND2)
  __DECLARE_EXTERNAL(INT,FLOW_SENSOR_MAX_CAPACITY)
  __DECLARE_VAR(REAL,_TMP_INT_TO_REAL52_OUT)
  __DECLARE_VAR(REAL,_TMP_MUL69_OUT)
  __DECLARE_VAR(INT,_TMP_REAL_TO_INT102_OUT)
  __DECLARE_VAR(BOOL,_TMP_GT4_OUT)
  __DECLARE_VAR(REAL,_TMP_INT_TO_REAL51_OUT)
  __DECLARE_VAR(REAL,_TMP_MUL5_OUT)
  __DECLARE_VAR(INT,_TMP_REAL_TO_INT49_OUT)
  __DECLARE_VAR(BOOL,_TMP_GT10_OUT)
  __DECLARE_VAR(REAL,_TMP_INT_TO_REAL114_OUT)
  __DECLARE_VAR(REAL,_TMP_MUL11_OUT)
  __DECLARE_VAR(INT,_TMP_REAL_TO_INT50_OUT)
  __DECLARE_VAR(BOOL,_TMP_GT8_OUT)
  __DECLARE_VAR(BOOL,_TMP_XOR24_OUT)
  __DECLARE_VAR(BOOL,_TMP_XOR27_OUT)
  __DECLARE_VAR(INT,_TMP_SELECTISOLATIONVALVEVALUE19_OUT)
  __DECLARE_VAR(INT,_TMP_SELECTISOLATIONVALVEVALUE25_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT68_OUT)
  __DECLARE_VAR(BOOL,_TMP_NOT79_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT57_OUT)
  __DECLARE_VAR(BOOL,_TMP_NOT80_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISWITHIN5PERCENT61_OUT)
  __DECLARE_VAR(BOOL,_TMP_NOT81_OUT)
  __DECLARE_VAR(BOOL,_TMP_XOR18_OUT)
  __DECLARE_VAR(INT,_TMP_SELECTISOLATIONVALVEVALUE92_OUT)
  __DECLARE_VAR(BOOL,_TMP_SETFLOWSENSORALARM100_OUT)
  __DECLARE_VAR(BOOL,_TMP_SETFLOWSENSORALARM44_OUT)
  __DECLARE_VAR(BOOL,_TMP_SETFLOWSENSORALARM46_OUT)
  __DECLARE_VAR(BOOL,_TMP_GT117_OUT)
  __DECLARE_VAR(BOOL,_TMP_GT74_OUT)
  __DECLARE_VAR(BOOL,_TMP_GT78_OUT)

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

  // FB private variables - TEMP, private and located variables
  TON TON1;
  TP TP1;
  R_TRIG R_TRIG0;

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
  __DECLARE_VAR(INT,DISTRIBUTIONPUMPSPEEDIN)
  __DECLARE_VAR(INT,DISPOSALVALVECOMMANDIN)
  __DECLARE_VAR(BOOL,OUT)
  __DECLARE_VAR(INT,DISTRIBUTIONPUMPSPEEDOUT)
  __DECLARE_VAR(INT,DISPOSALVALVECOMMANDOUT)

  // FB private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,_TMP_MOVE3_ENO)
  __DECLARE_VAR(INT,_TMP_MOVE3_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE6_ENO)
  __DECLARE_VAR(INT,_TMP_MOVE6_OUT)

} DISPOSALPROTOCOL;

void DISPOSALPROTOCOL_init__(DISPOSALPROTOCOL *data__, BOOL retain);
// Code part
void DISPOSALPROTOCOL_body__(DISPOSALPROTOCOL *data__);
// FUNCTION
INT SETDISTRIBUTIONPUMPSPEED(
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
  __DECLARE_EXTERNAL(INT,EDUCTORVALVESTATUS0)
  __DECLARE_EXTERNAL(INT,EDUCTORVALVESTATUS1)
  __DECLARE_EXTERNAL(INT,EDUCTORVALVESTATUS2)
  __DECLARE_EXTERNAL(INT,ULTRASONICTANKLEVELSENSOR0)
  __DECLARE_EXTERNAL(INT,ULTRASONICTANKLEVELSENSOR1)
  __DECLARE_EXTERNAL(INT,ULTRASONICTANKLEVELSENSOR2)
  __DECLARE_EXTERNAL(INT,DISPOSALVALVESTATUS)
  __DECLARE_EXTERNAL(BOOL,DISTRIBUTIONPUMPSTATUS)
  __DECLARE_EXTERNAL(BOOL,HIGHPRESSURESWITCH0)
  __DECLARE_EXTERNAL(BOOL,HIGHPRESSURESWITCH1)
  __DECLARE_EXTERNAL(BOOL,HIGHPRESSURESWITCH2)
  __DECLARE_EXTERNAL(INT,EDUCTORVALVECOMMAND0)
  __DECLARE_EXTERNAL(INT,EDUCTORVALVECOMMAND1)
  __DECLARE_EXTERNAL(INT,EDUCTORVALVECOMMAND2)
  __DECLARE_EXTERNAL(BOOL,EDUCTORVALVEALARM0)
  __DECLARE_EXTERNAL(BOOL,EDUCTORVALVEALARM1)
  __DECLARE_EXTERNAL(BOOL,EDUCTORVALVEALARM2)
  __DECLARE_EXTERNAL(BOOL,DISTRIBUTIONPUMPCOMMAND)
  __DECLARE_EXTERNAL(INT,DISTRIBUTIONPUMPSPEEDCOMMAND)
  __DECLARE_EXTERNAL(INT,DISPOSALVALVECOMMAND)
  __DECLARE_EXTERNAL(BOOL,DISTRIBUTIONPUMPPRESSUREREDUCTIONFLAG)
  __DECLARE_EXTERNAL(BOOL,TANK0_30CAPACITY)
  __DECLARE_EXTERNAL(BOOL,TANK1_30CAPACITY)
  __DECLARE_EXTERNAL(BOOL,TANK2_30CAPACITY)
  __DECLARE_EXTERNAL(BOOL,TANK0_60CAPACITY)
  __DECLARE_EXTERNAL(BOOL,TANK1_60CAPACITY)
  __DECLARE_EXTERNAL(BOOL,TANK2_60CAPACITY)
  __DECLARE_EXTERNAL(BOOL,TANK0_90CAPACITY)
  __DECLARE_EXTERNAL(BOOL,TANK1_90CAPACITY)
  __DECLARE_EXTERNAL(BOOL,TANK2_90CAPACITY)
  __DECLARE_EXTERNAL(BOOL,TANK0_DISPOSALREADY)
  __DECLARE_EXTERNAL(BOOL,TANK1_DISPOSALREADY)
  __DECLARE_EXTERNAL(BOOL,TANK2_DISPOSALREADY)
  __DECLARE_EXTERNAL(BOOL,ALLTANKSNEARCAPACITY)
  __DECLARE_EXTERNAL(BOOL,DISTRIBUTIONPUMPALARM)
  __DECLARE_EXTERNAL(BOOL,HIGHPRESSURESWITCHALARM0)
  __DECLARE_EXTERNAL(BOOL,HIGHPRESSURESWITCHALARM1)
  __DECLARE_EXTERNAL(BOOL,HIGHPRESSURESWITCHALARM2)
  __DECLARE_EXTERNAL(BOOL,ASKHMICONTAINMENTUNITATTACHED)
  __DECLARE_EXTERNAL(BOOL,ASKHMICONTAINMENTUNITFULL)
  __DECLARE_EXTERNAL(BOOL,DISPOSALVALVEALARM)
  __DECLARE_EXTERNAL(BOOL,TANK0_CAPACITYALARM)
  __DECLARE_EXTERNAL(BOOL,TANK1_CAPACITYALARM)
  __DECLARE_EXTERNAL(BOOL,TANK2_CAPACITYALARM)
  __DECLARE_EXTERNAL(BOOL,CENTRALTANKALARMSWITCH)
  __DECLARE_EXTERNAL(BOOL,CONTROLCENTERHORNSTROBEALARM)
  __DECLARE_EXTERNAL(BOOL,PHWARNINGHMI)
  __DECLARE_EXTERNAL(BOOL,PHCRITICALHMI)
  __DECLARE_EXTERNAL(BOOL,HMITANKDISPOSALBUTTON)
  __DECLARE_EXTERNAL(BOOL,ISCONTAINMENTUNITATTACHED)
  __DECLARE_EXTERNAL(BOOL,ISCONTAINMENTUNITFULL)
  __DECLARE_EXTERNAL(BOOL,STARTSTIRPROTOCOL0)
  __DECLARE_EXTERNAL(BOOL,STARTSTIRPROTOCOL1)
  __DECLARE_EXTERNAL(BOOL,STARTSTIRPROTOCOL2)
  __DECLARE_EXTERNAL(BOOL,STOPSTIRPROTOCOL0)
  __DECLARE_EXTERNAL(BOOL,STOPSTIRPROTOCOL1)
  __DECLARE_EXTERNAL(BOOL,STOPSTIRPROTOCOL2)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND0)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND1)
  __DECLARE_EXTERNAL(BOOL,BOOSTERPUMPCOMMAND2)
  __DECLARE_EXTERNAL(INT,ISOLATIONVALVECOMMAND0)
  __DECLARE_EXTERNAL(INT,ISOLATIONVALVECOMMAND1)
  __DECLARE_EXTERNAL(INT,ISOLATIONVALVECOMMAND2)
  __DECLARE_EXTERNAL(BOOL,PHALERTALARM)
  __DECLARE_EXTERNAL(BOOL,PHCRITICALALARM)
  TANK15MINUTERESET TANK15MINUTERESET0;
  DISPOSALPROTOCOL DISPOSALPROTOCOL0;
  DISPOSALPROTOCOL DISPOSALPROTOCOL1;
  TON TON0;
  RS RS0;
  TANK15MINUTERESET TANK15MINUTERESET1;
  RS RS1;
  TON TON1;
  TANK15MINUTERESET TANK15MINUTERESET2;
  RS RS2;
  TON TON2;
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
  __DECLARE_VAR(INT,_TMP_SETDISTRIBUTIONPUMPSPEED48_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE52_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE34_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE56_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE60_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE64_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE69_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE72_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE76_OUT)
  __DECLARE_VAR(BOOL,_TMP_GE81_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE146_ENO)
  __DECLARE_VAR(INT,_TMP_MOVE146_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE117_ENO)
  __DECLARE_VAR(INT,_TMP_MOVE117_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE132_ENO)
  __DECLARE_VAR(INT,_TMP_MOVE132_OUT)
  __DECLARE_VAR(BOOL,_TMP_NE184_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE200_ENO)
  __DECLARE_VAR(INT,_TMP_MOVE200_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE111_ENO)
  __DECLARE_VAR(INT,_TMP_MOVE111_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE143_ENO)
  __DECLARE_VAR(INT,_TMP_MOVE143_OUT)
  __DECLARE_VAR(BOOL,_TMP_MOVE156_ENO)
  __DECLARE_VAR(INT,_TMP_MOVE156_OUT)
  F_TRIG F_TRIG1;
  __DECLARE_VAR(INT,_TMP_SEL237_OUT)
  __DECLARE_VAR(BOOL,_TMP_INT_TO_BOOL251_OUT)
  F_TRIG F_TRIG2;
  __DECLARE_VAR(INT,_TMP_SEL97_OUT)
  __DECLARE_VAR(BOOL,_TMP_INT_TO_BOOL96_OUT)
  F_TRIG F_TRIG3;
  __DECLARE_VAR(INT,_TMP_SEL233_OUT)
  __DECLARE_VAR(BOOL,_TMP_INT_TO_BOOL232_OUT)

} SCADATANKLEVELPROGRAM;

void SCADATANKLEVELPROGRAM_init__(SCADATANKLEVELPROGRAM *data__, BOOL retain);
// Code part
void SCADATANKLEVELPROGRAM_body__(SCADATANKLEVELPROGRAM *data__);
// FUNCTION
BOOL ISOUTSIDEPHRANGE(
  BOOL EN, 
  BOOL *__ENO, 
  INT EVALULATEVARIN, 
  INT BASICMAX, 
  INT ACIDICMAX);
// PROGRAM SCADAPHTANKMONITORPROGRAM
// Data part
typedef struct {
  // PROGRAM Interface - IN, OUT, IN_OUT variables

  // PROGRAM private variables - TEMP, private and located variables
  __DECLARE_EXTERNAL(INT,PHSENSOR)
  __DECLARE_EXTERNAL(INT,WARNING_ACIDIC_LEVEL)
  __DECLARE_EXTERNAL(INT,CRITICAL_ACIDIC_LEVEL)
  __DECLARE_EXTERNAL(INT,WARNING_BASIC_LEVEL)
  __DECLARE_EXTERNAL(INT,CRITICAL_BASIC_LEVEL)
  __DECLARE_EXTERNAL(BOOL,PHALERTALARM)
  __DECLARE_EXTERNAL(BOOL,PHCRITICALALARM)
  __DECLARE_VAR(BOOL,_TMP_ISOUTSIDEPHRANGE4_OUT)
  __DECLARE_VAR(BOOL,_TMP_ISOUTSIDEPHRANGE9_OUT)

} SCADAPHTANKMONITORPROGRAM;

void SCADAPHTANKMONITORPROGRAM_init__(SCADAPHTANKMONITORPROGRAM *data__, BOOL retain);
// Code part
void SCADAPHTANKMONITORPROGRAM_body__(SCADAPHTANKMONITORPROGRAM *data__);
#endif //__POUS_H
