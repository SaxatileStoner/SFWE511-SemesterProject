FUNCTION SelectIsolationValveValue : INT
  VAR_INPUT
    SiteAlarmOverride : BOOL;
    BoosterPumpLogicalStatus : BOOL;
  END_VAR
  VAR
    _TMP_SEL5_OUT : INT;
    _TMP_SEL6_OUT : INT;
  END_VAR

  _TMP_SEL5_OUT := SEL(BoosterPumpLogicalStatus, 50, 100);
  _TMP_SEL6_OUT := SEL(SiteAlarmOverride, _TMP_SEL5_OUT, 0);
  SelectIsolationValveValue := _TMP_SEL6_OUT;
END_FUNCTION

FUNCTION isWithin5Percent : BOOL
  VAR_INPUT
    In0 : INT;
    In1 : INT;
  END_VAR
  VAR
    RangeHigh : INT;
    RangeLow : INT;
    In0IsLessThanHigh : BOOL;
    In0IsGreaterThanLow : BOOL;
    _TMP_SUB3_OUT : INT;
    _TMP_ADD7_OUT : INT;
    _TMP_MIN23_OUT : INT;
    _TMP_LE10_OUT : BOOL;
    _TMP_GE14_OUT : BOOL;
  END_VAR

  _TMP_SUB3_OUT := SUB(In0, 5);
  RangeLow := _TMP_SUB3_OUT;
  _TMP_ADD7_OUT := ADD(In0, 5);
  _TMP_MIN23_OUT := MIN(_TMP_ADD7_OUT, 100);
  RangeHigh := _TMP_MIN23_OUT;
  _TMP_LE10_OUT := LE(In1, RangeHigh);
  In0IsLessThanHigh := _TMP_LE10_OUT;
  _TMP_GE14_OUT := GE(In1, RangeLow);
  In0IsGreaterThanLow := _TMP_GE14_OUT;
  isWithin5Percent := In0IsLessThanHigh AND In0IsGreaterThanLow;
END_FUNCTION

FUNCTION SetFlowSensorAlarm : BOOL
  VAR_INPUT
    IsolationValveStatus : INT;
    FlowRateSensor : INT;
  END_VAR
  VAR
    _TMP_EQ97_OUT : BOOL;
    _TMP_GT95_OUT : BOOL;
    _TMP_AND98_OUT : BOOL;
  END_VAR

  _TMP_EQ97_OUT := EQ(IsolationValveStatus, 0);
  _TMP_GT95_OUT := GT(FlowRateSensor, 0);
  _TMP_AND98_OUT := AND(_TMP_EQ97_OUT, _TMP_GT95_OUT);
  SetFlowSensorAlarm := _TMP_AND98_OUT;
END_FUNCTION

