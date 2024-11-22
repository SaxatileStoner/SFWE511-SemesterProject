/*
 * DEBUGGER code
 * 
 * On "publish", when buffer is free, debugger stores arbitrary variables 
 * content into, and mark this buffer as filled
 * 
 * 
 * Buffer content is read asynchronously, (from non real time part), 
 * and then buffer marked free again.
 *  
 * 
 * */
#ifdef TARGET_DEBUG_AND_RETAIN_DISABLE

void __init_debug    (void){}
void __cleanup_debug (void){}
void __retrieve_debug(void){}
void __publish_debug (void){}

#else

#include "iec_types_all.h"
#include "POUS.h"
/*for memcpy*/
#include <string.h>
#include <stdio.h>

typedef unsigned int dbgvardsc_index_t;
typedef unsigned short trace_buf_offset_t;

#define BUFFER_EMPTY 0
#define BUFFER_FULL 1

#ifndef TARGET_ONLINE_DEBUG_DISABLE

#define TRACE_BUFFER_SIZE 4096
#define TRACE_LIST_SIZE 1024

/* Atomically accessed variable for buffer state */
static long trace_buffer_state = BUFFER_EMPTY;

typedef struct trace_item_s {
    dbgvardsc_index_t dbgvardsc_index;
} trace_item_t;

trace_item_t trace_list[TRACE_LIST_SIZE];
char trace_buffer[TRACE_BUFFER_SIZE];

/* Trace's cursor*/
static trace_item_t *trace_list_collect_cursor = trace_list;
static trace_item_t *trace_list_addvar_cursor = trace_list;
static const trace_item_t *trace_list_end = 
    &trace_list[TRACE_LIST_SIZE-1];
static char *trace_buffer_cursor = trace_buffer;
static const char *trace_buffer_end = trace_buffer + TRACE_BUFFER_SIZE;



#define FORCE_BUFFER_SIZE 1024
#define FORCE_LIST_SIZE 256

typedef struct force_item_s {
    dbgvardsc_index_t dbgvardsc_index;
    void *value_pointer_backup;
} force_item_t;

force_item_t force_list[FORCE_LIST_SIZE];
char force_buffer[FORCE_BUFFER_SIZE];

/* Force's cursor*/
static force_item_t *force_list_apply_cursor = force_list;
static force_item_t *force_list_addvar_cursor = force_list;
static const force_item_t *force_list_end = 
    &force_list[FORCE_LIST_SIZE-1];
static char *force_buffer_cursor = force_buffer;
static const char *force_buffer_end = force_buffer + FORCE_BUFFER_SIZE;


#endif

/***
 * Declare programs 
 **/
extern DCSPROGRAMSECTOR RES0__INSTANCE0;
extern SCADATANKLEVELPROGRAM RES0__INSTANCE1;
extern SCADAPHTANKMONITORPROGRAM RES0__INSTANCE2;

/***
 * Declare global variables from resources and conf 
 **/
extern __IEC_BOOL_p CONFIG0__BOOSTERPUMPCOMMAND0;
extern __IEC_BOOL_p CONFIG0__BOOSTERPUMPCOMMAND1;
extern __IEC_BOOL_p CONFIG0__BOOSTERPUMPCOMMAND2;
extern __IEC_REAL_p CONFIG0__ISOLATIONVALVECOMMAND0;
extern __IEC_REAL_p CONFIG0__ISOLATIONVALVECOMMAND1;
extern __IEC_REAL_p CONFIG0__ISOLATIONVALVECOMMAND2;
extern __IEC_BOOL_p CONFIG0__PHALERTALARM;
extern __IEC_BOOL_p CONFIG0__PHCRITICALALARM;
extern       DCSPROGRAMSECTOR   RES0__INSTANCE0;
extern       SCADATANKLEVELPROGRAM   RES0__INSTANCE1;
extern       SCADAPHTANKMONITORPROGRAM   RES0__INSTANCE2;

typedef const struct {
    void *ptr;
    __IEC_types_enum type;
} dbgvardsc_t;

