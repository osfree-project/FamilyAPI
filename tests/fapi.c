#define INCL_BASE
#include <os2.h>

#include "greatest.h"

TEST tst_viowrttty(void) {
	USHORT rc;
	rc=VioWrtTTY("", 0, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc=VioWrtTTY("cba", 3, 1);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_viowrtnchar(void) {
	USHORT  rc;

	rc = VioWrtNChar("c", 15, 9, 5, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioWrtNChar("c", 5, 9, 5, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	rc = VioWrtNChar("c", 5, 9, -1, 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioWrtNChar("c", 5, 9, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioWrtNChar("c", 5, -1, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	rc = VioWrtNChar("c", 5, 25, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	PASS();
}

TEST tst_viosetcurpos(void) {
	USHORT  rc;

	rc = VioSetCurPos(9, 5, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioSetCurPos(9, 5, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	rc = VioSetCurPos(9, -1, 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioSetCurPos(9, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioSetCurPos(-1, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	rc = VioSetCurPos(25, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	PASS();
}

TEST tst_vioscrollup(void) {
	USHORT  rc;

	rc = VioScrollUp(5, 5, 10, 10, 1, "cx", 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioScrollUp(5, 5, 10, 10, 1, "cx", 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_vioscrolldn(void) {
	USHORT  rc;

	rc = VioScrollDn(5, 5, 10, 10, 1, "cx", 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioScrollDn(5, 5, 10, 10, 1, "cx", 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_vioscrlock(void) {
	USHORT  rc;
	UCHAR status;

	rc = VioScrLock(1, &status, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	ASSERT_EQ_FMT(0, status, "%d");
	rc = VioScrLock(1, &status, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_vioscrunlock(void) {
	USHORT  rc;

	rc = VioScrUnLock(0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioScrUnLock(2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_viosetmode(void) {
	USHORT  rc;

	rc = VioSetMode(NULL, 0);
	ASSERT_EQ_FMT(ERROR_VIO_MODE, rc, "%d");
	rc = VioSetMode(NULL, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_viogetmode(void) {
	USHORT  rc;
	VIOMODEINFO mi;
	rc = VioGetMode(&mi, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioGetMode(&mi, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_viogetconfig(void) {
	USHORT  rc;
	VIOCONFIGINFO ci;
	rc = VioGetConfig(0, &ci, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioGetConfig(0, &ci, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_viosetansi(void) {
	USHORT  rc;

	rc = VioSetAnsi(0, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioSetAnsi(0, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_viosetcurtype(void) {
	USHORT  rc;
	VIOCURSORINFO ci;

	ci.yStart=1;
	ci.cEnd=4;

	rc = VioSetCurType(&ci, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioSetCurType(&ci, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_viogetcurtype(void) {
	USHORT  rc;
	VIOCURSORINFO ci;

	rc = VioGetCurType(&ci, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioGetCurType(&ci, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_viogetcurpos(void) {
	USHORT  rc;
	USHORT          Row;           /* Row return data */
	USHORT          Column; 

	rc = VioGetCurPos(&Row, &Column, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioGetCurPos(&Row, &Column, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

TEST tst_viogetansi(void) {
	USHORT  rc;
	USHORT indicator;

	rc = VioSetAnsi(0, 0);
	rc = VioGetAnsi(&indicator, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	ASSERT_EQ_FMT(0, indicator, "%d");
	rc = VioSetAnsi(1, 0);
	rc = VioGetAnsi(&indicator, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	ASSERT_EQ_FMT(1, indicator, "%d");
	rc = VioGetAnsi(NULL, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	PASS();
}

/*
TEST tst_vioderegister(void) {
	USHORT  rc;

	rc = VioDeRegister();
	ASSERT_EQ_FMT(0, rc, "%d");
	PASS();
}
*/

/*
TEST tst_vioregister(void) {
	USHORT  rc;

	rc = VioRegister("viotst.dll", "bvsmain", 0, 0);
	ASSERT_EQ_FMT(ERROR_VIO_REGISTER, rc, "%d");
	PASS();
}
*/

TEST tst_viowrtncell(void) {
	USHORT  rc;

	rc = VioWrtNCell("cx", 15, 9, 5, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioWrtNCell("c", 5, 9, 5, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	rc = VioWrtNCell("c", 5, 9, -1, 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioWrtNCell("c", 5, 9, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioWrtNCell("c", 5, -1, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	rc = VioWrtNCell("c", 5, 25, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	PASS();
}

TEST tst_viowrtcharstr(void) {
	USHORT  rc;

	rc = VioWrtCharStr("cxxxxxx", 15, 9, 5, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioWrtCharStr("c", 5, 9, 5, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	rc = VioWrtCharStr("c", 5, 9, -1, 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioWrtCharStr("c", 5, 9, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioWrtCharStr("c", 5, -1, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	rc = VioWrtCharStr("c", 5, 25, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	PASS();
}

TEST tst_viowrtcharstratt(void) {
	USHORT  rc;

	rc = VioWrtCharStrAtt("ccccc", 15, 9, 5, "x", 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioWrtCharStrAtt("c", 5, 9, 5, "x", 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	rc = VioWrtCharStrAtt("c", 5, 9, -1, "x", 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioWrtCharStrAtt("c", 5, 9, 81, "x", 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioWrtCharStrAtt("c", 5, -1, 81, "x", 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	rc = VioWrtCharStrAtt("c", 5, 25, 81, "x", 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	PASS();
}

TEST tst_viowrtcellstr(void) {
	USHORT  rc;

	rc = VioWrtCellStr("cxcxcxcxcxcx", 15, 9, 5, 0);
	ASSERT_EQ_FMT(0, rc, "%d");
	rc = VioWrtCellStr("c", 5, 9, 5, 2);
	ASSERT_EQ_FMT(ERROR_VIO_INVALID_HANDLE, rc, "%d");
	rc = VioWrtCellStr("c", 5, 9, -1, 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioWrtCellStr("c", 5, 9, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_COL, rc, "%d");
	rc = VioWrtCellStr("c", 5, -1, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	rc = VioWrtCellStr("c", 5, 25, 81, 0);
	ASSERT_EQ_FMT(ERROR_VIO_ROW, rc, "%d");
	PASS();
}


/* A test runs various assertions, then calls PASS(), FAIL(), or SKIP(). */
TEST beep(void) {
    int x = 1;
    /* Compare, with an automatic "1 != x" failure message */
    ASSERT_EQ(1, x);

    /* Compare, with a custom failure message */
    ASSERT_EQm("Yikes, x doesn't equal 1", 1, x);

    /* Compare, and if they differ, print both values,
     * formatted like `printf("Expected: %d\nGot: %d\n", 1, x);` */
    ASSERT_EQ_FMT(1, x, "%d");
    PASS();
}

/* DosAllocHuge tests */
TEST tst_dosallochuge(void) {
    #define NUMBER_OF_SEGMENTS 2
    #define BYTES_IN_LAST_SEGMENT 1040
    #define MAXIMUM_SEG_SIZE 4
    #define ALLOC_FLAG 0
 
    SEL    Selector;
    ULONG     MemAvailSize;  /* Size available (returned) */
    USHORT rc;

    rc = DosAllocHuge(NUMBER_OF_SEGMENTS,   /* # of 65536-byte segments */
                    BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    MAXIMUM_SEG_SIZE,       /* Max number of segments */
                    ALLOC_FLAG);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosMemAvail(&MemAvailSize);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocHuge((MemAvailSize/65536)+10,   /* # of 65536-byte segments */
                    BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    MAXIMUM_SEG_SIZE,       /* Max number of segments */
                    ALLOC_FLAG);            /* Allocation flags */
    ASSERT_EQ_FMT(ERROR_NOT_ENOUGH_MEMORY, rc, "%d");
    rc = DosAllocHuge(NUMBER_OF_SEGMENTS,   /* # of 65536-byte segments */
                    BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    MAXIMUM_SEG_SIZE,       /* Max number of segments */
                    SEG_GIVEABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocHuge(NUMBER_OF_SEGMENTS,   /* # of 65536-byte segments */
                    BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    MAXIMUM_SEG_SIZE,       /* Max number of segments */
                    SEG_GETTABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocHuge(NUMBER_OF_SEGMENTS,   /* # of 65536-byte segments */
                    BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    MAXIMUM_SEG_SIZE,       /* Max number of segments */
                    SEG_DISCARDABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocHuge(NUMBER_OF_SEGMENTS,   /* # of 65536-byte segments */
                    BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    MAXIMUM_SEG_SIZE,       /* Max number of segments */
                    SEG_GIVEABLE|SEG_DISCARDABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocHuge(NUMBER_OF_SEGMENTS,   /* # of 65536-byte segments */
                    BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    MAXIMUM_SEG_SIZE,       /* Max number of segments */
                    SEG_GETTABLE|SEG_DISCARDABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocHuge(NUMBER_OF_SEGMENTS,   /* # of 65536-byte segments */
                    BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    MAXIMUM_SEG_SIZE,       /* Max number of segments */
                    SEG_GIVEABLE|SEG_GETTABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocHuge(NUMBER_OF_SEGMENTS,   /* # of 65536-byte segments */
                    BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    MAXIMUM_SEG_SIZE,       /* Max number of segments */
                    SEG_GETTABLE|SEG_GETTABLE|SEG_DISCARDABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    PASS();
}

/* DosAllocSeg tests */
TEST tst_dosallocseg(void) {
    #define BYTES_IN_LAST_SEGMENT 1040
 
    SEL    Selector;
    ULONG     MemAvailSize;  /* Size available (returned) */
    USHORT rc;

    rc = DosAllocSeg(BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    0);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocSeg(BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    SEG_GIVEABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocSeg(BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    SEG_GETTABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocSeg(BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    SEG_DISCARDABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocSeg(BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    SEG_GIVEABLE|SEG_DISCARDABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocSeg(BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    SEG_GETTABLE|SEG_DISCARDABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocSeg(BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    SEG_GIVEABLE|SEG_GETTABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc = DosAllocSeg(BYTES_IN_LAST_SEGMENT,  /* # of bytes in last segment */
                    &Selector,              /* The 1st selector allocated */
                    SEG_GETTABLE|SEG_GETTABLE|SEG_DISCARDABLE);            /* Allocation flags */
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    rc=DosFreeSeg(Selector);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    PASS();
}

TEST tst_dosgetversion(void) {
    USHORT    Version;       /* Version numbers (returned) */
    USHORT    rc;

    rc=DosGetVersion(&Version);
    PASS();
}

TEST tst_dosqsysinfo(void) {
    USHORT    Length;       /* MaxPathLength (returned) */
    USHORT    rc;

    rc = DosQSysInfo(0, (PBYTE)&Length, 2);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    ASSERT_EQ_FMT(80, Length, "%d"); // Under DOS only!
    rc = DosQSysInfo(0, (PBYTE)&Length, 1);
    ASSERT_EQ_FMT(ERROR_BUFFER_OVERFLOW, rc, "%d");
    rc = DosQSysInfo(666, (PBYTE)&Length, 2);
    ASSERT_EQ_FMT(ERROR_INVALID_PARAMETER, rc, "%d");
    PASS();
}

TEST tst_dosmemavail(void) {
    ULONG     MemAvailSize;  /* Size available (returned) */
    USHORT    rc;

    rc = DosMemAvail(&MemAvailSize);
    ASSERT_EQ_FMT(NO_ERROR, rc, "%d");
    PASS();
}


/* Suites can group multiple tests with common setup. */
SUITE(dos) {
    RUN_TEST(tst_dosgetversion);
    RUN_TEST(tst_dosqsysinfo);
    RUN_TEST(tst_dosmemavail);
    RUN_TEST(tst_dosallochuge);
    RUN_TEST(tst_dosallocseg);
    RUN_TEST(tst_dosallocshrseg);
    RUN_TEST(tst_dosgetshrseg);
}

/* Suites can group multiple tests with common setup. */
SUITE(kbd) {
    RUN_TEST(beep);
}

/* Suites can group multiple tests with common setup. */
SUITE(mou) {
    RUN_TEST(beep);
}

/* Suites can group multiple tests with common setup. */
SUITE(nls) {
    RUN_TEST(beep);
}

/* Suites can group multiple tests with common setup. */
SUITE(vio) {
    RUN_TEST(tst_viogetansi);
    RUN_TEST(tst_viowrttty);
    RUN_TEST(tst_viowrtnchar);
    RUN_TEST(tst_viowrtncell);
    RUN_TEST(tst_viosetcurpos);
    RUN_TEST(tst_viosetmode);
    RUN_TEST(tst_viowrtcharstr);
    RUN_TEST(tst_viowrtcharstratt);
    RUN_TEST(tst_viowrtcellstr);
    RUN_TEST(tst_vioscrlock);
    RUN_TEST(tst_vioscrunlock);
    RUN_TEST(tst_viosetansi);
    RUN_TEST(tst_viogetmode);
    RUN_TEST(tst_viogetconfig);
    RUN_TEST(tst_viosetcurtype);
    RUN_TEST(tst_viogetcurtype);
    RUN_TEST(tst_viogetcurpos);
//    RUN_TEST(tst_vioderegister);
//    RUN_TEST(tst_vioregister);
    RUN_TEST(tst_vioscrollup);
    RUN_TEST(tst_vioscrolldn);
}

/* Add definitions that need to be in the test runner's main file. */
GREATEST_MAIN_DEFS();

int main(int argc, char **argv) {
	USHORT          Row;           /* Row return data */
	USHORT          Column; 
    GREATEST_MAIN_BEGIN();      /* command-line options, initialization. */

    VioGetCurPos(&Row, &Column, 10);

    /* Tests can also be gathered into test suites. */
    VioSetCurPos(24, 0, 0);
    RUN_SUITE(vio);
    VioSetCurPos(24, 0, 0);
    RUN_SUITE(dos);
    RUN_SUITE(kbd);
    RUN_SUITE(mou);
    RUN_SUITE(nls);

    GREATEST_MAIN_END();        /* display results */
}