PROGRAM DCSProgramSector
  VAR_EXTERNAL
    FlowRateSensor0 : INT;
    FlowRateSensor1 : INT;
    FlowRateSensor2 : INT;
    BoosterPumpStatus0 : BOOL;
    BoosterPumpStatus1 : BOOL;
    BoosterPumpStatus2 : BOOL;
    IsolationValveStatus0 : INT;
    IsolationValveStatus1 : INT;
    IsolationValveStatus2 : INT;
    GeneralSiteAlarm0 : BOOL;
    BoosterPumpCommand0 : BOOL;
    BoosterPumpCommand1 : BOOL;
    BoosterPumpCommand2 : BOOL;
    BoosterPumpAlarm0 : BOOL;
    BoosterPumpAlarm1 : BOOL;
    BoosterPumpAlarm2 : BOOL;
    IsolationValveAlarm0 : BOOL;
    IsolationValveAlarm1 : BOOL;
    IsolationValveAlarm2 : BOOL;
    FlowSensorAlarm0 : BOOL;
    FlowSensorAlarm1 : BOOL;
    FlowSensorAlarm2 : BOOL;
    ExcessiveFlowAlarm0 : BOOL;
    ExcessiveFlowAlarm1 : BOOL;
    ExcessiveFlowAlarm2 : BOOL;
    IsolationValveCommand0 : INT;
    IsolationValveCommand1 : INT;
    IsolationValveCommand2 : INT;
  END_VAR
  VAR_EXTERNAL CONSTANT
    FLOW_SENSOR_MAX_CAPACITY : INT;
  END_VAR
  VAR
    _TMP_INT_TO_REAL52_OUT : REAL;
    _TMP_MUL69_OUT : REAL;
    _TMP_REAL_TO_INT102_OUT : INT;
    _TMP_GT4_OUT : BOOL;
    _TMP_INT_TO_REAL51_OUT : REAL;
    _TMP_MUL5_OUT : REAL;
    _TMP_REAL_TO_INT49_OUT : INT;
    _TMP_GT10_OUT : BOOL;
    _TMP_INT_TO_REAL114_OUT : REAL;
    _TMP_MUL11_OUT : REAL;
    _TMP_REAL_TO_INT50_OUT : INT;
    _TMP_GT8_OUT : BOOL;
    _TMP_XOR24_OUT : BOOL;
    _TMP_XOR27_OUT : BOOL;
    _TMP_SelectIsolationValveValue19_OUT : INT;
    _TMP_SelectIsolationValveValue25_OUT : INT;
    _TMP_isWithin5Percent68_OUT : BOOL;
    _TMP_NOT79_OUT : BOOL;
    _TMP_isWithin5Percent57_OUT : BOOL;
    _TMP_NOT80_OUT : BOOL;
    _TMP_isWithin5Percent61_OUT : BOOL;
    _TMP_NOT81_OUT : BOOL;
    _TMP_XOR18_OUT : BOOL;
    _TMP_SelectIsolationValveValue92_OUT : INT;
    _TMP_SetFlowSensorAlarm100_OUT : BOOL;
    _TMP_SetFlowSensorAlarm44_OUT : BOOL;
    _TMP_SetFlowSensorAlarm46_OUT : BOOL;
    _TMP_GT117_OUT : BOOL;
    _TMP_GT74_OUT : BOOL;
    _TMP_GT78_OUT : BOOL;
  END_VAR

  _TMP_INT_TO_REAL52_OUT := INT_TO_REAL(FLOW_SENSOR_MAX_CAPACITY);
  _TMP_MUL69_OUT := MUL(_TMP_INT_TO_REAL52_OUT, 0.2);
  _TMP_REAL_TO_INT102_OUT := REAL_TO_INT(_TMP_MUL69_OUT);
  _TMP_GT4_OUT := GT(FlowRateSensor0, _TMP_REAL_TO_INT102_OUT);
  BoosterPumpCommand0 := NOT(GeneralSiteAlarm0) AND _TMP_GT4_OUT;
  _TMP_INT_TO_REAL51_OUT := INT_TO_REAL(FLOW_SENSOR_MAX_CAPACITY);
  _TMP_MUL5_OUT := MUL(_TMP_INT_TO_REAL51_OUT, 0.2);
  _TMP_REAL_TO_INT49_OUT := REAL_TO_INT(_TMP_MUL5_OUT);
  _TMP_GT10_OUT := GT(FlowRateSensor1, _TMP_REAL_TO_INT49_OUT);
  BoosterPumpCommand1 := NOT(GeneralSiteAlarm0) AND _TMP_GT10_OUT;
  _TMP_INT_TO_REAL114_OUT := INT_TO_REAL(FLOW_SENSOR_MAX_CAPACITY);
  _TMP_MUL11_OUT := MUL(_TMP_INT_TO_REAL114_OUT, 0.2);
  _TMP_REAL_TO_INT50_OUT := REAL_TO_INT(_TMP_MUL11_OUT);
  _TMP_GT8_OUT := GT(FlowRateSensor2, _TMP_REAL_TO_INT50_OUT);
  BoosterPumpCommand2 := NOT(GeneralSiteAlarm0) AND _TMP_GT8_OUT;
  _TMP_XOR24_OUT := XOR(BoosterPumpCommand0, BoosterPumpStatus0);
  BoosterPumpAlarm0 := _TMP_XOR24_OUT;
  _TMP_XOR27_OUT := XOR(BoosterPumpCommand2, BoosterPumpStatus2);
  BoosterPumpAlarm2 := _TMP_XOR27_OUT;
  _TMP_SelectIsolationValveValue19_OUT := SelectIsolationValveValue(GeneralSiteAlarm0, BoosterPumpStatus1 AND NOT(BoosterPumpAlarm1));
  IsolationValveCommand1 := _TMP_SelectIsolationValveValue19_OUT;
  _TMP_SelectIsolationValveValue25_OUT := SelectIsolationValveValue(GeneralSiteAlarm0, BoosterPumpStatus2 AND NOT(BoosterPumpAlarm2));
  IsolationValveCommand2 := _TMP_SelectIsolationValveValue25_OUT;
  _TMP_isWithin5Percent68_OUT := isWithin5Percent(IsolationValveCommand0, IsolationValveStatus0);
  _TMP_NOT79_OUT := NOT(_TMP_isWithin5Percent68_OUT);
  IsolationValveAlarm0 := _TMP_NOT79_OUT;
  _TMP_isWithin5Percent57_OUT := isWithin5Percent(IsolationValveCommand1, IsolationValveStatus1);
  _TMP_NOT80_OUT := NOT(_TMP_isWithin5Percent57_OUT);
  IsolationValveAlarm1 := _TMP_NOT80_OUT;
  _TMP_isWithin5Percent61_OUT := isWithin5Percent(IsolationValveCommand2, IsolationValveStatus2);
  _TMP_NOT81_OUT := NOT(_TMP_isWithin5Percent61_OUT);
  IsolationValveAlarm2 := _TMP_NOT81_OUT;
  _TMP_XOR18_OUT := XOR(BoosterPumpCommand1, BoosterPumpStatus1);
  BoosterPumpAlarm1 := _TMP_XOR18_OUT;
  _TMP_SelectIsolationValveValue92_OUT := SelectIsolationValveValue(GeneralSiteAlarm0, BoosterPumpStatus0 AND NOT(BoosterPumpAlarm0));
  IsolationValveCommand0 := _TMP_SelectIsolationValveValue92_OUT;
  _TMP_SetFlowSensorAlarm100_OUT := SetFlowSensorAlarm(IsolationValveStatus0, FlowRateSensor0);
  FlowSensorAlarm0 := _TMP_SetFlowSensorAlarm100_OUT;
  _TMP_SetFlowSensorAlarm44_OUT := SetFlowSensorAlarm(IsolationValveStatus1, FlowRateSensor1);
  FlowSensorAlarm1 := _TMP_SetFlowSensorAlarm44_OUT;
  _TMP_SetFlowSensorAlarm46_OUT := SetFlowSensorAlarm(IsolationValveStatus2, FlowRateSensor2);
  FlowSensorAlarm2 := _TMP_SetFlowSensorAlarm46_OUT;
  IsolationValveStatus0 := _TMP_SelectIsolationValveValue92_OUT;
  IsolationValveStatus1 := _TMP_SelectIsolationValveValue19_OUT;
  IsolationValveStatus2 := _TMP_SelectIsolationValveValue25_OUT;
  BoosterPumpStatus0 := NOT(GeneralSiteAlarm0) AND _TMP_GT4_OUT;
  BoosterPumpStatus1 := NOT(GeneralSiteAlarm0) AND _TMP_GT10_OUT;
  BoosterPumpStatus2 := NOT(GeneralSiteAlarm0) AND _TMP_GT8_OUT;
  _TMP_GT117_OUT := GT(FlowRateSensor0, FLOW_SENSOR_MAX_CAPACITY);
  ExcessiveFlowAlarm0 := _TMP_GT117_OUT;
  _TMP_GT74_OUT := GT(FlowRateSensor1, FLOW_SENSOR_MAX_CAPACITY);
  ExcessiveFlowAlarm1 := _TMP_GT74_OUT;
  _TMP_GT78_OUT := GT(FlowRateSensor2, FLOW_SENSOR_MAX_CAPACITY);
  ExcessiveFlowAlarm2 := _TMP_GT78_OUT;
