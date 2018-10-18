//+------------------------------------------------------------------+
//|                                                      csmooth.mqh |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Hinkel Kate"
#property link      "hinckel.katia@yandex.ru"
#property version   "1.00"
//+------------------------------------------------------------------+
//| csmooth class                                                    |
//+------------------------------------------------------------------+
class csmooth
  {
private:
   double            smooth(int a);
public:
                     csmooth();
                    ~csmooth();
   double            in_mas[];
   double            out_mas[];
   void              ini();
   void              zap_mas2();
   int               in_period;
   int               in_dim;
  };
//+------------------------------------------------------------------+
//| Class constructor                                                |
//+------------------------------------------------------------------+
csmooth::csmooth()
  {
  }
//+------------------------------------------------------------------+
//| Class destructor                                                 |
//+------------------------------------------------------------------+
csmooth::~csmooth()
  {
  }
//+------------------------------------------------------------------+
//| smooth                                                           |
//+------------------------------------------------------------------+
double csmooth::smooth(int a)
  {
   double smoth=0;
   double sum=0;
   for(int i=a; i>a-(in_period); i--)
     {
      sum+=in_mas[i];
     }
   smoth=sum/in_period;
   return(smoth);
  }
//+------------------------------------------------------------------+
//| zap_mas2                                                         |
//+------------------------------------------------------------------+
void csmooth::zap_mas2()
  {
   for(int i=in_dim-1; i>in_period-1; i--)
     {
      out_mas[i]=smooth(i);
     }
  }
//+------------------------------------------------------------------+
//| ini                                                              |
//+------------------------------------------------------------------+
void csmooth::ini(void)
  {
   ArrayResize(in_mas,in_dim);
   ArrayResize(out_mas,in_dim);
  }
//+------------------------------------------------------------------+
