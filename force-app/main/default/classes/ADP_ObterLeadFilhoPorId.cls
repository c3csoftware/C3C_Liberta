public without sharing class ADP_ObterLeadFilhoPorId extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((IBuscarInfomacoesLeadFilhoService) C3C_DIContainer_Injector.getInstance('BuscarInfomacoesLeadFilhoService')).obterLeadFilhoPorId((String)mapParams.get('idRegistro'));
    }
}