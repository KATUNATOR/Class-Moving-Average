//+------------------------------------------------------------------+
//|                                                         line.mq5 |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Hinkel Kate"
#property link      "hinckel.katia@yandex.ru"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_plots   1
//--- plot Label1
#property indicator_label1  "Label1"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrLightGreen
#property indicator_style1  STYLE_SOLID
#property indicator_width1  3
//---
#include <csmooth.mqh>
//---
enum enum_smooth_type
  {
   _close,
   _open,
   _high,
   _low,
   _median_price,
   _typical_price,
   _weighted_close
  };
input enum_smooth_type smooth_type=_close;
//---
csmooth smooth1;
//--- input parameters
input int      period=20;
input int      dim=1000;
//--- indicator buffers
double         Label1Buffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,Label1Buffer,INDICATOR_DATA);
   smooth1.in_period=period;
   smooth1.in_dim=dim;
   smooth1.ini();
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   int j=0,i;
   for(i=rates_total-dim; i<rates_total; i++)
     {
      if(smooth_type==_close)
        {
         smooth1.in_mas[j]=close[i];
        }
      else if(smooth_type==_open)
        {
         smooth1.in_mas[j]=open[i];
        }
      else if(smooth_type==_high)
        {
         smooth1.in_mas[j]=high[i];
        }
      else if(smooth_type==_low)
        {
         smooth1.in_mas[j]=low[i];
        }
      else if(smooth_type==_median_price)
        {
         smooth1.in_mas[j]=(high[i]+low[i])/2;
        }
      else if(smooth_type==_typical_price)
        {
         smooth1.in_mas[j]=(high[i]+close[i]+low[i])/3;
        }
      else if(smooth_type==_weighted_close)
        {
         smooth1.in_mas[j]=(high[i]+low[i]+close[i]+close[i])/4;
        }
      else {}
      j+=1;
     }
   smooth1.zap_mas2();
   j=0;
// ArrayInitialize(Label1Buffer,EMPTY_VALUE);
   for(i=rates_total-dim; i<rates_total; i++)
     {
      Label1Buffer[i]=smooth1.out_mas[j];
      j+=1;
     }
   for(i=0; i<rates_total-dim+period; i++)
     {
      Label1Buffer[i]=EMPTY_VALUE;
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