END_PROGRAM

FUNCTION SetDistributionPumpSpeed : INT
  VAR_INPUT
    isEductorValve0Open : BOOL;
    isEductorValve1Open : BOOL;
    isEductorValve2Open : BOOL;
    isDistributionPumpSpeedReduction : BOOL;
  END_VAR
  VAR
    _TMP_MOVE7_ENO : BOOL;
    _TMP_MOVE7_OUT : INT;
    _TMP_MOVE8_ENO : BOOL;
    _TMP_MOVE8_OUT : INT;
    _TMP_ADD11_OUT : INT;
    _TMP_MOVE9_ENO : BOOL;
    _TMP_MOVE9_OUT : INT;
    _TMP_MOVE10_ENO : BOOL;
    _TMP_MOVE10_OUT : INT;
    _TMP_ADD12_OUT : INT;
    _TMP_ADD13_OUT : INT;
    _TMP_MAX15_OUT : INT;
  END_VAR

  _TMP_MOVE7_OUT := MOVE(EN := isEductorValve0Open, IN := 30, ENO => _TMP_MOVE7_ENO);
  _TMP_MOVE8_OUT := MOVE(EN := isEductorValve1Open, IN := 30, ENO => _TMP_MOVE8_ENO);
  _TMP_ADD11_OUT := ADD(_TMP_MOVE7_OUT, _TMP_MOVE8_OUT);
  _TMP_MOVE9_OUT := MOVE(EN := isEductorValve2Open, IN := 30, ENO => _TMP_MOVE9_ENO);
  _TMP_MOVE10_OUT := MOVE(EN := isDistributionPumpSpeedReduction, IN := -30, ENO => _TMP_MOVE10_ENO);
  _TMP_ADD12_OUT := ADD(_TMP_MOVE9_OUT, _TMP_MOVE10_OUT);
  _TMP_ADD13_OUT := ADD(_TMP_ADD11_OUT, _TMP_ADD12_OUT);
  _TMP_MAX15_OUT := MAX(_TMP_ADD13_OUT, 0);
  SetDistributionPumpSpeed := _TMP_MAX15_OUT;
END_FUNCTION

