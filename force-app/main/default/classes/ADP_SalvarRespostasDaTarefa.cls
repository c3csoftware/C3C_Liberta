public without sharing class ADP_SalvarRespostasDaTarefa extends C3C_APP_ServiceApplicationAdapter.ClassMethod
{
    public override void callMethod()
    {
        Map<String,String> mapParams = C3C_APP_ApplicationContext.getBody();
        
        ((IChecklistService) C3C_DIContainer_Injector.getInstance('ChecklistService')).salvarRespostasDaTarefa(
            (String) mapParams.get('idTarefa'),
            (List<PerguntaViewModel>) JSON.deserialize(mapParams.get('listaDePerguntasDaTarefa'), List<PerguntaViewModel>.class)
        );
    }
}