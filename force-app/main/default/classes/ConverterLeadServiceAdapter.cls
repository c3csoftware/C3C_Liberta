public without sharing class ConverterLeadServiceAdapter extends C3C_APP_ServiceApplicationAdapter
{
    public override Map<String,String> getMapServiceMethodToClassMethod()
    {
        return new Map<String,String>
        {
            'converterLeadComMerge' => 'ADP_ConverterLeadComMerge'
        };
    }
}