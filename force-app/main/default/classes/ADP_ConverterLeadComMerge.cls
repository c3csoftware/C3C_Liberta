public without sharing class ADP_ConverterLeadComMerge extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((IConverterLeadService) C3C_DIContainer_Injector.getInstance('ConverterLeadService')).converterLeadComMerge(
            (String) mapParams.get('idRegistro')
        );
    }
}