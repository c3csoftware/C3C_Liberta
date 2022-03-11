public without sharing class ADP_ObterTarefasChamadasDoUsuarioAtual extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((ITaskCallService) C3C_DIContainer_Injector.getInstance('TaskCallService')).obterTarefasChamadasDoUsuarioAtual();
    }
}