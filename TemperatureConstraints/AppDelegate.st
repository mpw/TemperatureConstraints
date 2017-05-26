
stdout println:'Will define class.'.

class AppDelegate  {

-<void>setupDeltablueConstraints
{
    self setupTemperatureConverter.
}

-<void>setupTemperatureConverter
{
    ivar:f |= (9.0/5.0) * ivar:c + 32 .
    ivar:c |= (ivar:f - 32) * (5.0/9.0).
    ivar:k |= ivar:c + 273.
    ivar:c |= ivar:k - 273.


    ivar:c =|= ivar:celsiusTextField/intValue.
    ivar:fahrenheitTextField/intValue =|= ivar:f.
    ivar:kelvinTextField/intValue =|= ivar:k.
}


}


stdout println:'Did define class.'.