static const dbgvardsc_t dbgvardsc[] = {
{&(CONFIG0__BOOSTERPUMPCOMMAND0), BOOL_O_ENUM},
{&(CONFIG0__BOOSTERPUMPCOMMAND1), BOOL_O_ENUM},
{&(CONFIG0__BOOSTERPUMPCOMMAND2), BOOL_O_ENUM},
{&(CONFIG0__ISOLATIONVALVECOMMAND0), REAL_O_ENUM},
{&(CONFIG0__ISOLATIONVALVECOMMAND1), REAL_O_ENUM},
{&(CONFIG0__ISOLATIONVALVECOMMAND2), REAL_O_ENUM},
{&(CONFIG0__PHALERTALARM), BOOL_O_ENUM},
{&(CONFIG0__PHCRITICALALARM), BOOL_O_ENUM},
{&(RES0__INSTANCE0.FLOWRATESENSOR0), INT_P_ENUM},
{&(RES0__INSTANCE0.FLOWRATESENSOR1), INT_P_ENUM},
{&(RES0__INSTANCE0.FLOWRATESENSOR2), INT_P_ENUM},
{&(RES0__INSTANCE0.BOOSTERPUMPSTATUS0), BOOL_P_ENUM},
{&(RES0__INSTANCE0.BOOSTERPUMPSTATUS1), BOOL_P_ENUM},
{&(RES0__INSTANCE0.BOOSTERPUMPSTATUS2), BOOL_P_ENUM},
{&(RES0__INSTANCE0.ISOLATIONVALVESTATUS0), REAL_P_ENUM},
{&(RES0__INSTANCE0.ISOLATIONVALVESTATUS1), REAL_P_ENUM},
{&(RES0__INSTANCE0.ISOLATIONVALVESTATUS2), REAL_P_ENUM},
{&(RES0__INSTANCE0.GENERALSITEALARM0), BOOL_P_ENUM},
{&(RES0__INSTANCE0.BOOSTERPUMPCOMMAND0), BOOL_P_ENUM},
{&(RES0__INSTANCE0.BOOSTERPUMPCOMMAND1), BOOL_P_ENUM},
{&(RES0__INSTANCE0.BOOSTERPUMPCOMMAND2), BOOL_P_ENUM},
{&(RES0__INSTANCE0.BOOSTERPUMPALARM0), BOOL_O_ENUM},
{&(RES0__INSTANCE0.BOOSTERPUMPALARM1), BOOL_O_ENUM},
{&(RES0__INSTANCE0.BOOSTERPUMPALARM2), BOOL_O_ENUM},
{&(RES0__INSTANCE0.ISOLATIONVALVEALARM0), BOOL_O_ENUM},
{&(RES0__INSTANCE0.ISOLATIONVALVEALARM1), BOOL_O_ENUM},
{&(RES0__INSTANCE0.ISOLATIONVALVEALARM2), BOOL_O_ENUM},
{&(RES0__INSTANCE0.FLOWSENSORALARM0), BOOL_O_ENUM},
{&(RES0__INSTANCE0.FLOWSENSORALARM1), BOOL_O_ENUM},
{&(RES0__INSTANCE0.FLOWSENSORALARM2), BOOL_O_ENUM},
{&(RES0__INSTANCE0.ISOLATIONVALVECOMMAND0), REAL_P_ENUM},
{&(RES0__INSTANCE0.ISOLATIONVALVECOMMAND1), REAL_P_ENUM},
{&(RES0__INSTANCE0.ISOLATIONVALVECOMMAND2), REAL_P_ENUM},
{&(RES0__INSTANCE0.FLOWSENSORMAXCAPACITY), REAL_O_ENUM},
{&(RES0__INSTANCE0._TMP_MUL69_OUT), REAL_ENUM},
{&(RES0__INSTANCE0._TMP_REAL_TO_INT102_OUT), INT_ENUM},
{&(RES0__INSTANCE0._TMP_GT4_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_MUL5_OUT), REAL_ENUM},
{&(RES0__INSTANCE0._TMP_REAL_TO_INT49_OUT), INT_ENUM},
{&(RES0__INSTANCE0._TMP_GT10_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_MUL11_OUT), REAL_ENUM},
{&(RES0__INSTANCE0._TMP_REAL_TO_INT50_OUT), INT_ENUM},
{&(RES0__INSTANCE0._TMP_GT8_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_XOR24_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_XOR27_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_SELECTISOLATIONVALVEVALUE19_OUT), REAL_ENUM},
{&(RES0__INSTANCE0._TMP_SELECTISOLATIONVALVEVALUE25_OUT), REAL_ENUM},
{&(RES0__INSTANCE0._TMP_ISWITHIN5PERCENT68_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_NOT79_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_ISWITHIN5PERCENT57_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_NOT80_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_ISWITHIN5PERCENT61_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_NOT81_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_XOR18_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_SELECTISOLATIONVALVEVALUE92_OUT), REAL_ENUM},
{&(RES0__INSTANCE0._TMP_SETFLOWSENSORALARM100_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_SETFLOWSENSORALARM44_OUT), BOOL_ENUM},
{&(RES0__INSTANCE0._TMP_SETFLOWSENSORALARM46_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1.EDUCTORVALVESTATUS0), REAL_P_ENUM},
{&(RES0__INSTANCE1.EDUCTORVALVESTATUS1), REAL_P_ENUM},
{&(RES0__INSTANCE1.EDUCTORVALVESTATUS2), REAL_P_ENUM},
{&(RES0__INSTANCE1.ULTRASONICTANKLEVELSENSOR0), REAL_P_ENUM},
{&(RES0__INSTANCE1.ULTRASONICTANKLEVELSENSOR1), REAL_P_ENUM},
{&(RES0__INSTANCE1.ULTRASONICTANKLEVELSENSOR2), REAL_P_ENUM},
{&(RES0__INSTANCE1.DISPOSALVALVESTATUS), REAL_P_ENUM},
{&(RES0__INSTANCE1.DISTRIBUTIONPUMPSTATUS), BOOL_P_ENUM},
{&(RES0__INSTANCE1.HIGHPRESSURESWITCH0), BOOL_P_ENUM},
{&(RES0__INSTANCE1.HIGHPRESSURESWITCH1), BOOL_P_ENUM},
{&(RES0__INSTANCE1.HIGHPRESSURESWITCH2), BOOL_P_ENUM},
{&(RES0__INSTANCE1.ISCONTAINMENTUNITATTACHED), BOOL_P_ENUM},
{&(RES0__INSTANCE1.ISCONTAINMENTUNITFULL), BOOL_P_ENUM},
{&(RES0__INSTANCE1.EDUCTORVALVECOMMAND0), REAL_O_ENUM},
{&(RES0__INSTANCE1.EDUCTORVALVECOMMAND1), REAL_O_ENUM},
{&(RES0__INSTANCE1.EDUCTORVALVECOMMAND2), REAL_O_ENUM},
{&(RES0__INSTANCE1.EDUCTORVALVEALARM0), BOOL_O_ENUM},
{&(RES0__INSTANCE1.EDUCTORVALVEALARM1), BOOL_O_ENUM},
{&(RES0__INSTANCE1.EDUCTORVALVEALARM2), BOOL_O_ENUM},
{&(RES0__INSTANCE1.DISTRIBUTIONPUMPCOMMAND), BOOL_O_ENUM},
{&(RES0__INSTANCE1.DISTRIBUTIONPUMPSPEEDCOMMAND), REAL_O_ENUM},
{&(RES0__INSTANCE1.DISPOSALVALVECOMMAND), REAL_O_ENUM},
{&(RES0__INSTANCE1.DISTRIBUTIONPUMPPRESSUREREDUCTIONFLAG), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANK30CAPACITY0), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANK30CAPACITY1), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANK30CAPACITY2), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANK60CAPACITY0), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANK60CAPACITY1), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANK60CAPACITY2), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANK90CAPACITY0), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANK90CAPACITY1), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANK90CAPACITY2), BOOL_O_ENUM},
{&(RES0__INSTANCE1.ISTANK0DISPOSALREADY), BOOL_O_ENUM},
{&(RES0__INSTANCE1.ISTANK1DISPOSALREADY), BOOL_O_ENUM},
{&(RES0__INSTANCE1.ISTANK2DISPOSALREADY), BOOL_O_ENUM},
{&(RES0__INSTANCE1.ALLTANKSNEARCAPACITY), BOOL_O_ENUM},
{&(RES0__INSTANCE1.DISTRIBUTIONPUMPALARM), BOOL_O_ENUM},
{&(RES0__INSTANCE1.HIGHPRESSURESWITCHALARM0), BOOL_O_ENUM},
{&(RES0__INSTANCE1.HIGHPRESSURESWITCHALARM1), BOOL_O_ENUM},
{&(RES0__INSTANCE1.HIGHPRESSURESWITCHALARM2), BOOL_O_ENUM},
{&(RES0__INSTANCE1.ASKHMICONTAINMENTUNITATTACHED), BOOL_O_ENUM},
{&(RES0__INSTANCE1.ASKHMICONTAINMENTUNITFULL), BOOL_O_ENUM},
{&(RES0__INSTANCE1.DISPOSALVALVEALARM), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANKCAPACITYALARM0), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANKCAPACITYALARM1), BOOL_O_ENUM},
{&(RES0__INSTANCE1.TANKCAPACITYALARM2), BOOL_O_ENUM},
{&(RES0__INSTANCE1.CENTRALTANKALARMSWITCH), BOOL_O_ENUM},
{&(RES0__INSTANCE1.CONTROLCENTERHORNSTROBEALARM), BOOL_O_ENUM},
{&(RES0__INSTANCE1.PHWARNINGHMI), BOOL_O_ENUM},
{&(RES0__INSTANCE1.PHCRITICALHMI), BOOL_O_ENUM},
{&(RES0__INSTANCE1.BOOSTERPUMPCOMMAND0), BOOL_P_ENUM},
{&(RES0__INSTANCE1.BOOSTERPUMPCOMMAND1), BOOL_P_ENUM},
{&(RES0__INSTANCE1.BOOSTERPUMPCOMMAND2), BOOL_P_ENUM},
{&(RES0__INSTANCE1.ISOLATIONVALVECOMMAND0), REAL_P_ENUM},
{&(RES0__INSTANCE1.ISOLATIONVALVECOMMAND1), REAL_P_ENUM},
{&(RES0__INSTANCE1.ISOLATIONVALVECOMMAND2), REAL_P_ENUM},
{&(RES0__INSTANCE1.PHALERTALARM), BOOL_P_ENUM},
{&(RES0__INSTANCE1.PHCRITICALALARM), BOOL_P_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.PULSEIN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.DISTRIBUTIONPUMPOUT), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.EDUCTORVALVEOUT), REAL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.PT), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.ET), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.STATE), SINT_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.PREV_IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.CURRENT_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TON1.START_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.PT), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.ET), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.STATE), SINT_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.PREV_IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.CURRENT_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0.TP1.START_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0._TMP_MOVE100_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET0._TMP_MOVE100_OUT), REAL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.PULSEIN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.DISTRIBUTIONPUMPOUT), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.EDUCTORVALVEOUT), REAL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.PT), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.ET), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.STATE), SINT_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.PREV_IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.CURRENT_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TON1.START_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.PT), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.ET), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.STATE), SINT_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.PREV_IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.CURRENT_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1.TP1.START_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1._TMP_MOVE100_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET1._TMP_MOVE100_OUT), REAL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.PULSEIN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.DISTRIBUTIONPUMPOUT), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.EDUCTORVALVEOUT), REAL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.PT), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.ET), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.STATE), SINT_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.PREV_IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.CURRENT_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TON1.START_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.PT), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.ET), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.STATE), SINT_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.PREV_IN), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.CURRENT_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2.TP1.START_TIME), TIME_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2._TMP_MOVE100_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.TANK15MINUTERESET2._TMP_MOVE100_OUT), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0.IN), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0.DISTRIBUTIONPUMPSPEEDIN), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0.DISPOSALVALVECOMMANDIN), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0.OUT), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0.DISTRIBUTIONPUMPSPEEDOUT), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0.DISPOSALVALVECOMMANDOUT), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0._TMP_MOVE3_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0._TMP_MOVE3_OUT), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0._TMP_MOVE6_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL0._TMP_MOVE6_OUT), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1.IN), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1.DISTRIBUTIONPUMPSPEEDIN), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1.DISPOSALVALVECOMMANDIN), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1.OUT), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1.DISTRIBUTIONPUMPSPEEDOUT), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1.DISPOSALVALVECOMMANDOUT), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1._TMP_MOVE3_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1._TMP_MOVE3_OUT), REAL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1._TMP_MOVE6_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.DISPOSALPROTOCOL1._TMP_MOVE6_OUT), REAL_ENUM},
{&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT3_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_NOT4_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT10_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_NOT11_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT15_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_NOT14_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_XOR23_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT42_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT30_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_ISWITHIN5PERCENT31_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_SETDISTRIBUTIONPUMPSPEED48_OUT), REAL_ENUM},
{&(RES0__INSTANCE1._TMP_GE52_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_GE34_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_GE56_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_GE60_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_GE64_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_GE69_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_GE72_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_GE76_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_GE81_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG1.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG1.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG1.CLK), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG1.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG1.M), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE84_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE84_OUT), REAL_ENUM},
{&(RES0__INSTANCE1.R_TRIG2.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG2.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG2.CLK), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG2.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG2.M), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE89_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE89_OUT), REAL_ENUM},
{&(RES0__INSTANCE1.R_TRIG3.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG3.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG3.CLK), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG3.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG3.M), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE94_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE94_OUT), REAL_ENUM},
{&(RES0__INSTANCE1.R_TRIG4.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG4.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG4.CLK), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG4.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG4.M), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG5.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG5.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG5.CLK), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG5.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG5.M), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG6.EN), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG6.ENO), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG6.CLK), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG6.Q), BOOL_ENUM},
{&(RES0__INSTANCE1.R_TRIG6.M), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE146_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE146_OUT), REAL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE117_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE117_OUT), REAL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE132_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE132_OUT), REAL_ENUM},
{&(RES0__INSTANCE1._TMP_NE184_OUT), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE200_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE200_OUT), REAL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE111_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE111_OUT), REAL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE143_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE143_OUT), REAL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE156_ENO), BOOL_ENUM},
{&(RES0__INSTANCE1._TMP_MOVE156_OUT), REAL_ENUM},
{&(RES0__INSTANCE2.PHSENSOR), REAL_P_ENUM},
{&(RES0__INSTANCE2.ACIDICLEVEL), REAL_O_ENUM},
{&(RES0__INSTANCE2.CRITICALACIDICLEVEL), REAL_O_ENUM},
{&(RES0__INSTANCE2.BASICLEVEL), REAL_O_ENUM},
{&(RES0__INSTANCE2.CRITICALBASICLEVEL), REAL_O_ENUM},
{&(RES0__INSTANCE2.PHALERTALARM), BOOL_P_ENUM},
{&(RES0__INSTANCE2.PHCRITICALALARM), BOOL_P_ENUM},
{&(RES0__INSTANCE2._TMP_ISOUTSIDEPHRANGE4_OUT), BOOL_ENUM},
{&(RES0__INSTANCE2._TMP_ISOUTSIDEPHRANGE9_OUT), BOOL_ENUM}
};

