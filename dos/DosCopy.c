/*!

   @file doscopy.c

   @brief DosCopy API's implementation. Based on RCOPY.

   (c) osFree Project 2008, <http://www.osFree.org>
   for licence see licence.txt in root directory, or project website

   @author Yuri Prokushev <prokushev@freemail.ru>

   @todo Add support of EAs

*/

#include <string.h>
#include <sys/stat.h>

#define INCL_DOSERRORS
#include <os2.h>
// Safe functions
//#include "strnlen.h"
//#include "strlcpy.h"
//#include "strlcat.h"

//#include "strlcmp.h"

/*!
   @brief Copies/moves file trees from one location to another

   @param pszSrc             name of source file
   @param pszDst             name of destination (may be existent)
   @param ulOptions          copy options

   @return
     NO_ERROR           - files were processed succesfully
     ERROR_WRITE_FAULT  - fault during file writing
     other              - according errors in used APIs

   API
     DosAllocSeg
     DosFreeSeg
     DosOpen
     DosClose
     DosRead
     DosWrite
     DosChgFilePtrL
     DosCreateDir
     DosDeleteDir
     DosDelete
     DosFindFirst
     DosFindNext
     DosFindClose
     DosQueryPathInfo
*/


#define IOBUF_SIZ       32768U                  /* enough? (performance)
                                                   Most probably here
                                                   we must automatically
                                                   detect size of buffer */

USHORT InternalCopyFile(PSZ pszSrc, PSZ pszDst, ULONG ulOptions)
{
  USHORT rc;
  HFILE  hSrc;
  HFILE  hDst;
  USHORT usAction;
  SEL pIOBuf;
  USHORT usTransfer;
  USHORT usWritten;
  ULONG  ulOpenType;
  LONG   lZero;

  lZero=0;

  rc = DosAllocSeg(IOBUF_SIZ,
                   &pIOBuf,
                   0);
  if (rc) return rc;

  rc = DosOpen(pszSrc,             // Address of ASCIIZ with source path
                &hSrc,              // Handle
                &usAction,          // Action was taken (not used)
                lZero,             // Initial file size (not used)
                0,                  // File attributes (not used)
                OPEN_ACTION_FAIL_IF_NEW |
                OPEN_ACTION_OPEN_IF_EXISTS, // Open type
                OPEN_SHARE_DENYNONE |
                OPEN_ACCESS_READONLY, // Open mode
                0);
  if (rc)
  {
    DosClose(hSrc);
    DosFreeSeg(pIOBuf);
    return rc;
  }

  if (!(ulOptions&DCPY_EXISTING))
  {
    // if no file exists then we fail
    ulOpenType = OPEN_ACTION_FAIL_IF_EXISTS;
  } else {
    if (ulOptions&DCPY_APPEND)
    {
      // else or append
      ulOpenType = OPEN_ACTION_OPEN_IF_EXISTS;
    } else {
      // or replace
      ulOpenType = OPEN_ACTION_REPLACE_IF_EXISTS;
    }
  }

  rc = DosOpen(pszDst,             // Address of ASCIIZ with source path
                &hDst,              // Handle
                &usAction,          // Action was taken
                lZero,             // Initial file size (not used)
                FILE_ARCHIVED |
                FILE_NORMAL, // File attributes
                OPEN_ACTION_CREATE_IF_NEW |
                ulOpenType, // Open type
                OPEN_SHARE_DENYREADWRITE |
                OPEN_ACCESS_WRITEONLY, // Open mode
                0);
  if (rc)
  {
    DosClose(hDst);
    DosClose(hSrc);
    DosFreeSeg(pIOBuf);
    return rc;
  }


  // If append mode move file pointer to the end
  // We can be here only if not DCY_EXISTING flag
  // set because DosOpenL will fail
  // In case of APPEND we need to move to end of file (because file open
  // with OPEN_ACCESS_OPEN_IF_EXISTS) otherwise
  if (ulOptions&DCPY_APPEND)
  {
    DosChgFilePtr (hDst,
                    lZero,
                    FILE_END,
                    NULL);
  }

  rc = DosRead(hSrc, &pIOBuf, IOBUF_SIZ, &usTransfer);
  if (rc)
  {
    DosClose(hDst);
    DosClose(hSrc);
    DosFreeSeg(pIOBuf);
    return rc;
  }

  while(usTransfer)
  {
    rc = DosWrite(hDst, &pIOBuf, usTransfer, &usWritten);
    if (rc)
    {
      DosClose(hDst);
      DosClose(hSrc);
      DosFreeSeg(pIOBuf);
      return rc;
    }

    if (usTransfer!=usWritten) return ERROR_WRITE_FAULT;

    rc = DosRead(hSrc, &pIOBuf, IOBUF_SIZ, &usTransfer);
    if (rc)
    {
      DosClose(hDst);
      DosClose(hSrc);
      DosFreeSeg(pIOBuf);
      return rc;
    }
  }

  DosClose(hDst);
  DosClose(hSrc);
  DosFreeSeg(pIOBuf);
  return NO_ERROR;
}

