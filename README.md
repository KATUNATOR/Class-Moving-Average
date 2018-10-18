# Class Moving Average

Indicator for metatrading in MQL5

The idea is based on the Moving Average's smoothing. This class can be used for smoothing some array of double without standart indicator. 

Class's instance requires:

To fill up: double in_mas[];
To set values: int in_period (smooth period), int in_dim (array's size);
Call procedure ini() for the array's initialization;
Call procedure zap_mas2(), which creates smoothed array of double out_mas[].
line.mq5 stores the example of using the class.

[MA in real life!](MA.png)