PROGRAM SCADATankLevelProgram
  VAR_EXTERNAL
    EductorValveStatus0 : INT;
    EductorValveStatus1 : INT;
    EductorValveStatus2 : INT;
    DisposalValveStatus : INT;
    DistributionPumpStatus : BOOL;
    HighPressureSwitch0 : BOOL;
    HighPressureSwitch1 : BOOL;
    HighPressureSwitch2 : BOOL;
    EductorValveCommand0 : INT;
    EductorValveCommand1 : INT;
    EductorValveCommand2 : INT;
    EductorValveAlarm0 : BOOL;
    EductorValveAlarm1 : BOOL;
    EductorValveAlarm2 : BOOL;
    DistributionPumpCommand : BOOL;
    DistributionPumpSpeedCommand : INT;
    DisposalValveCommand : INT;
    DistributionPumpPressureReductionFlag : BOOL;
    Tank0_30Capacity : BOOL;
    Tank1_30Capacity : BOOL;
    Tank2_30Capacity : BOOL;
    Tank0_60Capacity : BOOL;
    Tank1_60Capacity : BOOL;
    Tank2_60Capacity : BOOL;
    Tank0_90Capacity : BOOL;
    Tank1_90Capacity : BOOL;
    Tank2_90Capacity : BOOL;
    Tank0_DisposalReady : BOOL;
    Tank1_DisposalReady : BOOL;
    Tank2_DisposalReady : BOOL;
    AllTanksNearCapacity : BOOL;
    DistributionPumpAlarm : BOOL;
    HighPressureSwitchAlarm0 : BOOL;
    HighPressureSwitchAlarm1 : BOOL;
    HighPressureSwitchAlarm2 : BOOL;
    askHMIContainmentUnitAttached : BOOL;
    askHMIContainmentUnitFull : BOOL;
    DisposalValveAlarm : BOOL;
    Tank0_CapacityAlarm : BOOL;
    Tank1_CapacityAlarm : BOOL;
    Tank2_CapacityAlarm : BOOL;
    CentralTankAlarmSwitch : BOOL;
    ControlCenterHornStrobeAlarm : BOOL;
    pHWarningHMI : BOOL;
    pHCriticalHMI : BOOL;
    HMITankDisposalButton : BOOL;
    isContainmentUnitAttached : BOOL;
    isContainmentUnitFull : BOOL;
    BoosterPumpCommand0 : BOOL;
    BoosterPumpCommand1 : BOOL;
    BoosterPumpCommand2 : BOOL;
    IsolationValveCommand0 : INT;
    IsolationValveCommand1 : INT;
    IsolationValveCommand2 : INT;
    pHAlertAlarm : BOOL;
    pHCriticalAlarm : BOOL;
  END_VAR
  VAR
    _TMP_isWithin5Percent3_OUT : BOOL;
    _TMP_NOT4_OUT : BOOL;
    _TMP_isWithin5Percent10_OUT : BOOL;
    _TMP_NOT11_OUT : BOOL;
    _TMP_isWithin5Percent15_OUT : BOOL;
    _TMP_NOT14_OUT : BOOL;
    _TMP_XOR23_OUT : BOOL;
    _TMP_isWithin5Percent42_OUT : BOOL;
    _TMP_isWithin5Percent30_OUT : BOOL;
    _TMP_isWithin5Percent31_OUT : BOOL;
    _TMP_SetDistributionPumpSpeed48_OUT : INT;
    _TMP_NE184_OUT : BOOL;
    _TMP_SEL269_OUT : INT;
    _TMP_SEL33_OUT : INT;
    _TMP_SEL52_OUT : INT;
    _TMP_SEL57_OUT : INT;
    _TMP_SEL62_OUT : INT;
    _TMP_SEL67_OUT : INT;
    _TMP_SEL72_OUT : INT;
    _TMP_SEL77_OUT : INT;
    _TMP_SEL82_OUT : INT;
    _TMP_SEL87_OUT : INT;
    _TMP_SEL92_OUT : INT;
    _TMP_SEL97_OUT : INT;
  END_VAR

  _TMP_isWithin5Percent3_OUT := isWithin5Percent(EductorValveCommand0, EductorValveStatus0);
  _TMP_NOT4_OUT := NOT(_TMP_isWithin5Percent3_OUT);
  EductorValveAlarm0 := _TMP_NOT4_OUT;
  _TMP_isWithin5Percent10_OUT := isWithin5Percent(EductorValveCommand1, EductorValveStatus1);
  _TMP_NOT11_OUT := NOT(_TMP_isWithin5Percent10_OUT);
  EductorValveAlarm1 := _TMP_NOT11_OUT;
  _TMP_isWithin5Percent15_OUT := isWithin5Percent(EductorValveCommand2, EductorValveStatus2);
  _TMP_NOT14_OUT := NOT(_TMP_isWithin5Percent15_OUT);
  EductorValveAlarm2 := _TMP_NOT14_OUT;
  _TMP_XOR23_OUT := XOR(DistributionPumpCommand, DistributionPumpStatus);
  DistributionPumpAlarm := _TMP_XOR23_OUT;
  HighPressureSwitchAlarm0 := HighPressureSwitch0;
  HighPressureSwitchAlarm1 := HighPressureSwitch1;
  HighPressureSwitchAlarm2 := HighPressureSwitch2;
  DistributionPumpPressureReductionFlag := HighPressureSwitch0 OR HighPressureSwitch1 OR HighPressureSwitch2;
  _TMP_isWithin5Percent42_OUT := isWithin5Percent(EductorValveStatus0, 100);
  _TMP_isWithin5Percent30_OUT := isWithin5Percent(EductorValveStatus1, 100);
  _TMP_isWithin5Percent31_OUT := isWithin5Percent(EductorValveStatus2, 100);
  _TMP_SetDistributionPumpSpeed48_OUT := SetDistributionPumpSpeed(_TMP_isWithin5Percent42_OUT, _TMP_isWithin5Percent30_OUT, _TMP_isWithin5Percent31_OUT, DistributionPumpPressureReductionFlag);
  DistributionPumpSpeedCommand := _TMP_SetDistributionPumpSpeed48_OUT;
  _TMP_NE184_OUT := NE(DisposalValveStatus, DisposalValveCommand);
  DisposalValveAlarm := _TMP_NE184_OUT;
  Tank0_CapacityAlarm := Tank0_90Capacity;
  Tank1_CapacityAlarm := Tank1_90Capacity;
  Tank2_CapacityAlarm := Tank2_90Capacity;
  AllTanksNearCapacity := Tank2_90Capacity AND Tank1_90Capacity AND Tank0_90Capacity;
  CentralTankAlarmSwitch := AllTanksNearCapacity;
  IF AllTanksNearCapacity THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  IF AllTanksNearCapacity THEN
    BoosterPumpCommand0 := FALSE; (*reset*)
  END_IF;
  IF AllTanksNearCapacity THEN
    BoosterPumpCommand1 := FALSE; (*reset*)
  END_IF;
  IF AllTanksNearCapacity THEN
    BoosterPumpCommand2 := FALSE; (*reset*)
  END_IF;
  ControlCenterHornStrobeAlarm := AllTanksNearCapacity;
  pHWarningHMI := pHAlertAlarm;
  pHCriticalHMI := pHCriticalAlarm;
  IF pHCriticalAlarm THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  IF pHCriticalAlarm THEN
    BoosterPumpCommand0 := FALSE; (*reset*)
  END_IF;
  IF pHCriticalAlarm THEN
    BoosterPumpCommand1 := FALSE; (*reset*)
  END_IF;
  IF pHCriticalAlarm THEN
    BoosterPumpCommand2 := FALSE; (*reset*)
  END_IF;
  ControlCenterHornStrobeAlarm := pHCriticalAlarm;
  _TMP_SEL269_OUT := SEL(AllTanksNearCapacity, EductorValveCommand0, 0);
  EductorValveCommand0 := _TMP_SEL269_OUT;
  _TMP_SEL33_OUT := SEL(AllTanksNearCapacity, EductorValveCommand1, 0);
  EductorValveCommand1 := _TMP_SEL33_OUT;
  _TMP_SEL52_OUT := SEL(AllTanksNearCapacity, EductorValveCommand2, 0);
  EductorValveCommand2 := _TMP_SEL52_OUT;
  _TMP_SEL57_OUT := SEL(AllTanksNearCapacity, IsolationValveCommand0, 0);
  IsolationValveCommand0 := _TMP_SEL57_OUT;
  _TMP_SEL62_OUT := SEL(AllTanksNearCapacity, IsolationValveCommand1, 0);
  IsolationValveCommand1 := _TMP_SEL62_OUT;
  _TMP_SEL67_OUT := SEL(AllTanksNearCapacity, IsolationValveCommand2, 0);
  IsolationValveCommand2 := _TMP_SEL67_OUT;
  _TMP_SEL72_OUT := SEL(pHCriticalAlarm, EductorValveCommand0, 0);
  EductorValveCommand0 := _TMP_SEL72_OUT;
  _TMP_SEL77_OUT := SEL(pHCriticalAlarm, EductorValveCommand1, 0);
  EductorValveCommand1 := _TMP_SEL77_OUT;
  _TMP_SEL82_OUT := SEL(pHCriticalAlarm, EductorValveCommand2, 0);
  EductorValveCommand2 := _TMP_SEL82_OUT;
  _TMP_SEL87_OUT := SEL(pHCriticalAlarm, IsolationValveCommand0, 0);
  IsolationValveCommand0 := _TMP_SEL87_OUT;
  _TMP_SEL92_OUT := SEL(pHCriticalAlarm, IsolationValveCommand1, 0);
  IsolationValveCommand1 := _TMP_SEL92_OUT;
  _TMP_SEL97_OUT := SEL(pHCriticalAlarm, IsolationValveCommand2, 0);
  IsolationValveCommand2 := _TMP_SEL97_OUT;
