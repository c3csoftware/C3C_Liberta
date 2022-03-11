public without sharing class ADP_SalvarInforAcessoCallboxUsuarioAtual extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((IAcessoCallboxService) C3C_DIContainer_Injector.getInstance('AcessoCallboxService')).salvarInformacoesAcessoCallboxUsuarioAtual(
            (String) mapParams.get('ramalUsuario'),
            (String) mapParams.get('senhaCallbox')
        );
    }
}