public without sharing class ADP_obterLeadFilhoListaIdLeadIdOport extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((ILeadFilhoService) C3C_DIContainer_Injector.getInstance('LeadFilhoService')).obterLeadFilhoPorListaIdLeadIdOportunidade(
            (List<String>) JSON.deserialize(mapParams.get('listaIdLeadIdOportunidade'), List<String>.class)
        );
    }
}