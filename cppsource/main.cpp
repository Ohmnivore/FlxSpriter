#define IMPLEMENT_API
#include <hx/CFFI.h>

//#include <windows.h>

//static void SetTopMost(value WinName, value OnTop)
//{
//    HWND hWnd = FindWindow((LPCTSTR)val_string(WinName), NULL);
//
//    HWND mode = HWND_NOTOPMOST;
//    if (val_bool(OnTop) == true)
//        mode = HWND_TOPMOST;
//
//   ::SetWindowPos( hWnd, mode, 0, 0 , 0 , 0, SWP_NOMOVE | SWP_NOSIZE );
//
//   return;
//}

static void SetTopMost(value WinName, value OnTop)
{

}

DEFINE_PRIM(SetTopMost, 2);
