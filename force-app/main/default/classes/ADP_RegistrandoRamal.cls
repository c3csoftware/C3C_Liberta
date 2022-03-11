public without sharing class ADP_RegistrandoRamal extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((IAcessoCallBoxService) C3C_DIContainer_Injector.getInstance('AcessoCallBoxService')).registrandoRamal((String) mapParams.get('ramal'), (String) mapParams.get('identificacaoGuia'));
    }
}