END_PROGRAM

FUNCTION_BLOCK Tank15MinuteReset
  VAR_INPUT
    PulseIn : BOOL;
  END_VAR
  VAR_OUTPUT
    DistributionPumpOut : BOOL;
  END_VAR
  VAR
    TON1 : TON;
    TP1 : TP;
    R_TRIG0 : R_TRIG;
  END_VAR

  R_TRIG0(CLK := PulseIn);
  TP1(IN := R_TRIG0.Q, PT := T#15m2s);
  TON1(IN := TP1.Q, PT := T#15m);
  DistributionPumpOut := TON1.Q;
END_FUNCTION_BLOCK

FUNCTION isOutsidePHRange : BOOL
  VAR_INPUT
    EvalulateVarIn : INT;
    BasicMax : INT;
    AcidicMax : INT;
  END_VAR
  VAR
    _TMP_LT5_OUT : BOOL;
    _TMP_GT4_OUT : BOOL;
    _TMP_OR6_OUT : BOOL;
  END_VAR

  _TMP_LT5_OUT := LT(EvalulateVarIn, AcidicMax);
  _TMP_GT4_OUT := GT(EvalulateVarIn, BasicMax);
  _TMP_OR6_OUT := OR(_TMP_LT5_OUT, _TMP_GT4_OUT);
  isOutsidePHRange := _TMP_OR6_OUT;
END_FUNCTION

PROGRAM TankpHMonitor
  VAR_EXTERNAL
    pHSensor : INT;
  END_VAR
  VAR_EXTERNAL CONSTANT
    WARNING_ACIDIC_LEVEL : INT;
    CRITICAL_ACIDIC_LEVEL : INT;
    WARNING_BASIC_LEVEL : INT;
    CRITICAL_BASIC_LEVEL : INT;
  END_VAR
  VAR_EXTERNAL
    pHAlertAlarm : BOOL;
    pHCriticalAlarm : BOOL;
  END_VAR
  VAR
    _TMP_isOutsidePHRange4_OUT : BOOL;
    _TMP_isOutsidePHRange9_OUT : BOOL;
  END_VAR

  _TMP_isOutsidePHRange4_OUT := isOutsidePHRange(pHSensor, WARNING_BASIC_LEVEL, WARNING_ACIDIC_LEVEL);
  pHAlertAlarm := _TMP_isOutsidePHRange4_OUT;
  _TMP_isOutsidePHRange9_OUT := isOutsidePHRange(pHSensor, CRITICAL_BASIC_LEVEL, CRITICAL_ACIDIC_LEVEL);
  pHCriticalAlarm := _TMP_isOutsidePHRange9_OUT;
END_PROGRAM

PROGRAM TankLevelAssessment
  VAR_EXTERNAL
    UltrasonicTankLevelSensor0 : INT;
    UltrasonicTankLevelSensor1 : INT;
    UltrasonicTankLevelSensor2 : INT;
    Tank0_30Capacity : BOOL;
    Tank1_30Capacity : BOOL;
    Tank2_30Capacity : BOOL;
    Tank0_60Capacity : BOOL;
    Tank1_60Capacity : BOOL;
    Tank2_60Capacity : BOOL;
    Tank0_90Capacity : BOOL;
    Tank1_90Capacity : BOOL;
    Tank2_90Capacity : BOOL;
  END_VAR
  VAR
    _TMP_GE52_OUT : BOOL;
    _TMP_GE34_OUT : BOOL;
    _TMP_GE56_OUT : BOOL;
    _TMP_GE60_OUT : BOOL;
    _TMP_GE64_OUT : BOOL;
    _TMP_GE69_OUT : BOOL;
    _TMP_GE72_OUT : BOOL;
    _TMP_GE76_OUT : BOOL;
    _TMP_GE81_OUT : BOOL;
  END_VAR

  _TMP_GE52_OUT := GE(UltrasonicTankLevelSensor0, 30);
  Tank0_30Capacity := _TMP_GE52_OUT;
  _TMP_GE34_OUT := GE(UltrasonicTankLevelSensor1, 30);
  Tank1_30Capacity := _TMP_GE34_OUT;
  _TMP_GE56_OUT := GE(UltrasonicTankLevelSensor2, 30);
  Tank2_30Capacity := _TMP_GE56_OUT;
  _TMP_GE60_OUT := GE(UltrasonicTankLevelSensor0, 60);
  Tank0_60Capacity := _TMP_GE60_OUT;
  _TMP_GE64_OUT := GE(UltrasonicTankLevelSensor1, 60);
  Tank1_60Capacity := _TMP_GE64_OUT;
  _TMP_GE69_OUT := GE(UltrasonicTankLevelSensor2, 60);
  Tank2_60Capacity := _TMP_GE69_OUT;
  _TMP_GE72_OUT := GE(UltrasonicTankLevelSensor0, 90);
  Tank0_90Capacity := _TMP_GE72_OUT;
  _TMP_GE76_OUT := GE(UltrasonicTankLevelSensor1, 90);
  Tank1_90Capacity := _TMP_GE76_OUT;
  _TMP_GE81_OUT := GE(UltrasonicTankLevelSensor2, 90);
  Tank2_90Capacity := _TMP_GE81_OUT;
END_PROGRAM

PROGRAM TankStirProgram
  VAR_EXTERNAL
    Tank0_30Capacity : BOOL;
    Tank1_30Capacity : BOOL;
    Tank2_30Capacity : BOOL;
    Tank0_60Capacity : BOOL;
    Tank1_60Capacity : BOOL;
    Tank2_60Capacity : BOOL;
    Tank0_90Capacity : BOOL;
    Tank1_90Capacity : BOOL;
    Tank2_90Capacity : BOOL;
    startStirProtocol0 : BOOL;
    startStirProtocol1 : BOOL;
    startStirProtocol2 : BOOL;
    stopStirProtocol0 : BOOL;
    stopStirProtocol1 : BOOL;
    stopStirProtocol2 : BOOL;
    EductorValveCommand0 : INT;
    EductorValveCommand1 : INT;
    EductorValveCommand2 : INT;
    DistributionPumpCommand : BOOL;
  END_VAR
  VAR
    Tank15MinuteReset0 : Tank15MinuteReset;
    RS0 : RS;
    TON0 : TON;
    RS1 : RS;
    Tank15MinuteReset1 : Tank15MinuteReset;
    TON1 : TON;
    RS2 : RS;
    Tank15MinuteReset2 : Tank15MinuteReset;
    TON2 : TON;
    F_TRIG1 : F_TRIG;
    _TMP_SEL237_OUT : INT;
    _TMP_INT_TO_BOOL251_OUT : BOOL;
    F_TRIG2 : F_TRIG;
    _TMP_SEL97_OUT : INT;
    _TMP_INT_TO_BOOL96_OUT : BOOL;
    F_TRIG3 : F_TRIG;
    _TMP_SEL233_OUT : INT;
    _TMP_INT_TO_BOOL232_OUT : BOOL;
  END_VAR

  IF NOT(stopStirProtocol0) AND Tank0_30Capacity AND NOT(Tank0_60Capacity) AND NOT(Tank0_90Capacity) THEN
    startStirProtocol0 := TRUE; (*set*)
  END_IF;
  Tank15MinuteReset0(PulseIn := startStirProtocol0);
  IF Tank15MinuteReset0.DistributionPumpOut THEN
    stopStirProtocol0 := TRUE; (*set*)
  END_IF;
  F_TRIG1(CLK := startStirProtocol0);
  RS0(S := startStirProtocol0, R1 := F_TRIG1.Q);
  _TMP_SEL237_OUT := SEL(RS0.Q1, 0, 100);
  _TMP_INT_TO_BOOL251_OUT := INT_TO_BOOL(_TMP_SEL237_OUT);
  IF _TMP_INT_TO_BOOL251_OUT THEN
    DistributionPumpCommand := TRUE; (*set*)
  END_IF;
  IF stopStirProtocol0 THEN
    startStirProtocol0 := FALSE; (*reset*)
  END_IF;
  IF stopStirProtocol0 THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  TON0(IN := stopStirProtocol0, PT := T#2s);
  IF TON0.Q THEN
    stopStirProtocol0 := FALSE; (*reset*)
  END_IF;
  IF NOT(stopStirProtocol1) AND Tank1_30Capacity AND NOT(Tank1_60Capacity) THEN
    startStirProtocol1 := TRUE; (*set*)
  END_IF;
  F_TRIG2(CLK := startStirProtocol1);
  RS1(S := startStirProtocol1, R1 := F_TRIG2.Q);
  _TMP_SEL97_OUT := SEL(RS1.Q1, 0, 100);
  _TMP_INT_TO_BOOL96_OUT := INT_TO_BOOL(_TMP_SEL97_OUT);
  IF _TMP_INT_TO_BOOL96_OUT THEN
    DistributionPumpCommand := TRUE; (*set*)
  END_IF;
  Tank15MinuteReset1(PulseIn := startStirProtocol1);
  IF Tank15MinuteReset1.DistributionPumpOut THEN
    stopStirProtocol1 := TRUE; (*set*)
  END_IF;
  IF stopStirProtocol1 THEN
    startStirProtocol1 := FALSE; (*reset*)
  END_IF;
  IF stopStirProtocol1 THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  TON1(IN := stopStirProtocol1, PT := T#2s);
  IF TON1.Q THEN
    stopStirProtocol1 := FALSE; (*reset*)
  END_IF;
  IF NOT(stopStirProtocol2) AND Tank2_30Capacity AND NOT(Tank2_60Capacity) AND NOT(Tank2_90Capacity) THEN
    startStirProtocol2 := TRUE; (*set*)
  END_IF;
  F_TRIG3(CLK := startStirProtocol2);
  RS2(S := startStirProtocol2, R1 := F_TRIG3.Q);
  _TMP_SEL233_OUT := SEL(RS2.Q1, 0, 100);
  _TMP_INT_TO_BOOL232_OUT := INT_TO_BOOL(_TMP_SEL233_OUT);
  IF _TMP_INT_TO_BOOL232_OUT THEN
    DistributionPumpCommand := TRUE; (*set*)
  END_IF;
  Tank15MinuteReset2(PulseIn := startStirProtocol2);
  IF Tank15MinuteReset2.DistributionPumpOut THEN
    stopStirProtocol2 := TRUE; (*set*)
  END_IF;
  IF stopStirProtocol2 THEN
    startStirProtocol2 := FALSE; (*reset*)
  END_IF;
  IF stopStirProtocol2 THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  TON2(IN := stopStirProtocol2, PT := T#2s);
  IF TON2.Q THEN
    stopStirProtocol2 := FALSE; (*reset*)
  END_IF;
  EductorValveCommand0 := _TMP_SEL237_OUT;
  EductorValveCommand1 := _TMP_SEL97_OUT;
  EductorValveCommand2 := _TMP_SEL233_OUT;
END_PROGRAM

PROGRAM DisposalProgram
  VAR_EXTERNAL
    Tank0_30Capacity : BOOL;
    Tank1_30Capacity : BOOL;
    Tank2_30Capacity : BOOL;
    Tank0_60Capacity : BOOL;
    Tank1_60Capacity : BOOL;
    Tank2_60Capacity : BOOL;
    Tank0_DisposalReady : BOOL;
    Tank1_DisposalReady : BOOL;
    Tank2_DisposalReady : BOOL;
    HMITankDisposalButton : BOOL;
    DistributionPumpCommand : BOOL;
    DistributionPumpSpeedCommand : INT;
    DisposalValveCommand : INT;
    EductorValveCommand0 : INT;
    EductorValveCommand1 : INT;
    EductorValveCommand2 : INT;
    isContainmentUnitAttached : BOOL;
    isContainmentUnitFull : BOOL;
    askHMIContainmentUnitAttached : BOOL;
    askHMIContainmentUnitFull : BOOL;
  END_VAR
  VAR
    _TMP_SEL266_OUT : INT;
    _TMP_SEL270_OUT : INT;
    _TMP_SEL269_OUT : INT;
    _TMP_SEL3_OUT : INT;
    _TMP_SEL10_OUT : INT;
    _TMP_SEL14_OUT : INT;
    _TMP_SEL275_OUT : INT;
    R_TRIG1 : R_TRIG;
    R_TRIG2 : R_TRIG;
    R_TRIG3 : R_TRIG;
    R_TRIG4 : R_TRIG;
  END_VAR

  _TMP_SEL266_OUT := SEL(Tank0_DisposalReady, EductorValveCommand0, 0);
  EductorValveCommand0 := _TMP_SEL266_OUT;
  IF Tank0_DisposalReady THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  _TMP_SEL270_OUT := SEL(isContainmentUnitAttached, DistributionPumpSpeedCommand, 50);
  DistributionPumpSpeedCommand := _TMP_SEL270_OUT;
  Tank0_DisposalReady := HMITankDisposalButton AND Tank0_60Capacity AND Tank0_30Capacity;
  Tank1_DisposalReady := HMITankDisposalButton AND Tank1_60Capacity AND Tank1_30Capacity;
  Tank2_DisposalReady := HMITankDisposalButton AND Tank2_60Capacity AND Tank2_30Capacity;
  IF Tank1_DisposalReady THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  IF Tank2_DisposalReady THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  _TMP_SEL269_OUT := SEL(Tank1_DisposalReady, EductorValveCommand1, 0);
  EductorValveCommand1 := _TMP_SEL269_OUT;
  _TMP_SEL3_OUT := SEL(Tank2_DisposalReady, EductorValveCommand2, 0);
  EductorValveCommand2 := _TMP_SEL3_OUT;
  _TMP_SEL10_OUT := SEL(isContainmentUnitAttached, DisposalValveCommand, 100);
  DisposalValveCommand := _TMP_SEL10_OUT;
  _TMP_SEL14_OUT := SEL(isContainmentUnitFull, DisposalValveCommand, 0);
  DisposalValveCommand := _TMP_SEL14_OUT;
  _TMP_SEL275_OUT := SEL(isContainmentUnitFull, DistributionPumpSpeedCommand, 0);
  DistributionPumpSpeedCommand := _TMP_SEL275_OUT;
  R_TRIG1(CLK := askHMIContainmentUnitAttached);
  IF R_TRIG1.Q THEN
    isContainmentUnitAttached := TRUE; (*set*)
  END_IF;
  askHMIContainmentUnitFull := isContainmentUnitAttached;
  R_TRIG2(CLK := isContainmentUnitAttached);
  IF R_TRIG2.Q THEN
    DistributionPumpCommand := TRUE; (*set*)
  END_IF;
  R_TRIG3(CLK := isContainmentUnitFull);
  IF R_TRIG3.Q THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  R_TRIG4(CLK := isContainmentUnitFull);
  IF R_TRIG4.Q THEN
    HMITankDisposalButton := FALSE; (*reset*)
  END_IF;
END_PROGRAM


CONFIGURATION Config0
  VAR_GLOBAL
    FlowRateSensor0 AT %IW0 : INT := 4;
    FlowRateSensor1 AT %IW1 : INT := 23;
    FlowRateSensor2 AT %IW2 : INT := 42;
    IsolationValveStatus0 AT %IW3 : INT := 0;
    IsolationValveStatus1 AT %IW4 : INT := 0;
    IsolationValveStatus2 AT %IW5 : INT := 0;
    EductorValveStatus0 AT %IW6 : INT := 0;
    EductorValveStatus1 AT %IW7 : INT := 0;
    EductorValveStatus2 AT %IW8 : INT := 0;
    UltrasonicTankLevelSensor0 AT %IW9 : INT := 35;
    UltrasonicTankLevelSensor1 AT %IW10 : INT := 57;
    UltrasonicTankLevelSensor2 AT %IW11 : INT := 12;
    DisposalValveStatus AT %IW12 : INT := 0;
    pHSensor AT %IW13 : INT := 7;
    BoosterPumpStatus0 AT %IX0.0 : BOOL;
    BoosterPumpStatus1 AT %IX0.1 : BOOL;
    BoosterPumpStatus2 AT %IX0.2 : BOOL;
    GeneralSiteAlarm0 AT %IX0.3 : BOOL;
    DistributionPumpStatus AT %IX0.4 : BOOL;
    HighPressureSwitch0 AT %IX0.5 : BOOL;
    HighPressureSwitch1 AT %IX0.6 : BOOL;
    HighPressureSwitch2 AT %IX0.7 : BOOL;
    IsolationValveCommand0 AT %QW0 : INT;
    IsolationValveCommand1 AT %QW1 : INT;
    IsolationValveCommand2 AT %QW2 : INT;
    EductorValveCommand0 AT %QW3 : INT;
    EductorValveCommand1 AT %QW4 : INT;
    EductorValveCommand2 AT %QW5 : INT;
    DistributionPumpSpeedCommand AT %QW6 : INT := 0;
    DisposalValveCommand AT %QW7 : INT := 0;
    BoosterPumpCommand0 AT %QX0.0 : BOOL;
    BoosterPumpCommand1 AT %QX0.1 : BOOL;
    BoosterPumpCommand2 AT %QX0.2 : BOOL;
    pHAlertAlarm AT %QX0.3 : BOOL;
    pHCriticalAlarm AT %QX0.4 : BOOL;
    BoosterPumpAlarm0 AT %QX0.5 : BOOL;
    BoosterPumpAlarm1 AT %QX0.6 : BOOL;
    BoosterPumpAlarm2 AT %QX0.7 : BOOL;
    IsolationValveAlarm0 AT %QX1.0 : BOOL;
    IsolationValveAlarm1 AT %QX1.1 : BOOL;
    IsolationValveAlarm2 AT %QX1.2 : BOOL;
    FlowSensorAlarm0 AT %QX1.3 : BOOL;
    FlowSensorAlarm1 AT %QX1.4 : BOOL;
    FlowSensorAlarm2 AT %QX1.5 : BOOL;
    ExcessiveFlowAlarm0 AT %QX1.6 : BOOL;
    ExcessiveFlowAlarm1 AT %QX1.7 : BOOL;
    ExcessiveFlowAlarm2 AT %QX2.0 : BOOL;
    EductorValveAlarm0 AT %QX2.1 : BOOL;
    EductorValveAlarm1 AT %QX2.2 : BOOL;
    EductorValveAlarm2 AT %QX2.3 : BOOL;
    DistributionPumpCommand AT %QX2.4 : BOOL;
    DistributionPumpAlarm AT %QX2.5 : BOOL;
    HighPressureSwitchAlarm0 AT %QX2.6 : BOOL;
    HighPressureSwitchAlarm1 AT %QX2.7 : BOOL;
    HighPressureSwitchAlarm2 AT %QX3.0 : BOOL;
    askHMIContainmentUnitAttached AT %QX3.1 : BOOL;
    askHMIContainmentUnitFull AT %QX3.2 : BOOL;
    DisposalValveAlarm AT %QX3.3 : BOOL;
    Tank0_CapacityAlarm AT %QX3.4 : BOOL;
    Tank1_CapacityAlarm AT %QX3.5 : BOOL;
    Tank2_CapacityAlarm AT %QX3.6 : BOOL;
    CentralTankAlarmSwitch AT %QX3.7 : BOOL;
    ControlCenterHornStrobeAlarm AT %QX4.0 : BOOL;
    pHWarningHMI AT %QX4.1 : BOOL;
    pHCriticalHMI AT %QX4.2 : BOOL;
    HMITankDisposalButton AT %QX4.3 : BOOL;
    isContainmentUnitAttached AT %QX4.4 : BOOL;
    isContainmentUnitFull AT %QX4.5 : BOOL;
  END_VAR
  VAR_GLOBAL CONSTANT
    FLOW_SENSOR_MAX_CAPACITY AT %MW0 : INT := 50;
    WARNING_ACIDIC_LEVEL AT %MW1 : INT := 4;
    CRITICAL_ACIDIC_LEVEL AT %MW2 : INT := 3;
    WARNING_BASIC_LEVEL AT %MW3 : INT := 10;
    CRITICAL_BASIC_LEVEL AT %MW4 : INT := 11;
  END_VAR
  VAR_GLOBAL
    DistributionPumpPressureReductionFlag AT %MX0.0 : BOOL;
    Tank0_30Capacity AT %MX0.1 : BOOL;
    Tank1_30Capacity AT %MX0.2 : BOOL;
    Tank2_30Capacity AT %MX0.3 : BOOL;
    Tank0_60Capacity AT %MX0.4 : BOOL;
    Tank1_60Capacity AT %MX0.5 : BOOL;
    Tank2_60Capacity AT %MX0.6 : BOOL;
    Tank0_90Capacity AT %MX0.7 : BOOL;
    Tank1_90Capacity AT %MX1.0 : BOOL;
    Tank2_90Capacity AT %MX1.1 : BOOL;
    Tank0_DisposalReady AT %MX1.2 : BOOL;
    Tank1_DisposalReady AT %MX1.3 : BOOL;
    Tank2_DisposalReady AT %MX1.4 : BOOL;
    AllTanksNearCapacity AT %MX1.5 : BOOL;
    startStirProtocol0 AT %MX1.6 : BOOL;
    startStirProtocol1 AT %MX1.7 : BOOL;
    startStirProtocol2 AT %MX2.0 : BOOL;
    stopStirProtocol0 AT %MX2.1 : BOOL;
    stopStirProtocol1 AT %MX2.2 : BOOL;
    stopStirProtocol2 AT %MX2.3 : BOOL;
  END_VAR

  RESOURCE Res0 ON PLC
    TASK DefaultCyclicTask(INTERVAL := T#30ms,PRIORITY := 0);
    TASK StirTask(INTERVAL := T#30ms,PRIORITY := 0);
    PROGRAM instance0 WITH DefaultCyclicTask : DCSProgramSector;
    PROGRAM instance1 WITH DefaultCyclicTask : SCADATankLevelProgram;
    PROGRAM instance2 WITH DefaultCyclicTask : TankpHMonitor;
    PROGRAM instance3 WITH DefaultCyclicTask : TankLevelAssessment;
    PROGRAM instance4 WITH DefaultCyclicTask : DisposalProgram;
    PROGRAM instance5 WITH StirTask : TankStirProgram;
  END_RESOURCE
END_CONFIGURATION
