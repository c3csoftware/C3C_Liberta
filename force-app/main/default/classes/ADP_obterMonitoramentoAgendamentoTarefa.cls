public without sharing class ADP_obterMonitoramentoAgendamentoTarefa extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((IAgendamentoTarefaService) C3C_DIContainer_Injector.getInstance('AgendamentoTarefaService')).obterMonitoramentoAgendamentoTarefa(
            (String) mapParams.get('idRegistro')
        );
    }
}