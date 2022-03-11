public without sharing class ADP_ObterInforLoginCallBoxUsuarioAtual extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((IAcessoCallBoxService) C3C_DIContainer_Injector.getInstance('AcessoCallBoxService')).obterInformacoesDoLoginCallBoxDoUsuarioAtual();
    }
}