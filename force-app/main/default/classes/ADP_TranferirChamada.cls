public without sharing class ADP_TranferirChamada extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((ITaskCallService) C3C_DIContainer_Injector.getInstance('TaskCallService')).tranferirChamada(
            (String) mapParams.get('idTarefa'),
            (String) mapParams.get('ramalTransferencia')
        );
    }
}