/*#
 * NAME
 *      InternalCheckPath
 * CALL
 *      CheckPath(path,create)
 * PARAMETER
 *      path            absolute directory name
 *      create          create directory if not existing
 * RETURNS
 *      0               directory is now existing
 *      /0              file, not existing, etc.
 * GLOBAL
 *      none
 * DESPRIPTION
 * REMARKS
 */
int
InternalCheckPath(char *path,int create)
{
    char   dir[CCHMAXPATH];
    struct stat stbuf;

    _fstrncpy( dir, path, CCHMAXPATH );
    if( dir[_fstrlen(dir)-1] == '/'  &&  dir[_fstrlen(dir)-2] != ':' )
        dir[_fstrlen(dir)-1] = '\0';
        /* TODO!!!!!! We need to check is directory exists here. Most probably via dosfindfirst...
    if( stat(dir, &stbuf) != 0 )
    {
        if( !create )
        {
//            Verbose(1,"stat(%s) - errno %u (%s)", dir, errno, strerror(errno) );
            return 0;//errno;
        }
        else
        {
            if( DosCreateDir(dir, NULL))
            {
//                Verbose(1,"mkdir(%s) - errno %u (%s)",dir,errno,strerror(errno));
                return 0;//errno;
            }
        }
    }
    else
    {
        if( (stbuf.st_mode & S_IFMT) != S_IFDIR )
        {
//            Verbose(1,"stat(%s) - no directory",dir);
            return -1;
        }
    }
*/
    return 0;
}


/*!
    @brief Copy directory tree

    @param src             Source Path (existing)
    @param dst             Destination Path (existing)
    @param ulOption        copy options

    @return
        NO_ERROR               OK

 */
USHORT InternalCopyTree(PSZ pszSrc, PSZ pszDst, ULONG ulOptions, ULONG ulNeedDel)
{
    FILEFINDBUF  findBuffer;
    HDIR         hSearch;
    USHORT       cFound;
    USHORT       rc;
    int          result = 0, i;
    PCH          nsp, ndp;
    struct dirlist_t {
        char              src[CCHMAXPATH]; //@todo detect maximum path name!!!
        char              dst[CCHMAXPATH]; //@todo detect maximum path name!!!
        struct dirlist_t *next;
    } *pDirListRoot=NULL, *pDirList=NULL, *pHelp;

    nsp = pszSrc + _fstrlen(pszSrc);
    ndp = pszDst + _fstrlen(pszDst);

    /* Search all subdirectories */

    _fstrncpy( nsp, "*", CCHMAXPATH );
    hSearch = HDIR_SYSTEM;                      /* use system handle */
    cFound = 1;                                 /* only one at a time */
    rc = DosFindFirst(pszSrc,
                      &hSearch,
                      (((FILE_DIRECTORY << 8) | FILE_DIRECTORY))|FILE_DIRECTORY,
                      &findBuffer,
                      sizeof(findBuffer),
                      &cFound,
                      0);
    if( !rc )
        do
        {
            if( !strncmp(findBuffer.achName, ".", CCHMAXPATH)
               ||  !strncmp(findBuffer.achName, "..", CCHMAXPATH) )
                continue;
            if( !(findBuffer.attrFile & FILE_DIRECTORY) )
                continue;

            _fstrncpy( nsp, findBuffer.achName, CCHMAXPATH );
            _fstrncpy( ndp, findBuffer.achName, CCHMAXPATH );

            _fstrcat( pszSrc, "/" );
            _fstrcat( pszDst, "/" );


            if( pDirList )
            {
                rc = DosAllocSeg(sizeof(struct dirlist_t),
                                 (USHORT FAR *)&(pDirList->next),
                                 0);
//                assert( pDirList->next != NULL );
                pDirList = pDirList->next;
            }
            else
            {
                rc = DosAllocSeg(sizeof(struct dirlist_t),
                                 (USHORT FAR *)&(pDirListRoot),
                                 0);
                pDirList = pDirListRoot;
//                assert( pDirList != NULL );
            }
            pDirList->next = NULL;
            _fstrncpy( pDirList->src, pszSrc, CCHMAXPATH );
            _fstrncpy( pDirList->dst, pszDst, CCHMAXPATH );
        }
        while( !(rc=DosFindNext(hSearch, &findBuffer,
                                sizeof(findBuffer), &cFound)) );
    DosFindClose( hSearch );

    for( pHelp = pDirList = pDirListRoot; pDirList ; pHelp = pDirList )
    {
        pDirList = pDirList->next;
        if( (i=InternalCheckPath(pHelp->dst, 1)) )      /* create destination path */
        {
            result = i;
        }
        else
        {
            InternalCopyTree(pHelp->src, pHelp->dst, ulOptions, ulNeedDel );
        }
        DosFreeSeg((SEL)pHelp);
    }

    /* Copy the files in actual directory */

    _fstrncpy( nsp, "*", CCHMAXPATH );
    hSearch = HDIR_SYSTEM;                      /* use system handle */
    cFound = 1;                                 /* only one at a time */
    rc = DosFindFirst(pszSrc, &hSearch, FILE_NORMAL,
                      &findBuffer, sizeof(findBuffer), &cFound, 0);
    if( !rc )
        do
        {
            if( findBuffer.attrFile & FILE_DIRECTORY )
                continue;

            _fstrncpy( nsp, findBuffer.achName, CCHMAXPATH );
            _fstrncpy( ndp, findBuffer.achName, CCHMAXPATH );
            i = InternalCopyFile( pszSrc, pszDst, ulOptions );

            // Delete original file,
            // if needed
            if (ulNeedDel)
              DosDelete(pszSrc, 0);

            if( i != 0 )
                result = i;
        }
        while( !(rc=DosFindNext(hSearch, &findBuffer,
                                sizeof(findBuffer), &cFound)) );
    DosFindClose( hSearch );

    // Delete original dir,
    // if needed
    if (ulNeedDel)
      DosRmDir(pszSrc, 0);

    *nsp = '\0';
    *ndp = '\0';
    return result;
}

