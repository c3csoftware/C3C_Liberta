public without sharing class ADP_CriarAtualizarTarefaRedirecLigacao extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((ITaskCallService) C3C_DIContainer_Injector.getInstance('TaskCallService')).criarAtualizarTarefaRedirecionamentoLigacao(
            (String) mapParams.get('idTarefa'),
            (String) mapParams.get('assunto'),
            (String) mapParams.get('numeroDestino'),
            (Boolean) JSON.deserialize(mapParams.get('redirecionamentoLigacao'), Boolean.class)
        );
    }
}