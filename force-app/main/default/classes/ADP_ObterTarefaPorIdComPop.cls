public with sharing class ADP_ObterTarefaPorIdComPop extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((IBuscarPopTarefaService) C3C_DIContainer_Injector.getInstance('BuscarPopTarefaService')).obterTarefaPorIdComPop(
            (String) mapParams.get('idRegistro')
        );
    }
}