static const dbgvardsc_index_t retain_list[] = {
/* RES0__INSTANCE1.R_TRIG1.M */ 245,
/* RES0__INSTANCE1.R_TRIG2.M */ 252,
/* RES0__INSTANCE1.R_TRIG3.M */ 259,
/* RES0__INSTANCE1.R_TRIG4.M */ 266,
/* RES0__INSTANCE1.R_TRIG5.M */ 271,
/* RES0__INSTANCE1.R_TRIG6.M */ 276
};
static unsigned int retain_list_collect_cursor = 0;
static const unsigned int retain_list_size = sizeof(retain_list)/sizeof(dbgvardsc_index_t);

typedef void(*__for_each_variable_do_fp)(dbgvardsc_t*);
void __for_each_variable_do(__for_each_variable_do_fp fp)
{
    unsigned int i;
    for(i = 0; i < sizeof(dbgvardsc)/sizeof(dbgvardsc_t); i++){
        dbgvardsc_t *dsc = &dbgvardsc[i];
        if(dsc->type != UNKNOWN_ENUM) 
            (*fp)(dsc);
    }
}

#define __Unpack_desc_type dbgvardsc_t


#define __Unpack_case_t(TYPENAME)                                           \
        case TYPENAME##_ENUM :                                              \
            if(flags) *flags = ((__IEC_##TYPENAME##_t *)varp)->flags;       \
            if(value_p) *value_p = &((__IEC_##TYPENAME##_t *)varp)->value;  \
		    if(size) *size = sizeof(TYPENAME);                              \
            break;

#define __Unpack_case_p(TYPENAME)                                           \
        case TYPENAME##_O_ENUM :                                            \
        case TYPENAME##_P_ENUM :                                            \
            if(flags) *flags = ((__IEC_##TYPENAME##_p *)varp)->flags;       \
            if(value_p) *value_p = ((__IEC_##TYPENAME##_p *)varp)->value;   \
		    if(size) *size = sizeof(TYPENAME);                              \
            break;

#define __Is_a_string(dsc) (dsc->type == STRING_ENUM)   ||\
                           (dsc->type == STRING_P_ENUM) ||\
                           (dsc->type == STRING_O_ENUM)

static int UnpackVar(__Unpack_desc_type *dsc, void **value_p, char *flags, size_t *size)
{
    void *varp = dsc->ptr;
    /* find data to copy*/
    switch(dsc->type){
        __ANY(__Unpack_case_t)
        __ANY(__Unpack_case_p)
    default:
        return 0; /* should never happen */
    }
    return 1;
}



void Remind(unsigned int offset, unsigned int count, void * p);

extern int CheckRetainBuffer(void);
extern void InitRetain(void);

void __init_debug(void)
{
    /* init local static vars */
#ifndef TARGET_ONLINE_DEBUG_DISABLE
    trace_buffer_cursor = trace_buffer;
    trace_list_addvar_cursor = trace_list;
    trace_list_collect_cursor = trace_list;
    trace_buffer_state = BUFFER_EMPTY;

    force_buffer_cursor = force_buffer;
    force_list_addvar_cursor = force_list;
    force_list_apply_cursor = force_list;
#endif

    InitRetain();
    /* Iterate over all variables to fill debug buffer */
    if(CheckRetainBuffer()){
        unsigned int retain_offset = 0;
        retain_list_collect_cursor = 0;

        /* iterate over retain list */
        while(retain_list_collect_cursor < retain_list_size){
            void *value_p = NULL;
            size_t size;
            char* next_cursor;

            dbgvardsc_t *dsc = &dbgvardsc[
                retain_list[retain_list_collect_cursor]];

            UnpackVar(dsc, &value_p, NULL, &size);

            /* if buffer not full */
            Remind(retain_offset, size, value_p);
            /* increment cursor according size*/
            retain_offset += size;

            retain_list_collect_cursor++;
        }
    }else{
        char mstr[] = "RETAIN memory invalid - defaults used";
        LogMessage(LOG_WARNING, mstr, sizeof(mstr));
    }
}

extern void InitiateDebugTransfer(void);
extern void CleanupRetain(void);

extern unsigned long __tick;

void __cleanup_debug(void)
{
#ifndef TARGET_ONLINE_DEBUG_DISABLE
    trace_buffer_cursor = trace_buffer;
    InitiateDebugTransfer();
#endif    

    CleanupRetain();
}

void __retrieve_debug(void)
{
}

void Retain(unsigned int offset, unsigned int count, void * p);

/* Return size of all retain variables */
unsigned int GetRetainSize(void)
{
    unsigned int retain_size = 0;
    retain_list_collect_cursor = 0;

    /* iterate over retain list */
    while(retain_list_collect_cursor < retain_list_size){
        void *value_p = NULL;
        size_t size;
        char* next_cursor;

        dbgvardsc_t *dsc = &dbgvardsc[
            retain_list[retain_list_collect_cursor]];

        UnpackVar(dsc, &value_p, NULL, &size);

        retain_size += size;
        retain_list_collect_cursor++;
    }

    return retain_size;
}


extern void PLC_GetTime(IEC_TIME*);
extern int TryEnterDebugSection(void);
extern long AtomicCompareExchange(long*, long, long);
extern long long AtomicCompareExchange64(long long* , long long , long long);
extern void LeaveDebugSection(void);
extern void ValidateRetainBuffer(void);
extern void InValidateRetainBuffer(void);

#define __ReForceOutput_case_p(TYPENAME)                                                            \
        case TYPENAME##_P_ENUM :                                                                    \
        case TYPENAME##_O_ENUM :                                                                    \
            {                                                                                       \
                char *next_cursor = force_buffer_cursor + sizeof(TYPENAME);                         \
                if(next_cursor <= force_buffer_end ){                                               \
                    /* outputs real value must be systematically forced */                          \
                    if(vartype == TYPENAME##_O_ENUM)                                                \
                        /* overwrite value pointed by backup */                                     \
                        *((TYPENAME *)force_list_apply_cursor->value_pointer_backup) =  \
                            *((TYPENAME *)force_buffer_cursor);                                     \
                    /* inc force_buffer cursor */                                                   \
                    force_buffer_cursor = next_cursor;                                              \
                }else{                                                                              \
                    stop = 1;                                                                       \
                }                                                                                   \
            }                                                                                       \
            break;
void __publish_debug(void)
{
    InValidateRetainBuffer();
    
#ifndef TARGET_ONLINE_DEBUG_DISABLE 
    /* Check there is no running debugger re-configuration */
    if(TryEnterDebugSection()){
        /* Lock buffer */
        long latest_state = AtomicCompareExchange(
            &trace_buffer_state,
            BUFFER_EMPTY,
            BUFFER_FULL);
            
        /* If buffer was free */
        if(latest_state == BUFFER_EMPTY)
        {
            int stop = 0;
            /* Reset force list cursor */
            force_list_apply_cursor = force_list;

            /* iterate over force list */
            while(!stop && force_list_apply_cursor < force_list_addvar_cursor){
                dbgvardsc_t *dsc = &dbgvardsc[
                    force_list_apply_cursor->dbgvardsc_index];
                void *varp = dsc->ptr;
                __IEC_types_enum vartype = dsc->type;
                switch(vartype){
                    __ANY(__ReForceOutput_case_p)
                default:
                    break;
                }
                force_list_apply_cursor++;
            }

            /* Reset buffer cursor */
            trace_buffer_cursor = trace_buffer;
            /* Reset trace list cursor */
            trace_list_collect_cursor = trace_list;

            /* iterate over trace list */
            while(trace_list_collect_cursor < trace_list_addvar_cursor){
                void *value_p = NULL;
                size_t size;
                char* next_cursor;

                dbgvardsc_t *dsc = &dbgvardsc[
                    trace_list_collect_cursor->dbgvardsc_index];

                UnpackVar(dsc, &value_p, NULL, &size);

                /* copy visible variable to buffer */;
                if(__Is_a_string(dsc)){
                    /* optimization for strings */
                    /* assume NULL terminated strings */
                    size = ((STRING*)value_p)->len + 1;
                }

                /* compute next cursor positon.*/
                next_cursor = trace_buffer_cursor + size;
                /* check for buffer overflow */
                if(next_cursor < trace_buffer_end)
                    /* copy data to the buffer */
                    memcpy(trace_buffer_cursor, value_p, size);
                else
                    /* stop looping in case of overflow */
                    break;
                /* increment cursor according size*/
                trace_buffer_cursor = next_cursor;
                trace_list_collect_cursor++;
            }
            
            /* Leave debug section,
             * Trigger asynchronous transmission 
             * (returns immediately) */
            InitiateDebugTransfer(); /* size */
        }
        LeaveDebugSection();
    }
#endif
    unsigned int retain_offset = 0;
    /* when not debugging, do only retain */
    retain_list_collect_cursor = 0;

    /* iterate over retain list */
    while(retain_list_collect_cursor < retain_list_size){
        void *value_p = NULL;
        size_t size;
        char* next_cursor;

        dbgvardsc_t *dsc = &dbgvardsc[
            retain_list[retain_list_collect_cursor]];

        UnpackVar(dsc, &value_p, NULL, &size);

        /* if buffer not full */
        Retain(retain_offset, size, value_p);
        /* increment cursor according size*/
        retain_offset += size;

        retain_list_collect_cursor++;
    }
    ValidateRetainBuffer();
}

#ifndef TARGET_ONLINE_DEBUG_DISABLE

#define TRACE_LIST_OVERFLOW    1
#define FORCE_LIST_OVERFLOW    2
#define FORCE_BUFFER_OVERFLOW  3

#define __ForceVariable_case_t(TYPENAME)                                                \
        case TYPENAME##_ENUM :                                                          \
            /* add to force_list*/                                                      \
            force_list_addvar_cursor->dbgvardsc_index = idx;                            \
            ((__IEC_##TYPENAME##_t *)varp)->flags |= __IEC_FORCE_FLAG;                  \
            ((__IEC_##TYPENAME##_t *)varp)->value = *((TYPENAME *)force);               \
            break;
#define __ForceVariable_case_p(TYPENAME)                                                \
        case TYPENAME##_P_ENUM :                                                        \
        case TYPENAME##_O_ENUM :                                                        \
            {                                                                           \
                char *next_cursor = force_buffer_cursor + sizeof(TYPENAME);             \
                if(next_cursor <= force_buffer_end ){                                   \
                    /* add to force_list*/                                              \
                    force_list_addvar_cursor->dbgvardsc_index = idx;                    \
                    /* save pointer to backup */                                        \
                    force_list_addvar_cursor->value_pointer_backup =                    \
                        ((__IEC_##TYPENAME##_p *)varp)->value;                          \
                    /* store forced value in force_buffer */                            \
                    *((TYPENAME *)force_buffer_cursor) = *((TYPENAME *)force);          \
                    /* replace pointer with pointer to force_buffer */                  \
                    ((__IEC_##TYPENAME##_p *)varp)->value =                             \
                        (TYPENAME *)force_buffer_cursor;                                \
                    (((__IEC_##TYPENAME##_p *)varp)->fvalue) = *((TYPENAME *)force);    \
                    /* mark variable as forced */                                       \
                    ((__IEC_##TYPENAME##_p *)varp)->flags |= __IEC_FORCE_FLAG;          \
                    /* inc force_buffer cursor */                                       \
                    force_buffer_cursor = next_cursor;                                  \
                    /* outputs real value must be systematically forced */              \
                    if(vartype == TYPENAME##_O_ENUM)                                    \
                        *(((__IEC_##TYPENAME##_p *)varp)->value) = *((TYPENAME *)force);\
                } else {                                                                \
                    error_code = FORCE_BUFFER_OVERFLOW;                                 \
                    goto error_cleanup;                                                 \
                }                                                                       \
            }                                                                           \
            break;


void ResetDebugVariables(void);

int RegisterDebugVariable(dbgvardsc_index_t idx, void* force)
{
    int error_code = 0;
    if(idx < sizeof(dbgvardsc)/sizeof(dbgvardsc_t)){
        /* add to trace_list, inc trace_list_addvar_cursor*/
        if(trace_list_addvar_cursor <= trace_list_end){
            trace_list_addvar_cursor->dbgvardsc_index = idx;
            trace_list_addvar_cursor++;
        } else {
            error_code = TRACE_LIST_OVERFLOW;
            goto error_cleanup;
        }
        if(force){
            if(force_list_addvar_cursor <= force_list_end){
                dbgvardsc_t *dsc = &dbgvardsc[idx];
                void *varp = dsc->ptr;
                __IEC_types_enum vartype = dsc->type;

                switch(vartype){
                    __ANY(__ForceVariable_case_t)
                    __ANY(__ForceVariable_case_p)
                default:
                    break;
                }
                /* inc force_list cursor */
                force_list_addvar_cursor++;
            } else {
                error_code = FORCE_LIST_OVERFLOW;
                goto error_cleanup;
            }
        }
    }
    return 0;

error_cleanup:
    ResetDebugVariables();
    trace_buffer_state = BUFFER_EMPTY;
    return error_code;
    
}

#define ResetForcedVariable_case_t(TYPENAME)                                            \
        case TYPENAME##_ENUM :                                                          \
            ((__IEC_##TYPENAME##_t *)varp)->flags &= ~__IEC_FORCE_FLAG;                 \
            /* for local variable we don't restore original value */                    \
            /* that can be added if needed, but it was like that since ever */          \
            break;

#define ResetForcedVariable_case_p(TYPENAME)                                            \
        case TYPENAME##_P_ENUM :                                                        \
        case TYPENAME##_O_ENUM :                                                        \
            ((__IEC_##TYPENAME##_p *)varp)->flags &= ~__IEC_FORCE_FLAG;                 \
            /* restore backup to pointer */                                             \
            ((__IEC_##TYPENAME##_p *)varp)->value =                                     \
                force_list_apply_cursor->value_pointer_backup;                          \
            break;

void ResetDebugVariables(void)
{
    /* Reset trace list */
    trace_list_addvar_cursor = trace_list;

    force_list_apply_cursor = force_list;
    /* Restore forced variables */
    while(force_list_apply_cursor < force_list_addvar_cursor){
        dbgvardsc_t *dsc = &dbgvardsc[
            force_list_apply_cursor->dbgvardsc_index];
        void *varp = dsc->ptr;
        switch(dsc->type){
            __ANY(ResetForcedVariable_case_t)
            __ANY(ResetForcedVariable_case_p)
        default:
            break;
        }
        /* inc force_list cursor */
        force_list_apply_cursor++;
    } /* else TODO: warn user about failure to force */ 

    /* Reset force list */
    force_list_addvar_cursor = force_list;
    /* Reset force buffer */
    force_buffer_cursor = force_buffer;
}

void FreeDebugData(void)
{
    /* atomically mark buffer as free */
    AtomicCompareExchange(
        &trace_buffer_state,
        BUFFER_FULL,
        BUFFER_EMPTY);
}
int WaitDebugData(unsigned long *tick);
/* Wait until debug data ready and return pointer to it */
int GetDebugData(unsigned long *tick, unsigned long *size, void **buffer){
    int wait_error = WaitDebugData(tick);
    if(!wait_error){
        *size = trace_buffer_cursor - trace_buffer;
        *buffer = trace_buffer;
    }
    return wait_error;
}
#endif
#endif
