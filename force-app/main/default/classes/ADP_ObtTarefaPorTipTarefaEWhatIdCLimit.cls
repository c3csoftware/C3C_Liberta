public without sharing class ADP_ObtTarefaPorTipTarefaEWhatIdCLimit extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        System.debug('mapParams: ' + mapParams);
        ((IBuscarInformacoesTarefaService) C3C_DIContainer_Injector.getInstance('BuscarInformacoesTarefaService')).obterTarefaPorTipoDeTarefaEWhatIdComLimitacao((String)mapParams.get('relativo'), (String)mapParams.get('nomeTipoTarefa'));
    }
}