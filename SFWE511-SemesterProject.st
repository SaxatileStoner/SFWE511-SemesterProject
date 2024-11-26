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
  TP1(IN := R_TRIG0.Q, PT := T#15m5s);
  TON1(IN := TP1.Q, PT := T#15m);
  DistributionPumpOut := TON1.Q;
END_FUNCTION_BLOCK

FUNCTION_BLOCK DisposalProtocol
  VAR_INPUT
    In : BOOL;
    DistributionPumpSpeedIn : INT;
    DisposalValveCommandIn : INT;
  END_VAR
  VAR_OUTPUT
    Out : BOOL;
    DistributionPumpSpeedOut : INT;
    DisposalValveCommandOut : INT;
  END_VAR
  VAR
    _TMP_MOVE3_ENO : BOOL;
    _TMP_MOVE3_OUT : INT;
    _TMP_MOVE6_ENO : BOOL;
    _TMP_MOVE6_OUT : INT;
  END_VAR

  _TMP_MOVE3_OUT := MOVE(EN := In, IN := DistributionPumpSpeedIn, ENO => _TMP_MOVE3_ENO);
  IF _TMP_MOVE3_ENO THEN
      DistributionPumpSpeedOut := _TMP_MOVE3_OUT;
  END_IF;
  _TMP_MOVE6_OUT := MOVE(EN := _TMP_MOVE3_ENO, IN := DisposalValveCommandIn, ENO => _TMP_MOVE6_ENO);
  IF _TMP_MOVE6_ENO THEN
      DisposalValveCommandOut := _TMP_MOVE6_OUT;
  END_IF;
  Out := _TMP_MOVE6_ENO;
END_FUNCTION_BLOCK

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
    UltrasonicTankLevelSensor0 : INT;
    UltrasonicTankLevelSensor1 : INT;
    UltrasonicTankLevelSensor2 : INT;
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
    startStirProtocol0 : BOOL;
    startStirProtocol1 : BOOL;
    startStirProtocol2 : BOOL;
    stopStirProtocol0 : BOOL;
    stopStirProtocol1 : BOOL;
    stopStirProtocol2 : BOOL;
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
    Tank15MinuteReset0 : Tank15MinuteReset;
    DisposalProtocol0 : DisposalProtocol;
    DisposalProtocol1 : DisposalProtocol;
    TON0 : TON;
    RS0 : RS;
    Tank15MinuteReset1 : Tank15MinuteReset;
    RS1 : RS;
    TON1 : TON;
    Tank15MinuteReset2 : Tank15MinuteReset;
    RS2 : RS;
    TON2 : TON;
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
    _TMP_GE52_OUT : BOOL;
    _TMP_GE34_OUT : BOOL;
    _TMP_GE56_OUT : BOOL;
    _TMP_GE60_OUT : BOOL;
    _TMP_GE64_OUT : BOOL;
    _TMP_GE69_OUT : BOOL;
    _TMP_GE72_OUT : BOOL;
    _TMP_GE76_OUT : BOOL;
    _TMP_GE81_OUT : BOOL;
    _TMP_MOVE146_ENO : BOOL;
    _TMP_MOVE146_OUT : INT;
    _TMP_MOVE117_ENO : BOOL;
    _TMP_MOVE117_OUT : INT;
    _TMP_MOVE132_ENO : BOOL;
    _TMP_MOVE132_OUT : INT;
    _TMP_NE184_OUT : BOOL;
    _TMP_MOVE200_ENO : BOOL;
    _TMP_MOVE200_OUT : INT;
    _TMP_MOVE111_ENO : BOOL;
    _TMP_MOVE111_OUT : INT;
    _TMP_MOVE143_ENO : BOOL;
    _TMP_MOVE143_OUT : INT;
    _TMP_MOVE156_ENO : BOOL;
    _TMP_MOVE156_OUT : INT;
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
  _TMP_MOVE146_OUT := MOVE(EN := Tank0_DisposalReady, IN := 0, ENO => _TMP_MOVE146_ENO);
  IF _TMP_MOVE146_ENO THEN
      EductorValveCommand0 := _TMP_MOVE146_OUT;
  END_IF;
  IF _TMP_MOVE146_ENO THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  DisposalProtocol0(In := isContainmentUnitAttached, DistributionPumpSpeedIn := 50, DisposalValveCommandIn := 100);
  DistributionPumpSpeedCommand := DisposalProtocol0.DistributionPumpSpeedOut;
  _TMP_MOVE117_OUT := MOVE(EN := Tank1_DisposalReady, IN := 0, ENO => _TMP_MOVE117_ENO);
  IF _TMP_MOVE117_ENO THEN
      EductorValveCommand1 := _TMP_MOVE117_OUT;
  END_IF;
  _TMP_MOVE132_OUT := MOVE(EN := Tank2_DisposalReady, IN := 0, ENO => _TMP_MOVE132_ENO);
  IF _TMP_MOVE132_ENO THEN
      EductorValveCommand2 := _TMP_MOVE132_OUT;
  END_IF;
  IF _TMP_MOVE132_ENO THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  Tank0_DisposalReady := HMITankDisposalButton AND Tank0_60Capacity AND Tank0_30Capacity;
  Tank1_DisposalReady := HMITankDisposalButton AND Tank1_60Capacity AND Tank1_30Capacity;
  Tank2_DisposalReady := HMITankDisposalButton AND Tank2_60Capacity AND Tank2_30Capacity;
  askHMIContainmentUnitAttached := Tank0_DisposalReady OR Tank1_DisposalReady OR Tank2_DisposalReady;
  DisposalValveCommand := DisposalProtocol0.DisposalValveCommandOut;
  askHMIContainmentUnitFull := DisposalProtocol0.Out;
  DisposalProtocol1(In := isContainmentUnitFull, DistributionPumpSpeedIn := 0, DisposalValveCommandIn := 0);
  DisposalValveCommand := DisposalProtocol1.DisposalValveCommandOut;
  DistributionPumpSpeedCommand := DisposalProtocol1.DistributionPumpSpeedOut;
  _TMP_NE184_OUT := NE(DisposalValveStatus, DisposalValveCommand);
  DisposalValveAlarm := _TMP_NE184_OUT;
  Tank0_CapacityAlarm := Tank0_90Capacity;
  Tank1_CapacityAlarm := Tank1_90Capacity;
  Tank2_CapacityAlarm := Tank2_90Capacity;
  AllTanksNearCapacity := Tank2_90Capacity AND Tank1_90Capacity AND Tank0_90Capacity;
  CentralTankAlarmSwitch := AllTanksNearCapacity;
  _TMP_MOVE200_OUT := MOVE(EN := AllTanksNearCapacity, IN := 0, ENO => _TMP_MOVE200_ENO);
  IF _TMP_MOVE200_ENO THEN
      EductorValveCommand0 := _TMP_MOVE200_OUT;
  END_IF;
  EductorValveCommand1 := EductorValveCommand0;
  EductorValveCommand2 := EductorValveCommand1;
  IF _TMP_MOVE200_ENO THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  _TMP_MOVE111_OUT := MOVE(EN := AllTanksNearCapacity, IN := 0, ENO => _TMP_MOVE111_ENO);
  IF _TMP_MOVE111_ENO THEN
      IsolationValveCommand0 := _TMP_MOVE111_OUT;
  END_IF;
  IsolationValveCommand1 := IsolationValveCommand0;
  IsolationValveCommand2 := IsolationValveCommand1;
  IF _TMP_MOVE111_ENO THEN
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
  _TMP_MOVE143_OUT := MOVE(EN := pHCriticalAlarm, IN := 0, ENO => _TMP_MOVE143_ENO);
  IF _TMP_MOVE143_ENO THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
  _TMP_MOVE156_OUT := MOVE(EN := pHCriticalAlarm, IN := 0, ENO => _TMP_MOVE156_ENO);
  IF _TMP_MOVE156_ENO THEN
    BoosterPumpCommand0 := FALSE; (*reset*)
  END_IF;
  IF pHCriticalAlarm THEN
    BoosterPumpCommand1 := FALSE; (*reset*)
  END_IF;
  IF pHCriticalAlarm THEN
    BoosterPumpCommand2 := FALSE; (*reset*)
  END_IF;
  IF _TMP_MOVE143_ENO THEN
      EductorValveCommand0 := _TMP_MOVE143_OUT;
  END_IF;
  EductorValveCommand1 := EductorValveCommand0;
  EductorValveCommand2 := EductorValveCommand1;
  IF _TMP_MOVE156_ENO THEN
      IsolationValveCommand0 := _TMP_MOVE156_OUT;
  END_IF;
  IsolationValveCommand1 := IsolationValveCommand0;
  IsolationValveCommand2 := IsolationValveCommand1;
  ControlCenterHornStrobeAlarm := pHCriticalAlarm;
  IF NOT(stopStirProtocol0) AND Tank0_30Capacity AND NOT(Tank0_60Capacity) AND NOT(Tank0_90Capacity) THEN
    startStirProtocol0 := TRUE; (*set*)
  END_IF;
  F_TRIG1(CLK := startStirProtocol0);
  RS0(S := startStirProtocol0, R1 := F_TRIG1.Q);
  _TMP_SEL237_OUT := SEL(RS0.Q1, 0, 100);
  EductorValveCommand0 := _TMP_SEL237_OUT;
  Tank15MinuteReset0(PulseIn := startStirProtocol0);
  IF Tank15MinuteReset0.DistributionPumpOut THEN
    stopStirProtocol0 := TRUE; (*set*)
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
  _TMP_INT_TO_BOOL251_OUT := INT_TO_BOOL(_TMP_SEL237_OUT);
  IF _TMP_INT_TO_BOOL251_OUT THEN
    DistributionPumpCommand := TRUE; (*set*)
  END_IF;
  IF NOT(stopStirProtocol1) AND Tank1_30Capacity AND NOT(Tank1_60Capacity) AND NOT(Tank1_90Capacity) THEN
    startStirProtocol1 := TRUE; (*set*)
  END_IF;
  Tank15MinuteReset1(PulseIn := startStirProtocol1);
  IF Tank15MinuteReset1.DistributionPumpOut THEN
    stopStirProtocol1 := TRUE; (*set*)
  END_IF;
  F_TRIG2(CLK := startStirProtocol1);
  RS1(S := startStirProtocol1, R1 := F_TRIG2.Q);
  _TMP_SEL97_OUT := SEL(RS1.Q1, 0, 100);
  _TMP_INT_TO_BOOL96_OUT := INT_TO_BOOL(_TMP_SEL97_OUT);
  IF _TMP_INT_TO_BOOL96_OUT THEN
    DistributionPumpCommand := TRUE; (*set*)
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
  EductorValveCommand1 := _TMP_SEL97_OUT;
  IF NOT(stopStirProtocol2) AND Tank2_30Capacity AND NOT(Tank2_60Capacity) AND NOT(Tank2_90Capacity) THEN
    startStirProtocol2 := TRUE; (*set*)
  END_IF;
  Tank15MinuteReset2(PulseIn := startStirProtocol2);
  IF Tank15MinuteReset2.DistributionPumpOut THEN
    stopStirProtocol2 := TRUE; (*set*)
  END_IF;
  F_TRIG3(CLK := startStirProtocol2);
  RS2(S := startStirProtocol2, R1 := F_TRIG3.Q);
  _TMP_SEL233_OUT := SEL(RS2.Q1, 0, 100);
  _TMP_INT_TO_BOOL232_OUT := INT_TO_BOOL(_TMP_SEL233_OUT);
  IF _TMP_INT_TO_BOOL232_OUT THEN
    DistributionPumpCommand := TRUE; (*set*)
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
  EductorValveCommand1 := _TMP_SEL233_OUT;
  IF _TMP_MOVE117_ENO THEN
    DistributionPumpCommand := FALSE; (*reset*)
  END_IF;
END_PROGRAM

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

PROGRAM SCADApHTankMonitorProgram
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
    TASK task0(INTERVAL := T#30ms,PRIORITY := 0);
    TASK task1(INTERVAL := T#30ms,PRIORITY := 0);
    TASK task2(INTERVAL := T#30ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : DCSProgramSector;
    PROGRAM instance1 WITH task1 : SCADATankLevelProgram;
    PROGRAM instance2 WITH task2 : SCADApHTankMonitorProgram;
  END_RESOURCE
END_CONFIGURATION

(*DBG:char md5[] = "5e36c06534628128c00ded2bc994e1a2";*)
(*DBG:/**)
(*DBG: * This file is part of OpenPLC Runtime*)
(*DBG: **)
(*DBG: * Copyright (C) 2023 Autonomy, GP Orcullo*)
(*DBG: * Based on the work by GP Orcullo on Beremiz for uC*)
(*DBG: **)
(*DBG: * This program is free software; you can redistribute it and/or*)
(*DBG: * modify it under the terms of the GNU General Public License*)
(*DBG: * as published by the Free Software Foundation; either version 2*)
(*DBG: * of the License, or (at your option) any later version.*)
(*DBG: **)
(*DBG: * This program is distributed in the hope that it will be useful,*)
(*DBG: * but WITHOUT ANY WARRANTY; without even the implied warranty of*)
(*DBG: * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the*)
(*DBG: * GNU General Public License for more details.*)
(*DBG: **)
(*DBG: * You should have received a copy of the GNU General Public License*)
(*DBG: * along with this program; If not, see <http://www.gnu.org/licenses/>.*)
(*DBG: **)
(*DBG: */*)
(*DBG:*)
(*DBG:#include <stdbool.h>*)
(*DBG:*)
(*DBG:#include "iec_types_all.h"*)
(*DBG:#include "POUS.h"*)
(*DBG:*)
(*DBG:#define SAME_ENDIANNESS      0*)
(*DBG:#define REVERSE_ENDIANNESS   1*)
(*DBG:*)
(*DBG:uint8_t endianness;*)
(*DBG:*)
(*DBG:*)
(*DBG:extern __IEC_INT_t CONFIG0__FLOWRATESENSOR0;*)
(*DBG:extern __IEC_INT_t CONFIG0__FLOWRATESENSOR1;*)
(*DBG:extern __IEC_INT_t CONFIG0__FLOWRATESENSOR2;*)
(*DBG:extern __IEC_INT_t CONFIG0__ISOLATIONVALVESTATUS0;*)
(*DBG:extern __IEC_INT_t CONFIG0__ISOLATIONVALVESTATUS1;*)
(*DBG:extern __IEC_INT_t CONFIG0__ISOLATIONVALVESTATUS2;*)
(*DBG:extern __IEC_INT_t CONFIG0__EDUCTORVALVESTATUS0;*)
(*DBG:extern __IEC_INT_t CONFIG0__EDUCTORVALVESTATUS1;*)
(*DBG:extern __IEC_INT_t CONFIG0__EDUCTORVALVESTATUS2;*)
(*DBG:extern __IEC_INT_t CONFIG0__ULTRASONICTANKLEVELSENSOR0;*)
(*DBG:extern __IEC_INT_t CONFIG0__ULTRASONICTANKLEVELSENSOR1;*)
(*DBG:extern __IEC_INT_t CONFIG0__ULTRASONICTANKLEVELSENSOR2;*)
(*DBG:extern __IEC_INT_t CONFIG0__DISPOSALVALVESTATUS;*)
(*DBG:extern __IEC_INT_t CONFIG0__PHSENSOR;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__BOOSTERPUMPSTATUS0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__BOOSTERPUMPSTATUS1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__BOOSTERPUMPSTATUS2;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__GENERALSITEALARM0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__DISTRIBUTIONPUMPSTATUS;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__HIGHPRESSURESWITCH0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__HIGHPRESSURESWITCH1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__HIGHPRESSURESWITCH2;*)
(*DBG:extern __IEC_INT_t CONFIG0__ISOLATIONVALVECOMMAND0;*)
(*DBG:extern __IEC_INT_t CONFIG0__ISOLATIONVALVECOMMAND1;*)
(*DBG:extern __IEC_INT_t CONFIG0__ISOLATIONVALVECOMMAND2;*)
(*DBG:extern __IEC_INT_t CONFIG0__EDUCTORVALVECOMMAND0;*)
(*DBG:extern __IEC_INT_t CONFIG0__EDUCTORVALVECOMMAND1;*)
(*DBG:extern __IEC_INT_t CONFIG0__EDUCTORVALVECOMMAND2;*)
(*DBG:extern __IEC_INT_t CONFIG0__DISTRIBUTIONPUMPSPEEDCOMMAND;*)
(*DBG:extern __IEC_INT_t CONFIG0__DISPOSALVALVECOMMAND;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__BOOSTERPUMPCOMMAND0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__BOOSTERPUMPCOMMAND1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__BOOSTERPUMPCOMMAND2;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__PHALERTALARM;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__PHCRITICALALARM;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__BOOSTERPUMPALARM0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__BOOSTERPUMPALARM1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__BOOSTERPUMPALARM2;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__ISOLATIONVALVEALARM0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__ISOLATIONVALVEALARM1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__ISOLATIONVALVEALARM2;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__FLOWSENSORALARM0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__FLOWSENSORALARM1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__FLOWSENSORALARM2;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__EXCESSIVEFLOWALARM0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__EXCESSIVEFLOWALARM1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__EXCESSIVEFLOWALARM2;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__EDUCTORVALVEALARM0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__EDUCTORVALVEALARM1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__EDUCTORVALVEALARM2;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__DISTRIBUTIONPUMPCOMMAND;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__DISTRIBUTIONPUMPALARM;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__HIGHPRESSURESWITCHALARM0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__HIGHPRESSURESWITCHALARM1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__HIGHPRESSURESWITCHALARM2;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__ASKHMICONTAINMENTUNITATTACHED;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__ASKHMICONTAINMENTUNITFULL;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__DISPOSALVALVEALARM;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK0_CAPACITYALARM;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK1_CAPACITYALARM;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK2_CAPACITYALARM;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__CENTRALTANKALARMSWITCH;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__CONTROLCENTERHORNSTROBEALARM;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__PHWARNINGHMI;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__PHCRITICALHMI;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__HMITANKDISPOSALBUTTON;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__ISCONTAINMENTUNITATTACHED;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__ISCONTAINMENTUNITFULL;*)
(*DBG:extern __IEC_INT_t CONFIG0__FLOW_SENSOR_MAX_CAPACITY;*)
(*DBG:extern __IEC_INT_t CONFIG0__WARNING_ACIDIC_LEVEL;*)
(*DBG:extern __IEC_INT_t CONFIG0__CRITICAL_ACIDIC_LEVEL;*)
(*DBG:extern __IEC_INT_t CONFIG0__WARNING_BASIC_LEVEL;*)
(*DBG:extern __IEC_INT_t CONFIG0__CRITICAL_BASIC_LEVEL;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__DISTRIBUTIONPUMPPRESSUREREDUCTIONFLAG;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK0_30CAPACITY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK1_30CAPACITY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK2_30CAPACITY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK0_60CAPACITY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK1_60CAPACITY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK2_60CAPACITY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK0_90CAPACITY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK1_90CAPACITY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK2_90CAPACITY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK0_DISPOSALREADY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK1_DISPOSALREADY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__TANK2_DISPOSALREADY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__ALLTANKSNEARCAPACITY;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__STARTSTIRPROTOCOL0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__STARTSTIRPROTOCOL1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__STARTSTIRPROTOCOL2;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__STOPSTIRPROTOCOL0;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__STOPSTIRPROTOCOL1;*)
(*DBG:extern __IEC_BOOL_t CONFIG0__STOPSTIRPROTOCOL2;*)
(*DBG:extern DCSPROGRAMSECTOR RES0__INSTANCE0;*)
(*DBG:extern SCADATANKLEVELPROGRAM RES0__INSTANCE1;*)
(*DBG:extern SCADAPHTANKMONITORPROGRAM RES0__INSTANCE2;*)
(*DBG:*)
(*DBG:static const struct {*)
(*DBG:    void *ptr;*)
(*DBG:    __IEC_types_enum type;*)
(*DBG:} debug_vars[] = {*)
(*DBG:    {&(CONFIG0__FLOWRATESENSOR0), INT_ENUM},*)
(*DBG:    {&(CONFIG0__FLOWRATESENSOR1), INT_ENUM},*)
(*DBG:    {&(CONFIG0__FLOWRATESENSOR2), INT_ENUM},*)
(*DBG:    {&(CONFIG0__ISOLATIONVALVESTATUS0), INT_ENUM},*)
(*DBG:    {&(CONFIG0__ISOLATIONVALVESTATUS1), INT_ENUM},*)
(*DBG:    {&(CONFIG0__ISOLATIONVALVESTATUS2), INT_ENUM},*)
(*DBG:    {&(CONFIG0__EDUCTORVALVESTATUS0), INT_ENUM},*)
(*DBG:    {&(CONFIG0__EDUCTORVALVESTATUS1), INT_ENUM},*)
(*DBG:    {&(CONFIG0__EDUCTORVALVESTATUS2), INT_ENUM},*)
(*DBG:    {&(CONFIG0__ULTRASONICTANKLEVELSENSOR0), INT_ENUM},*)
(*DBG:    {&(CONFIG0__ULTRASONICTANKLEVELSENSOR1), INT_ENUM},*)
(*DBG:    {&(CONFIG0__ULTRASONICTANKLEVELSENSOR2), INT_ENUM},*)
(*DBG:    {&(CONFIG0__DISPOSALVALVESTATUS), INT_ENUM},*)
(*DBG:    {&(CONFIG0__PHSENSOR), INT_ENUM},*)
(*DBG:    {&(CONFIG0__BOOSTERPUMPSTATUS0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__BOOSTERPUMPSTATUS1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__BOOSTERPUMPSTATUS2), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__GENERALSITEALARM0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__DISTRIBUTIONPUMPSTATUS), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__HIGHPRESSURESWITCH0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__HIGHPRESSURESWITCH1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__HIGHPRESSURESWITCH2), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__ISOLATIONVALVECOMMAND0), INT_ENUM},*)
(*DBG:    {&(CONFIG0__ISOLATIONVALVECOMMAND1), INT_ENUM},*)
(*DBG:    {&(CONFIG0__ISOLATIONVALVECOMMAND2), INT_ENUM},*)
(*DBG:    {&(CONFIG0__EDUCTORVALVECOMMAND0), INT_ENUM},*)
(*DBG:    {&(CONFIG0__EDUCTORVALVECOMMAND1), INT_ENUM},*)
(*DBG:    {&(CONFIG0__EDUCTORVALVECOMMAND2), INT_ENUM},*)
(*DBG:    {&(CONFIG0__DISTRIBUTIONPUMPSPEEDCOMMAND), INT_ENUM},*)
(*DBG:    {&(CONFIG0__DISPOSALVALVECOMMAND), INT_ENUM},*)
(*DBG:    {&(CONFIG0__BOOSTERPUMPCOMMAND0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__BOOSTERPUMPCOMMAND1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__BOOSTERPUMPCOMMAND2), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__PHALERTALARM), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__PHCRITICALALARM), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__BOOSTERPUMPALARM0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__BOOSTERPUMPALARM1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__BOOSTERPUMPALARM2), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__ISOLATIONVALVEALARM0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__ISOLATIONVALVEALARM1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__ISOLATIONVALVEALARM2), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__FLOWSENSORALARM0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__FLOWSENSORALARM1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__FLOWSENSORALARM2), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__EXCESSIVEFLOWALARM0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__EXCESSIVEFLOWALARM1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__EXCESSIVEFLOWALARM2), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__EDUCTORVALVEALARM0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__EDUCTORVALVEALARM1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__EDUCTORVALVEALARM2), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__DISTRIBUTIONPUMPCOMMAND), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__DISTRIBUTIONPUMPALARM), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__HIGHPRESSURESWITCHALARM0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__HIGHPRESSURESWITCHALARM1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__HIGHPRESSURESWITCHALARM2), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__ASKHMICONTAINMENTUNITATTACHED), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__ASKHMICONTAINMENTUNITFULL), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__DISPOSALVALVEALARM), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK0_CAPACITYALARM), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK1_CAPACITYALARM), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK2_CAPACITYALARM), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__CENTRALTANKALARMSWITCH), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__CONTROLCENTERHORNSTROBEALARM), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__PHWARNINGHMI), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__PHCRITICALHMI), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__HMITANKDISPOSALBUTTON), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__ISCONTAINMENTUNITATTACHED), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__ISCONTAINMENTUNITFULL), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__FLOW_SENSOR_MAX_CAPACITY), INT_ENUM},*)
(*DBG:    {&(CONFIG0__WARNING_ACIDIC_LEVEL), INT_ENUM},*)
(*DBG:    {&(CONFIG0__CRITICAL_ACIDIC_LEVEL), INT_ENUM},*)
(*DBG:    {&(CONFIG0__WARNING_BASIC_LEVEL), INT_ENUM},*)
(*DBG:    {&(CONFIG0__CRITICAL_BASIC_LEVEL), INT_ENUM},*)
(*DBG:    {&(CONFIG0__DISTRIBUTIONPUMPPRESSUREREDUCTIONFLAG), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK0_30CAPACITY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK1_30CAPACITY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK2_30CAPACITY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK0_60CAPACITY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK1_60CAPACITY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK2_60CAPACITY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK0_90CAPACITY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK1_90CAPACITY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK2_90CAPACITY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK0_DISPOSALREADY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK1_DISPOSALREADY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__TANK2_DISPOSALREADY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__ALLTANKSNEARCAPACITY), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__STARTSTIRPROTOCOL0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__STARTSTIRPROTOCOL1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__STARTSTIRPROTOCOL2), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__STOPSTIRPROTOCOL0), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__STOPSTIRPROTOCOL1), BOOL_ENUM},*)
(*DBG:    {&(CONFIG0__STOPSTIRPROTOCOL2), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.FLOWRATESENSOR0), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.FLOWRATESENSOR1), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.FLOWRATESENSOR2), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BOOSTERPUMPSTATUS0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BOOSTERPUMPSTATUS1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BOOSTERPUMPSTATUS2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ISOLATIONVALVESTATUS0), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ISOLATIONVALVESTATUS1), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ISOLATIONVALVESTATUS2), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.GENERALSITEALARM0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BOOSTERPUMPCOMMAND0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BOOSTERPUMPCOMMAND1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BOOSTERPUMPCOMMAND2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BOOSTERPUMPALARM0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BOOSTERPUMPALARM1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.BOOSTERPUMPALARM2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ISOLATIONVALVEALARM0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ISOLATIONVALVEALARM1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ISOLATIONVALVEALARM2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.FLOWSENSORALARM0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.FLOWSENSORALARM1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.FLOWSENSORALARM2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.EXCESSIVEFLOWALARM0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.EXCESSIVEFLOWALARM1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.EXCESSIVEFLOWALARM2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ISOLATIONVALVECOMMAND0), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ISOLATIONVALVECOMMAND1), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ISOLATIONVALVECOMMAND2), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.FLOW_SENSOR_MAX_CAPACITY), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_INT_TO_REAL52_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_MUL69_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_REAL_TO_INT102_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_GT4_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_INT_TO_REAL51_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_MUL5_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_REAL_TO_INT49_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_GT10_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_INT_TO_REAL114_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_MUL11_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_REAL_TO_INT50_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_GT8_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_XOR24_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_XOR27_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_SELECTISOLATIONVALVEVALUE19_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_SELECTISOLATIONVALVEVALUE25_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_ISWITHIN5PERCENT68_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_NOT79_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_ISWITHIN5PERCENT57_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_NOT80_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_ISWITHIN5PERCENT61_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_NOT81_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_XOR18_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_SELECTISOLATIONVALVEVALUE92_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_SETFLOWSENSORALARM100_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_SETFLOWSENSORALARM44_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_SETFLOWSENSORALARM46_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_GT117_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_GT74_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_GT78_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.EDUCTORVALVESTATUS0), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.EDUCTORVALVESTATUS1), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.EDUCTORVALVESTATUS2), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ULTRASONICTANKLEVELSENSOR0), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ULTRASONICTANKLEVELSENSOR1), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ULTRASONICTANKLEVELSENSOR2), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALVALVESTATUS), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISTRIBUTIONPUMPSTATUS), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.HIGHPRESSURESWITCH0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.HIGHPRESSURESWITCH1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.HIGHPRESSURESWITCH2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.EDUCTORVALVECOMMAND0), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.EDUCTORVALVECOMMAND1), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.EDUCTORVALVECOMMAND2), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.EDUCTORVALVEALARM0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.EDUCTORVALVEALARM1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.EDUCTORVALVEALARM2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISTRIBUTIONPUMPCOMMAND), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISTRIBUTIONPUMPSPEEDCOMMAND), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALVALVECOMMAND), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISTRIBUTIONPUMPPRESSUREREDUCTIONFLAG), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK0_30CAPACITY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK1_30CAPACITY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK2_30CAPACITY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK0_60CAPACITY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK1_60CAPACITY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK2_60CAPACITY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK0_90CAPACITY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK1_90CAPACITY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK2_90CAPACITY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK0_DISPOSALREADY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK1_DISPOSALREADY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK2_DISPOSALREADY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ALLTANKSNEARCAPACITY), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISTRIBUTIONPUMPALARM), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.HIGHPRESSURESWITCHALARM0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.HIGHPRESSURESWITCHALARM1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.HIGHPRESSURESWITCHALARM2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ASKHMICONTAINMENTUNITATTACHED), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ASKHMICONTAINMENTUNITFULL), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALVALVEALARM), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK0_CAPACITYALARM), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK1_CAPACITYALARM), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK2_CAPACITYALARM), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.CENTRALTANKALARMSWITCH), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.CONTROLCENTERHORNSTROBEALARM), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.PHWARNINGHMI), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.PHCRITICALHMI), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.HMITANKDISPOSALBUTTON), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ISCONTAINMENTUNITATTACHED), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ISCONTAINMENTUNITFULL), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.STARTSTIRPROTOCOL0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.STARTSTIRPROTOCOL1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.STARTSTIRPROTOCOL2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.STOPSTIRPROTOCOL0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.STOPSTIRPROTOCOL1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.STOPSTIRPROTOCOL2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.BOOSTERPUMPCOMMAND0), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.BOOSTERPUMPCOMMAND1), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.BOOSTERPUMPCOMMAND2), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ISOLATIONVALVECOMMAND0), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ISOLATIONVALVECOMMAND1), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.ISOLATIONVALVECOMMAND2), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.PHALERTALARM), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.PHCRITICALALARM), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.PULSEIN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.DISTRIBUTIONPUMPOUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.R_TRIG0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.R_TRIG0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.R_TRIG0.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.R_TRIG0.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET0.R_TRIG0.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0.DISTRIBUTIONPUMPSPEEDIN), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0.DISPOSALVALVECOMMANDIN), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0.OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0.DISTRIBUTIONPUMPSPEEDOUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0.DISPOSALVALVECOMMANDOUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0._TMP_MOVE3_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0._TMP_MOVE3_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0._TMP_MOVE6_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL0._TMP_MOVE6_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1.DISTRIBUTIONPUMPSPEEDIN), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1.DISPOSALVALVECOMMANDIN), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1.OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1.DISTRIBUTIONPUMPSPEEDOUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1.DISPOSALVALVECOMMANDOUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1._TMP_MOVE3_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1._TMP_MOVE3_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1._TMP_MOVE6_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.DISPOSALPROTOCOL1._TMP_MOVE6_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON0.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON0.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON0.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON0.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON0.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON0.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON0.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON0.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS0.S), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS0.R1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS0.Q1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.PULSEIN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.DISTRIBUTIONPUMPOUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.R_TRIG0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.R_TRIG0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.R_TRIG0.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.R_TRIG0.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET1.R_TRIG0.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS1.S), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS1.R1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS1.Q1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON1.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON1.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON1.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON1.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON1.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON1.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON1.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.PULSEIN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.DISTRIBUTIONPUMPOUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.R_TRIG0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.R_TRIG0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.R_TRIG0.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.R_TRIG0.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TANK15MINUTERESET2.R_TRIG0.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS2.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS2.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS2.S), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS2.R1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.RS2.Q1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON2.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON2.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON2.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON2.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON2.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON2.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON2.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON2.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON2.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.TON2.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT3_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_NOT4_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT10_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_NOT11_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT15_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_NOT14_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_XOR23_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT42_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT30_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT31_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_SETDISTRIBUTIONPUMPSPEED48_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_GE52_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_GE34_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_GE56_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_GE60_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_GE64_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_GE69_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_GE72_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_GE76_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_GE81_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE146_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE146_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE117_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE117_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE132_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE132_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_NE184_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE200_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE200_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE111_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE111_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE143_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE143_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE156_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_MOVE156_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG1.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG1.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_SEL237_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_INT_TO_BOOL251_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG2.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG2.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG2.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG2.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG2.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_SEL97_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_INT_TO_BOOL96_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG3.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG3.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG3.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG3.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1.F_TRIG3.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_SEL233_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE1._TMP_INT_TO_BOOL232_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE2.PHSENSOR), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE2.WARNING_ACIDIC_LEVEL), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE2.CRITICAL_ACIDIC_LEVEL), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE2.WARNING_BASIC_LEVEL), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE2.CRITICAL_BASIC_LEVEL), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE2.PHALERTALARM), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE2.PHCRITICALALARM), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE2._TMP_ISOUTSIDEPHRANGE4_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE2._TMP_ISOUTSIDEPHRANGE9_OUT), BOOL_ENUM},*)
(*DBG:};*)
(*DBG:*)
(*DBG:#define VAR_COUNT               438*)
(*DBG:*)
(*DBG:uint16_t get_var_count(void)*)
(*DBG:{*)
(*DBG:    return VAR_COUNT;*)
(*DBG:}*)
(*DBG:*)
(*DBG:size_t get_var_size(size_t idx)*)
(*DBG:{*)
(*DBG:    if (idx >= VAR_COUNT)*)
(*DBG:    {*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case TIME_ENUM:*)
(*DBG:        return sizeof(TIME);*)
(*DBG:    case SINT_ENUM:*)
(*DBG:        return sizeof(SINT);*)
(*DBG:    case INT_ENUM:*)
(*DBG:    case INT_P_ENUM:*)
(*DBG:        return sizeof(INT);*)
(*DBG:    case REAL_ENUM:*)
(*DBG:        return sizeof(REAL);*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:    case BOOL_P_ENUM:*)
(*DBG:        return sizeof(BOOL);*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void *get_var_addr(size_t idx)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case TIME_ENUM:*)
(*DBG:        return (void *)&((__IEC_TIME_t *) ptr)->value;*)
(*DBG:    case SINT_ENUM:*)
(*DBG:        return (void *)&((__IEC_SINT_t *) ptr)->value;*)
(*DBG:    case INT_ENUM:*)
(*DBG:        return (void *)&((__IEC_INT_t *) ptr)->value;*)
(*DBG:    case INT_P_ENUM:*)
(*DBG:        return (void *)((((__IEC_INT_p *) ptr)->flags & __IEC_FORCE_FLAG) *)
(*DBG:                        ? &(((__IEC_INT_p *) ptr)->fvalue) *)
(*DBG:                        : ((__IEC_INT_p *) ptr)->value);*)
(*DBG:    case REAL_ENUM:*)
(*DBG:        return (void *)&((__IEC_REAL_t *) ptr)->value;*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return (void *)&((__IEC_BOOL_t *) ptr)->value;*)
(*DBG:    case BOOL_P_ENUM:*)
(*DBG:        return (void *)((((__IEC_BOOL_p *) ptr)->flags & __IEC_FORCE_FLAG) *)
(*DBG:                        ? &(((__IEC_BOOL_p *) ptr)->fvalue) *)
(*DBG:                        : ((__IEC_BOOL_p *) ptr)->value);*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void force_var(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    if (forced) {*)
(*DBG:        size_t var_size = get_var_size(idx);*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case TIME_ENUM: {*)
(*DBG:            memcpy(&((__IEC_TIME_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_TIME_t *) ptr)->value = *((TIME *) val);*)
(*DBG:            ((__IEC_TIME_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case SINT_ENUM: {*)
(*DBG:            memcpy(&((__IEC_SINT_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_SINT_t *) ptr)->value = *((SINT *) val);*)
(*DBG:            ((__IEC_SINT_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case INT_ENUM: {*)
(*DBG:            memcpy(&((__IEC_INT_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_INT_t *) ptr)->value = *((INT *) val);*)
(*DBG:            ((__IEC_INT_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case INT_P_ENUM: {*)
(*DBG:            memcpy(&((__IEC_INT_p *) ptr)->fvalue, val, var_size);*)
(*DBG:            //((__IEC_INT_p *) ptr)->fvalue = *((INT *) val);*)
(*DBG:            ((__IEC_INT_p *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case REAL_ENUM: {*)
(*DBG:            memcpy(&((__IEC_REAL_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_REAL_t *) ptr)->value = *((REAL *) val);*)
(*DBG:            ((__IEC_REAL_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case BOOL_ENUM: {*)
(*DBG:            memcpy(&((__IEC_BOOL_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_BOOL_t *) ptr)->value = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case BOOL_P_ENUM: {*)
(*DBG:            memcpy(&((__IEC_BOOL_p *) ptr)->fvalue, val, var_size);*)
(*DBG:            //((__IEC_BOOL_p *) ptr)->fvalue = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_p *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    } else {*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case TIME_ENUM:*)
(*DBG:            ((__IEC_TIME_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case SINT_ENUM:*)
(*DBG:            ((__IEC_SINT_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case INT_ENUM:*)
(*DBG:            ((__IEC_INT_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case INT_P_ENUM:*)
(*DBG:            ((__IEC_INT_p *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case REAL_ENUM:*)
(*DBG:            ((__IEC_REAL_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case BOOL_ENUM:*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case BOOL_P_ENUM:*)
(*DBG:            ((__IEC_BOOL_p *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void swap_bytes(void *ptr, size_t size) *)
(*DBG:{*)
(*DBG:    uint8_t *bytePtr = (uint8_t *)ptr;*)
(*DBG:    size_t i;*)
(*DBG:    for (i = 0; i < size / 2; ++i) *)
(*DBG:    {*)
(*DBG:        uint8_t temp = bytePtr[i];*)
(*DBG:        bytePtr[i] = bytePtr[size - 1 - i];*)
(*DBG:        bytePtr[size - 1 - i] = temp;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void trace_reset(void)*)
(*DBG:{*)
(*DBG:    for (size_t i=0; i < VAR_COUNT; i++) *)
(*DBG:    {*)
(*DBG:        force_var(i, false, 0);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_trace(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    if (idx >= 0 && idx < VAR_COUNT) *)
(*DBG:    {*)
(*DBG:        if (endianness == REVERSE_ENDIANNESS)*)
(*DBG:        {*)
(*DBG:            // Aaaaarghhhh... Stupid AVR is Big Endian.*)
(*DBG:            swap_bytes(val, get_var_size(idx));*)
(*DBG:        }*)
(*DBG:*)
(*DBG:        force_var(idx, forced, val);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_endianness(uint8_t value)*)
(*DBG:{*)
(*DBG:    if (value == SAME_ENDIANNESS || value == REVERSE_ENDIANNESS)*)
(*DBG:    {*)
(*DBG:        endianness = value;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)