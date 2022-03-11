public without sharing class ADP_CriarRelacaoDoEvento extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((IEventRelationService) C3C_DIContainer_Injector.getInstance('EventRelationService')).criarRelacaoDoEvento(
            (String) mapParams.get('idEvento'),
            (String) mapParams.get('idRelacao')
        );
    }
}