/*!
   @brief Copies file (directory) from one location to another

   @param pszOld     pointer to ASCIIZ filename, directory or character device
   @param pszNew     pointer to ASCIIZ target filename, directory or character device
   @param ulOptions  options to be used when processing files

Bit Description

2 DCPY_FAILEAS (0x00000004)
Discard the EAs if the source file contains EAs and the destination file system does not support EAs.

0 Discard the EAs (extended attributes) if the destination file system does not support EAs.

1 Fail the copy if the destination file system does not support EAs.

1 DCPY_APPEND (x00000002)
Append the source file to the target file's end of data.

0 Replace the target file with the source file.
1 Append the source file to the target file's end of data.

This is ignored when copying a directory, or if the target file does not exist.

0 DCPY_EXISTING (0x00000001)
Existing Target File Disposition.

0 Do not copy the source file to the target if the file name already exists within the target directory. If a single file is being copied and the target already exists, an error is returned.

1 Copy the source file to the target even if the file name already exists within the target directory.

Bit flag DCPY_FAILEAS can be used in combination with bit flag DCPY_APPEND or DCPY_EXISTING.

   @return
     NO_ERROR - files were processed succesfully
     ERROR_FILE_NOT_FOUND
     ERROR_PATH_NOT_FOUND
     ERROR_ACCESS_DENIED
     ERROR_NOT_DOS_DISK
     ERROR_SHARING_VIOLATION
     ERROR_SHARING_BUFFER_EXCEEDED
     ERROR_INVALID_PARAMETER
     ERROR_DRIVE_LOCKED
     ERROR_DISK_FULL
     ERROR_FILENAME_EXCED_RANGE
     ERROR_DIRECTORY
     ERROR_EAS_NOT_SUPPORTED
     ERROR_NEED_EAS_FOUND
     ERROR_NOT_ENOUGH_MEMORY

*/

USHORT APIENTRY DosCopy(PSZ pszOld, PSZ pszNew, USHORT a, ULONG ulOptions)
{
  USHORT fileAttr;
  USHORT rc;

//  #define DCPY_MASK ~(DCPY_EXISTING | DCPY_APPEND | DCPY_FAILEAS )
  #define DCPY_MASK ~(DCPY_EXISTING | DCPY_APPEND )

  //log("%s enter\n", __FUNCTION__);
  //log("pszOld=%s\n", pszOld);
  //log("pszNew=%s\n", pszNew);
  //log("ulOptions=%lx\n", ulOptions);

  //Check arguments
  if ((!pszOld) || (!pszNew)) return ERROR_INVALID_PARAMETER;
  // Also check for reserved options used
  if (ulOptions & DCPY_MASK) return ERROR_INVALID_PARAMETER;

  //Detect is source dir or file (also check is it exists)
  rc = DosQFileMode(pszOld,               // Path
                        &fileAttr,          // Address of return attrib buffer
                        0);

  if (rc)
  {
    goto DOSCOPY_EXIT;
  }

  // Perfom action based on source path type
  if (fileAttr & FILE_DIRECTORY)
  {
    // DCPY_APPEND flag not valid in directory copy
    rc = InternalCopyTree(pszOld, pszNew, ulOptions & ~DCPY_APPEND, 0);
  } else {
    rc = InternalCopyFile(pszOld, pszNew, ulOptions); // @todo pass options
  };

DOSCOPY_EXIT:
  //log("%s exit => %lx\n", __FUNCTION__, rc);
  return rc;
}


