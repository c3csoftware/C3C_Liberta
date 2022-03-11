public with sharing class ADP_AtualizarWhatIdParaWhoId extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((IAtualizarTarefaService) C3C_DIContainer_Injector.getInstance('AtualizarTarefaService')).atualizarWhatIdParaWhoId(
            (String) mapParams.get('idRegistro')
        );
    }
}